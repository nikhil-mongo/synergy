environment   = "stage"
aws_vpc_id    = "vpc-0f23ef5a19605c43b"
vault_address = "https://vault-cluster.vault.aws.hashicorp.cloud:8200"

mongo_clusters = {
  baseball = {
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 2048
    disk_size_gb    = null
    deploy          = true
  }
  basketball = {
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 2048
    disk_size_gb    = null
    deploy          = true
  }
  collapsible = {
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 2048
    disk_size_gb    = null
    deploy          = true
  }
  delivery = {
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 2048
    disk_size_gb    = null
    deploy          = true
  }
  editor = {
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 2048
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
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 2048
    disk_size_gb    = null
    deploy          = true
  }
  payroll = {
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 2048
    disk_size_gb    = null
    deploy          = true
  }
  rsdata = {
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 2048
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
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 2048
    disk_size_gb    = null
    deploy          = true
  }
  football-s3p = {
    instance_size   = "M10"
    nodes           = 3
    mongodb_version = "6.0"
    oplog_size_mb   = 2048
    disk_size_gb    = null
    deploy          = true
  }
}

iam_roles = {
}
