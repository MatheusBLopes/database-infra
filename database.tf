resource "aws_db_subnet_group" "quizhero_db_subnet_group" {
  name = "quizhero-db-subnet-group"
  subnet_ids = [
    "subnet-07e2731634294e6cb",
    "subnet-0b137902f4a66a56b",
    "subnet-06f1d8653e42a9657",
    "subnet-0af2492de458cb01a",
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
  vpc_security_group_ids = ["sg-07bd428dd3fd329a6"]
  storage_type           = "gp2"
  skip_final_snapshot    = true

  depends_on = [ aws_db_subnet_group.quizhero_db_subnet_group ]
}

# Output database connection details
output "database_url" {
  value = aws_db_instance.postgres.endpoint
}