resource "aws_db_instance" "wordpressdb" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = null # gets the latest version
  instance_class       = "db.t3.micro"
  name                 = "wordpressdb"
  username             = var.db_user
  password             = var.db_password


  db_subnet_group_id = aws_db_subnet_group.rds_subnets.id
  multi_az             = false
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}
