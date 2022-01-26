#--- aws.modules/root/variables.tf ---

variable "aws_region" {
  default = "us-east-1"
}

variable "shared_credentials_file" {
  default = "/home/chris/.aws"
}

variable "profile" {
  default = "default"
}

variable "public_key_path" {}