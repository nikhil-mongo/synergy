locals {
  on_prem_cidr    = ["10.1.0.0/16", "10.3.0.0/16", "10.11.0.0/16", "10.13.0.0/16", "10.113.32.0/20", "10.113.0.0/20"]
  deploy_clusters = {for k, c in var.mongo_clusters :  k => c if c.deploy == true}
  is_production   = var.environment == "prod"
  db_users        = [for username, userjson in data.vault_generic_secret.users_secret.data:
  {
    username     = username
    password     = jsondecode(userjson).password
    aws_iam_type = ""
    roles        = jsondecode(userjson).roles
    clusters     = jsondecode(userjson).clusters
  } if username != "list"]
  iam_users       = [for role in var.iam_roles:
  {
    username     = role.arn
    aws_iam_type = "ROLE"
    password     = ""
    roles        = role.roles
    clusters     = role.clusters
  }]
  users = setunion(local.db_users, local.iam_users)
}

resource "mongodbatlas_project" "data_project" {
  name   = join("-", ["data", var.environment])
  org_id = var.mongodbatlas_org_id
}

resource "mongodbatlas_cloud_backup_snapshot_export_bucket" "snapshots_bucket" {
  count          = local.is_production ? 1 : 0
  project_id     = mongodbatlas_project.data_project.id
  iam_role_id    = var.export_bucket_iam_role
  bucket_name    = var.snapshots_export_bucket_name
  cloud_provider = "AWS"

  lifecycle {
    create_before_destroy = true
  }
}

module "mongodb-cluster" {
  source                         = "./modules/mongodb-cluster"
  for_each                       = local.deploy_clusters
  project_id                     = mongodbatlas_project.data_project.id
  provider_region_name           = var.mongodbatlas_provider_region_name
  mongodb_version                = each.value.mongodb_version
  cluster_name                   = each.key
  instance_size                  = each.value.instance_size
  nodes                          = each.value.nodes
  oplog_size_mb                  = each.value.oplog_size_mb
  disk_size_gb                   = each.value.disk_size_gb
  is_production                  = local.is_production
  export_prod_snapshots          = var.export_prod_snapshots
  snapshots_export_bucket_id     = local.is_production ? mongodbatlas_cloud_backup_snapshot_export_bucket.snapshots_bucket[0].export_bucket_id : null
  update_existing_prod_snapshots = var.update_existing_prod_snapshots
}

resource "mongodbatlas_database_user" "user" {
  for_each           = { for user in nonsensitive(local.users) : user.username => user }
  username           = each.key
  password           = each.value.aws_iam_type == "" ? sensitive(each.value.password) : null
  project_id         = mongodbatlas_project.data_project.id
  auth_database_name = each.value.aws_iam_type == "" ? "admin" : "$external"
  aws_iam_type       = each.value.aws_iam_type != "" ? each.value.aws_iam_type : null

  dynamic "roles" {
    for_each = { for item in each.value.roles : "${item.role}_${item.database}" => item }
    content {
      role_name     = roles.value.role
      database_name = roles.value.database
    }
  }

  dynamic "scopes" {
    for_each = toset(each.value.clusters)
    content {
      type = "CLUSTER"
      name = scopes.value
    }
  }
}

resource "mongodbatlas_privatelink_endpoint" "pl" {
  project_id    = mongodbatlas_project.data_project.id
  provider_name = "AWS"
  region        = var.aws_region
}

resource "aws_security_group" "mongodb_atlas" {
  name        = join("-", ["atlas", var.environment])
  description = "Atlas security group"
  vpc_id      = var.aws_vpc_id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = concat(local.on_prem_cidr, [data.aws_vpc.main.cidr_block])
    ipv6_cidr_blocks = data.aws_vpc.main.ipv6_cidr_block != "" ? [data.aws_vpc.main.ipv6_cidr_block] : null
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = concat(local.on_prem_cidr, [data.aws_vpc.main.cidr_block])
    ipv6_cidr_blocks = data.aws_vpc.main.ipv6_cidr_block != "" ? [data.aws_vpc.main.ipv6_cidr_block] : null
  }

  tags = {
    Name = join("-", ["atlas", var.environment])
  }
}

resource "aws_vpc_endpoint" "ptfe_service" {
  vpc_id             = var.aws_vpc_id
  service_name       = mongodbatlas_privatelink_endpoint.pl.endpoint_service_name
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [data.aws_subnets.vpc_all.ids[0]]
  security_group_ids = [aws_security_group.mongodb_atlas.id]
}

resource "mongodbatlas_privatelink_endpoint_service" "privatelink" {
  project_id          = mongodbatlas_privatelink_endpoint.pl.project_id
  private_link_id     = mongodbatlas_privatelink_endpoint.pl.private_link_id
  endpoint_service_id = aws_vpc_endpoint.ptfe_service.id
  provider_name       = "AWS"
}
