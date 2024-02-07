provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}

resource "aws_instance" "aurora" {
  ami           = "ami-0947d2ba12ee1ff75"  # Ubuntu 22.04 LTS AMI ID
  instance_type = "t3a.small"              

  root_block_device {
    volume_size = 128  # Size of the root block device in gigabytes
  }

  key_name = "thinkpad23" 

  tags = {
    Name = "aurora"
  }
}

data "aws_eip" "aurora_eip" {
  public_ip = var.aurora_eip
}

resource "aws_eip_association" "aurora_eip_association" {
  instance_id = aws_instance.aurora.id
  allocation_id = data.aws_eip.aurora_eip.id
  
}

output "ssh_connection" {
  value = "ssh -i ~/.keys/thinkpad23.pem ubuntu@${data.aws_eip.aurora_eip.public_ip}"
}

resource "null_resource" "write_ssh_to_file" {
  provisioner "local-exec" {
    command = "echo '${aws_instance.aurora.public_ip}' > ../ssh_connection_info.txt" 
  }

  depends_on = [aws_instance.aurora]
}
