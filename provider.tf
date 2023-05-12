provider "mongodbatlas" {
  public_key = var.mongodbatlas_public_key
  private_key  = var.mongodbatlas_private_key
}

provider "aws" {
  region  = var.aws_region
}

provider "vault" {
  address = var.vault_address
  namespace = "admin"

  auth_login {
    path = "auth/approle/login"
    namespace = "admin"

    parameters = {
      role_id            = var.role_id
      secret_id          = var.secret_id
      secret_id_accessor = var.secret_id_accessor
    }
  }
}
