variable "project_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "nodes" {
  type = number
}

variable "instance_size" {
  type = string
}

variable "provider_region_name" {
  type = string
}

variable "mongodb_version" {
  type = string
}

variable "oplog_size_mb" {
  type    = number
  default = null
}

variable "disk_size_gb" {
  type    = number
  default = null
}

variable "is_production" {
  type = bool
}

variable "snapshots_export_bucket_id" {
  type = string
}

variable "export_prod_snapshots" {
  type = bool
}

variable "update_existing_prod_snapshots" {
  type = bool
}

