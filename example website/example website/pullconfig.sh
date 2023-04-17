#!/bin/bash

echo "i ran" > /home/ubuntu/out.txt
sudo apt update

sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
sudo chown -R ubuntu:ubuntu /var/www/

runuser -l ubuntu -c 'aws s3 cp s3://terra-bucket-testpage/example-site.tar /home/ubuntu/' > /home/ubuntu/s3out.txt
tar -xf /home/ubuntu/example-site.tar -C /home/ubuntu
cp /home/ubuntu/example-website/* /var/www/html/