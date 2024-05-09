resource "aws_db_subnet_group" "quizhero_db_subnet_group" {
  name = "quizhero-db-subnet-group"
  subnet_ids = [
    "subnet-00a06eebfd915e0b0",
    "subnet-05d851a5d1b7e7201",
    ]
}

resource "aws_db_instance" "postgres" {
  identifier             = "quizhero"
  engine                 = "postgres"
  username               = "mainuser"
  password               = "mainpassword"
  db_name                = "quizhero"
  allocated_storage      = 10
  engine_version         = "15.6"
  instance_class         = "db.t3.micro"
  parameter_group_name   = "default.postgres15"
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.quizhero_db_subnet_group.name
  vpc_security_group_ids = ["sg-099977c6b7814b467"]
  storage_type           = "gp2"
  skip_final_snapshot    = true

  depends_on = [ aws_db_subnet_group.quizhero_db_subnet_group ]
}

# Output database connection details
output "database_url" {
  value = aws_db_instance.postgres.endpoint
}