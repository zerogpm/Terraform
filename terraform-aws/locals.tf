#--- root/local.tf

locals {
  vpc_cidr = "10.123.0.0/16"
}

locals {
  security_group = {
    public = {
      name        = "public_sg"
      description = "security group for public Access"
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
      }
    }
  }
}