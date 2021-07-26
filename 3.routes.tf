########## route table ###################
### private route table ##############
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name_tag}-${var.environment}-private-rt"
  }
}
############# private route table with nat #######################
######### create elastic ip
resource "aws_eip" "eip" {
  vpc      = true
    tags = {
    Name = "${var.name_tag}-${var.environment}-eip"
  }
}
####### create a nat gateway 
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public1.id

    tags = {
    Name = "${var.name_tag}-${var.environment}-nat_gateway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}
resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.name_tag}-${var.environment}-private2-rt"
  }
}
resource "aws_route" "r" {
  route_table_id            = aws_route_table.private2.id
  nat_gateway_id = aws_nat_gateway.nat_gateway.id
    destination_cidr_block    = "0.0.0.0/0"
  depends_on = [aws_route_table.private2]
}
### private route table ##############
resource "aws_internet_gateway" "gw" {
      vpc_id = aws_vpc.main.id

   tags = {
    Name = "${var.name_tag}-${var.environment}-public-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.name_tag}-${var.environment}-public-rt"
  }
}

################ subnet association #####################
####### public ###############################
resource "aws_route_table_association" "public_subnet1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_subnet2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}
##### private without nat #########################
resource "aws_route_table_association" "private_subnet1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private_subnet2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}
######### private with nat ##########################
resource "aws_route_table_association" "private_subnet3" {
  subnet_id      = aws_subnet.private3.id
  route_table_id = aws_route_table.private2.id
}
resource "aws_route_table_association" "private_subnet4" {
  subnet_id      = aws_subnet.private4.id
  route_table_id = aws_route_table.private2.id
}


# resource "aws_route_table_association" "nat_gateway_associate" {
#   gateway_id     = aws_nat_gateway.nat_gateway.id
#   route_table_id = aws_route_table.private2.id
# }