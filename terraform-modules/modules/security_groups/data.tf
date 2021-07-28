# data "aws_vpc" "mypvc" {
#   tags = {
#     Name = "${var.name_tag}-${var.environment}-vpc"
#   }
#   cidr_block = var.vpc_cidr_block
# }