variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "access_key" {
  
}
variable "secret_key" {
  
}
variable "aws_vpc_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "mongo_clusters" {
  type        = map(any)
  description = "List of MongoDB clusters"
  default     = {}
}

# variable "iam_roles" {
#   type        = map(any)
#   description = "List of AWS IAM roles to access MongoDB clusters from EKS"
#   default     = {}
# }

variable "mongodbatlas_provider_region_name" {
  type    = string
  default = "US_EAST_1"
}

variable "mongodbatlas_public_key" {
  type = string
}

variable "mongodbatlas_private_key" {
  type = string
}

variable "mongodbatlas_org_id" {
  type = string
}

# variable "vault_address" {
#   type = string
# }

# variable "role_id" {
#   type = string
# }

# variable "secret_id" {
#   type = string
# }

# variable "secret_id_accessor" {
#   type = string
# }

variable "snapshots_export_bucket_name" {
  type    = string
  default = null
}

variable "export_bucket_iam_role" {
  type    = string
  default = null
}

variable "export_prod_snapshots" {
  type = bool
  default = true
}

variable "update_existing_prod_snapshots" {
  type = bool
  default = false
}
