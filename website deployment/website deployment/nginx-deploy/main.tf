provider "aws" {
  region     = "us-east-1"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

#create security group, allow ssh and http
resource "aws_security_group" "nginx-ssh-http" {
  name        = "terraform-nginx-http-ssh"
  description = "allowing http and ssh traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

data "template_file" "init" {
  template = file("webserver-init.sh.tpl")
  vars = {
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
  }
}

#creating the aws instance
resource "aws_instance" "webserver" {
  ami               = "ami-052efd3df9dad4825"
  instance_type     = "t1.micro"
  availability_zone = "us-east-1a"
  security_groups   = ["${aws_security_group.nginx-ssh-http.name}"]
  key_name          = "nginx-terraform"
  user_data         = data.template_file.init.rendered

  tags = {
    Name = "terraform-webserver"
  }
}
