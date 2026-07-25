data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type
  user_data = <<-EOF
              #!/bin/bash
              dnf install -y java-17-amazon-corretto tomcat9
              systemctl enable tomcat9
              systemctl start tomcat9
              EOF
  tags = {
    Name = "HelloWorld"
  }
}