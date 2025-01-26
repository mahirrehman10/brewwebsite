# main.tf

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow inbound traffic for web application"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

resource "aws_instance" "web_instance" {
  ami             = "ami-0c55b159cbfafe1f0"  # Example AMI ID, replace with the appropriate one for your region
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.web_sg.name]
  key_name        = var.aws_key_name
  
  tags = {
    Name = "Web-Server"
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo docker pull mahirrehman10/proj1:settingupwebiste",
      "sudo docker run -d -p 80:80 --name nginx_container mahirrehman10/proj1:settingupwebiste"
    ]
  }
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.aws_key_name
  public_key = file(var.ssh_public_key_path)
}
