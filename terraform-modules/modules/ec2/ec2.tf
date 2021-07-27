
resource "aws_instance" "backend1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id =  ""
  private_ip = "10.0.5.2"
  secuiry_group = []
  key_name = ""
  tags = {
    Name =  "${var.name_tag}-${var.environment}-ec2-1"
  }
}