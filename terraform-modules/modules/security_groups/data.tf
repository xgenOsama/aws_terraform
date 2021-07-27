data "aws_vpc" "mypvc" {
  tags = {
      Name =  "${var.name_tag}-${var.environment}-vpc"
  }
}