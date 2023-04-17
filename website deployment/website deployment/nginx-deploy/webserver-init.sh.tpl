#!/bin/bash

sudo apt update

sudo apt install awscli -y

mkdir /home/ubuntu/.aws/
touch /home/ubuntu/.aws/config
touch /home/ubuntu/.aws/credentials

echo "[default]" >> /home/ubuntu/.aws/config
echo "[default]" >> /home/ubuntu/.aws/credentials
echo "aws_access_key_id=${access_key}" >> /home/ubuntu/.aws/credentials
echo "aws_secret_access_key=${secret_key}" >> /home/ubuntu/.aws/credentials
echo "region=us-east-1" >> /home/ubuntu/.aws/config
echo "output=json" >> /home/ubuntu/.aws/config

runuser -l ubuntu -c 'aws s3 cp s3://terra-bucket-testpage/pullconfig.sh /home/ubuntu/'
sudo chown ubuntu:ubuntu /home/ubuntu/pullconfig.sh
sudo chmod +x /home/ubuntu/pullconfig.sh
/bin/bash /home/ubuntu/pullconfig.sh 
