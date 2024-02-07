provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}

resource "aws_instance" "aurora" {
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

resource "aws_eip" "aurora_eip" {
  instance = aws_instance.aurora.id
  domain = "vpc"
}

output "ssh_connection" {
  value = "ssh -i ~/.keys/Thinkpad2024.pem ubuntu@${aws_eip.aurora_eip.public_ip}"
}

resource "null_resource" "write_ssh_to_file" {
  provisioner "local-exec" {
    command = "echo '${aws_instance.aurora.public_ip}' > ../ssh_connection_info.txt" 
  }

  depends_on = [aws_instance.aurora]
}
