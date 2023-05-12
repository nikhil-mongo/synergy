resource "mongodbatlas_cluster" "data" {
  project_id                   = var.project_id
  name                         = var.cluster_name
  cluster_type                 = "REPLICASET"
  provider_name                = "AWS"
  provider_region_name         = var.provider_region_name
  replication_factor           = var.nodes
  provider_instance_size_name  = var.instance_size
  mongo_db_major_version       = var.mongodb_version
  cloud_backup                 = true
  pit_enabled                  = var.is_production
  auto_scaling_disk_gb_enabled = true
  disk_size_gb                 = var.disk_size_gb

  advanced_configuration {
    oplog_size_mb = var.oplog_size_mb
  }

  lifecycle {
    ignore_changes = [provider_instance_size_name, disk_size_gb]
  }
}

locals {
  backup_hour_of_day    = 1
  backup_minute_of_hour = 0
}

resource "mongodbatlas_cloud_backup_schedule" "nonprod_policy" {
  count        = var.is_production ? 0 : 1
  project_id   = mongodbatlas_cluster.data.project_id
  cluster_name = mongodbatlas_cluster.data.name

  reference_hour_of_day    = local.backup_hour_of_day
  reference_minute_of_hour = local.backup_minute_of_hour

  policy_item_daily {
    frequency_interval = 1
    retention_unit     = "days"
    retention_value    = 7
  }
}

resource "mongodbatlas_cloud_backup_schedule" "prod_policy" {
  count                                    = var.is_production ? 1 : 0
  project_id                               = mongodbatlas_cluster.data.project_id
  cluster_name                             = mongodbatlas_cluster.data.name
  auto_export_enabled                      = var.export_prod_snapshots
  use_org_and_group_names_in_export_prefix = true
  reference_hour_of_day                    = local.backup_hour_of_day
  reference_minute_of_hour                 = local.backup_minute_of_hour
  restore_window_days                      = 2
  update_snapshots                         = var.update_existing_prod_snapshots

  export {
    export_bucket_id = var.snapshots_export_bucket_id
    frequency_type = "weekly"
  }

  policy_item_hourly {
    frequency_interval = 12
    retention_unit     = "days"
    retention_value    = 2
  }
  policy_item_daily {
    frequency_interval = 1
    retention_unit     = "days"
    retention_value    = 7
  }
  policy_item_weekly {
    frequency_interval = 1
    retention_unit     = "days"
    retention_value    = 7
  }
}