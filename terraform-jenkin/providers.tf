#--- terrform-jenkins/providers.tf ---
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                  = var.aws_region
  profile                 = var.profile
}