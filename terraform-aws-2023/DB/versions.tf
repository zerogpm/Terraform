# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.2.0" # Optional but recommended in production
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
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