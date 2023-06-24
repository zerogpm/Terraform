# Define Local Values in Terraform
locals {
  owners      = var.business_divsion
  environment = var.environment
  name        = "${var.business_divsion}-${var.environment}"
  #name = "${local.owners}-${local.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }

  user_data = <<-EOT
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl enable httpd
    sudo service httpd start  
    sudo echo '<h1>Welcome to APP-1</h1>' | sudo tee /var/www/html/index.html
    sudo mkdir /var/www/html/app1
    sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>APP-1</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/app1/index.html
  EOT

  asg_tags = [
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
    {
      key                 = "auto-scale-project"
      value               = "auto-scale"
      propagate_at_launch = true
    },
  ]
} 