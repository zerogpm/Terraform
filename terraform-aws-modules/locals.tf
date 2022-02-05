locals {
  vpc_cider = "10.0.0.0/16"
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
          cidr_blocks = [var.my_personal_ip]
        }
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        nginx = {
          from        = 8000
          to          = 8000
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
      }
    }
    private = {
      name        = "private_sg"
      description = "security group for private Access"
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [local.vpc_cider]
        }
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [local.vpc_cider]
        }
      }
    }
    rds = {
      name        = "rds_sg"
      description = "RDS access"
      ingress = {
        mysql = {
          from        = 3306
          to          = 3306
          protocol    = "tcp"
          cidr_blocks = [local.vpc_cider]
        }
      }
    }
    bastion_host = {
      name        = "bastion_sg"
      description = "bastion access"
      ingress = {
        bastion = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
      }
    }
  }
}