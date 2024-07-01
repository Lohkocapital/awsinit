# main.tf

provider "aws" {
  region = "eu-west-1" # Change this to your desired AWS region
}

resource "aws_instance" "example" {
  ami           = "ami-0bb323ae9abcae1a0" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t3a.nano"

  tags = {
    Name = "teslate-dev"
  }

  # Use an existing key pair name or create a new one
  key_name = "lohko-aws"

  # Optional: Define the security group inline
  vpc_security_group_ids = ["sg-08d59b17bdd86b866"]
}

resource "aws_security_group" "instance" {
  name_prefix = "teslate-sg-"

  ingress {
    from_port   = 22
    to_port     = 22
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
