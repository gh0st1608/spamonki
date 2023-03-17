# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA22XAJNR75THOGQAU"
  secret_key = "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"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  //ami = "" // NO ES ELEGANTE!
  instance_type = "t2.micro"
  key_name = "spamonki"

  user_data = "${file("runme.sh")}"

  tags = {
    Name = "spa-server"
  }
}

output "public_ip" {
  value       = aws_instance.web.public_ip
}