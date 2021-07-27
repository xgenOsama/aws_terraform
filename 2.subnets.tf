resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block_public_a
  availability_zone = var.availability_zone_a
  tags = {
    Name = "${var.name_tag}-${var.environment}-public-a01"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block_public_b
  availability_zone = var.availability_zone_b
  tags = {
    Name = "${var.name_tag}-${var.environment}-public-b01"
  }
}
################ private subnets ######################
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block_private_a
  availability_zone = var.availability_zone_a
  tags = {
    Name = "${var.name_tag}-${var.environment}-private-a01"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block_private_b
  availability_zone = var.availability_zone_b
  tags = {
    Name = "${var.name_tag}-${var.environment}-private-b01"
  }
}

resource "aws_subnet" "private3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block_private_a2
  availability_zone = var.availability_zone_a
  tags = {
    Name = "${var.name_tag}-${var.environment}-private-a01"
  }
}

resource "aws_subnet" "private4" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block_private_b2
  availability_zone = var.availability_zone_b
  tags = {
    Name = "${var.name_tag}-${var.environment}-private-b01"
  }
}