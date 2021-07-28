resource "aws_security_group" "bastien_http_ssh" {
  name = "${var.name_tag}-${var.environment}-bastien_http_ssh-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.my_vpc_id

  ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
     Name = "${var.name_tag}-${var.environment}-sg-bastien_http_ssh"
  }
}

resource "aws_security_group" "allow_http_ssh" {
  name = "${var.name_tag}-${var.environment}-ec2-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.my_vpc_id

  ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    #cidr_blocks      = ["0.0.0.0/0"]
    security_groups = [aws_security_group.sg_allow_http_alb_sg.id]
  }

    ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    #cidr_blocks      = ["0.0.0.0/0"]
    security_groups = [aws_security_group.sg_allow_http_alb_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
     Name = "${var.name_tag}-${var.environment}-sg-allow_http_ssh"
  }
}


resource "aws_security_group" "sg_allow_http_alb_sg" {
  name = "${var.name_tag}-${var.environment}-alb-loadbalancer"
  description = "Allow http inbound traffic"
  vpc_id      = var.my_vpc_id

  ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
      Name = "${var.name_tag}-${var.environment}-sg-alb-sg"
  }
}