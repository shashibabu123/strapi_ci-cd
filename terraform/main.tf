provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "strapi_ec2" {
  ami           = "ami-0c02fb55956c7d316"  
  instance_type = "t2.micro"
  key_name      = "strapi-key-"

  user_data = file("${path.module}/user-data.sh")

  tags = {
    Name = "StrapiEC2"
  }
}

resource "aws_security_group" "strapi_sg" {
  name        = "strapi_sg"
  description = "Allow port 1337"

  ingress {
    from_port   = 1337
    to_port     = 1337
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

