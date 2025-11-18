resource "aws_db_subnet_group" "rds_subnets" {
  name       = "rds_subnets"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "rds_subnets"
  }
}