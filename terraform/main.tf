provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "strapi_ec2" {
  ami           = var.ami_id
  instance_type = "t3.medium"
  user_data     = file("user_data.sh")

  tags = {
    Name = "StrapiApp"
  }

  # Enable SSM access
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm.name
}

resource "aws_iam_role" "ec2_ssm_role" {
  name = "ec2_ssm_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_ssm" {
  name = "ec2_ssm_profile"
  role = aws_iam_role.ec2_ssm_role.name
}

