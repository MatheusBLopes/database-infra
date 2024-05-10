resource "aws_db_subnet_group" "db_subnet_group" {
  name = "db-subnet-group"
  subnet_ids = [
    "subnet-084f1609a3253535e",
    "subnet-0a0072f0b6788185e"
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
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = ["sg-03554f9ec2c87c30b"]
  storage_type           = "gp2"
  skip_final_snapshot    = true

  depends_on = [ aws_db_subnet_group.db_subnet_group ]
}

# Output database connection details
output "database_url" {
  value = aws_db_instance.postgres.endpoint
}