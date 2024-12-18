provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

resource "aws_instance" "c8" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "mumbai" # Default PEM key name configured in AWS
  tags = {
    Name = "c8.local"
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "[frontend]" > ../inventory
      echo "c8.local ansible_host=${self.public_ip} ansible_user=ec2-user" >> ../inventory
    EOT
  }
}

resource "aws_instance" "u21" {
  ami           = "ami-0e2c8caa4b6378d8c" # Ubuntu 21.04 AMI (replace with your AMI ID)
  instance_type = "t2.micro"
  key_name      = "mumbai" # Default PEM key name configured in AWS
  tags = {
    Name = "u21.local"
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "[backend]" >> ../inventory
      echo "u21.local ansible_host=${self.public_ip} ansible_user=ubuntu" >> ../inventory
    EOT
  }
}

output "inventory_file_path" {
  value = "${path.module}/../inventory"
}
i
