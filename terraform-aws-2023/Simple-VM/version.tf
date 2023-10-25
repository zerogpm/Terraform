# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.22.0" # Optional but recommended in production
    }
  }
}
# Provider Block
provider "aws" {
  region = var.aws_region
}

/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/