resource "aws_db_subnet_group" "private_subnets" {
  name       = "${var.name_tag}-${var.environment}-private_subnets-db-rds-mysal"
  subnet_ids = [var.subnet_private1_id]
}

resource "aws_db_parameter_group" "db_parameter_group_mysql" {
  name   = "${var.name_tag}-${var.environment}-pg-rds-mysal"
  family = "mysql5.7"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

# Create Database Instance Restored from DB Snapshots
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "admin"
  password             = "password"
  parameter_group_name = aws_db_parameter_group.db_parameter_group_mysql.name
  skip_final_snapshot  = true
  security_group_names = [ "" ]
  db_subnet_group_name = aws_db_subnet_group.private_subnets.name
}