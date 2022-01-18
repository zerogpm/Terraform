#--- root/variables.tf ---

variable "aws_region" {
  default = "us-east-1"
}

variable "shared_credentials_file" {
  default = "/home/chris/.aws"
}

variable "profile" {
  default = "default"
}

variable "access_ip" {
  type = string
}

variable "my_personal_ip" {}

variable "dbname" {
  type = string
}

variable "dbuser" {
  type      = string
  sensitive = true
}

variable "dbpassword" {
  type      = string
  sensitive = true
}