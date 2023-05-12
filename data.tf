# data "aws_vpc" "main" {
#   id = var.aws_vpc_id
# }

# data "aws_subnets" "vpc_all" {
#   filter {
#     name   = "vpc-id"
#     values = [var.aws_vpc_id]
#   }
# }

# data "vault_generic_secret" "users_secret" {
#   path = "secrets/mongodb/users/${var.environment}"
# }