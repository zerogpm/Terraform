#--- root/local.tf

locals {
  vpc_cidr = "10.0.0.0/16"
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
          from        = 8080
          to          = 8080
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        nginx = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
      }
    }
    alb = {
      name        = "public_alb_sg"
      description = "security group for alb public Access"
      ingress = {
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        https = {
          from        = 443
          to          = 443
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
          cidr_blocks = [local.vpc_cidr]
        }
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [local.vpc_cidr]
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
          cidr_blocks = [local.vpc_cidr]
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
          cidr_blocks = [var.my_personal_ip]
        }
      }
    }
  }
}