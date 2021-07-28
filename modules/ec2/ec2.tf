
resource "aws_instance" "backend1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id =  var.subnet_private3_id
  private_ip = "10.0.5.10"
  security_groups = [var.sg_allow_http_ssh_id]
  key_name = "terraform"

  user_data = <<-EOF
    #!/bin/bash
    echo "*** Installing apache2"
    sudo apt update -y
    sudo apt install apache2 -y
    echo "*** Completed Installing apache2"
  EOF
  tags = {
    Name =  "${var.name_tag}-${var.environment}-ec2-backend1"
  }
}

resource "aws_instance" "backend2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id =  var.subnet_private4_id
  private_ip = "10.0.6.10"
  security_groups = [var.sg_allow_http_ssh_id]
  key_name = "terraform"

  user_data = <<-EOF
    #!/bin/bash
    echo "*** Installing apache2"
    sudo apt update -y
    sudo apt install apache2 -y
    echo "*** Completed Installing apache2"
  EOF
  tags = {
    Name =  "${var.name_tag}-${var.environment}-ec2-backend2"
  }
}


resource "aws_instance" "bastian_host_1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id =  var.subnet_public1_id
  private_ip = "10.0.1.10"
  security_groups = [var.bastien_http_ssh_id]
  associate_public_ip_address = true
  key_name = "terraform"
  tags = {
    Name =  "${var.name_tag}-${var.environment}-bastian-host-1"
  }
}