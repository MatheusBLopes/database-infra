resource "aws_db_subnet_group" "quizhero_db_subnet_group" {
  name = "quizhero-db-subnet-group"
  subnet_ids = [
    "subnet-00a06eebfd915e0b0",
    "subnet-05d851a5d1b7e7201",
    ]
}

resource "aws_db_instance" "life_manager_db" {
  identifier             = "quizhero"
  db_name                = "quizhero"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "12"
  username               = "mainuser"
  password               = "mainpassword"
  db_subnet_group_name   = aws_db_subnet_group.quizhero_db_subnet_group.name
  vpc_security_group_ids = ["sg-099977c6b7814b467"]
  apply_immediately      = true
  publicly_accessible    = true
  skip_final_snapshot    = true
}

# Output database connection details
output "database_url" {
  value = aws_db_instance.life_manager_db.endpoint
}