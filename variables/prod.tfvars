environment                  = "prod"
aws_vpc_id                   = "vpc-03f8aef4118d8c091"
vault_address                = "https://vault-cluster.vault.aws.hashicorp.cloud:8200"
export_bucket_iam_role       = "63886da94c25904957e3c213"
snapshots_export_bucket_name = "synergy-mongo-backups-prod"

mongo_clusters = {
  baseball = {
    instance_size   = "M60_NVME"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 51200
    disk_size_gb    = null
    deploy          = true
  }
  basketball = {
    instance_size   = "R60"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 51200
    disk_size_gb    = null
    deploy          = true
  }
  collapsible = {
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 2868
    disk_size_gb    = null
    deploy          = true
  }
  delivery = {
    instance_size   = "M30"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 38912
    disk_size_gb    = null
    deploy          = true
  }
  editor = {
    instance_size   = "R40"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 38912
    disk_size_gb    = null
    deploy          = true
  }
  hockey = {
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 2048
    disk_size_gb    = null
    deploy          = true
  }
  operations = {
    instance_size   = "M30"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 51200
    disk_size_gb    = null
    deploy          = true
  }
  payroll = {
    instance_size   = "M50"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 51200
    disk_size_gb    = 530
    deploy          = true
  }
  rsdata = {
    instance_size   = "R60"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 51200
    disk_size_gb    = null
    deploy          = true
  }
  scraped = {
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 2048
    disk_size_gb    = null
    deploy          = true
  }
  security = {
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 2048
    disk_size_gb    = null
    deploy          = true
  }
  upload = {
    instance_size   = "M50"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 51200
    disk_size_gb    = null
    deploy          = true
  }
  football-s3p = {
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 4096
    disk_size_gb    = null
    deploy          = true
  }
}

iam_roles = {
}
