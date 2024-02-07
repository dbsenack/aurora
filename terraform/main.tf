provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}

resource "aws_instance" "example" {
  ami           = "ami-0947d2ba12ee1ff75"  # Ubuntu 22.04 LTS AMI ID
  instance_type = "t3a.small"              

  root_block_device {
    volume_size = 128  # Size of the root block device in gigabytes
  }

  key_name = "Thinkpad2024.pem" 

  tags = {
    Name = "aurora"
  }
}

