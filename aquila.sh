#! /bin/bash
sudo yum update -y
sudo yum install -y httpd git
sudo systemctl start httpd
sudo systemctl enable httpd
sudo git clone https://github.com/AravindReddy91/AquilaCMS.git /var/www/html
