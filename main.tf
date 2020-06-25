terraform {
  required_providers {
    aws = "2.43.0"
  }
}

### AWS ###
provider "aws" {
  region     = "eu-central-1"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

### Key Pair ###
resource "aws_key_pair" "my-ssh" {
  key_name = "my-ssh"
  public_key = "${var.ssh_pub_key}"
}

### Instances ###
resource "aws_instance" "web-server" {
  ami = "ami-0bad2b43a871348da"
  instance_type = "t2.micro"
  key_name = "my-ssh"
  security_groups = [ "MyFierwall-HTTP-HTTPS-SSH" ]
  tags = {
    Name  = "web-server"
  }
}

resource "aws_instance" "DB" {
  ami = "ami-0bad2b43a871348da"
  instance_type = "t2.micro"
  key_name = "my-ssh"
  security_groups = [ "default" ]
  tags = {
    Name  = "db"
  }
}
