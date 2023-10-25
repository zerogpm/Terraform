#! /bin/bash

# Instance Identity Metadata Reference - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html

sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start

# Fetch the public IP and region from instance metadata
public_ip=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
region=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')

sudo echo "<h1>Welcome to APP-1</h1>" | sudo tee /var/www/html/index.html
sudo echo "Public IP: $public_ip" | sudo tee -a /var/www/html/index.html
sudo echo "Region: $region" | sudo tee -a /var/www/html/index.html