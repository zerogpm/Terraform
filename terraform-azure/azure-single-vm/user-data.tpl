#! /bin/bash
sudo apt update
sudo apt install nginx -y
sudo echo '<h1>Welcome to APP-1</h1>' | sudo tee /var/www/html/index.nginx-debian.html