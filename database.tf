resource "aws_db_subnet_group" "db_subnet_group" {
  name = "db-subnet-group"
  subnet_ids = [
    "subnet-07a371f0c2f8dd740",
    "subnet-04b66e840b6cbaac3"
    ]
}

resource "aws_db_parameter_group" "db_parameters" {
  name        = "db-parameters"
  family      = "postgres15"  // or whichever PostgreSQL version you're using

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }
  parameter {
    name  = "password_encryption"
    value = "MD5"
  }
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
  parameter_group_name   = aws_db_parameter_group.db_parameters.name
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = ["sg-0534bbcaa42a9f23b"]
  storage_type           = "gp2"
  skip_final_snapshot    = true

  depends_on = [ aws_db_subnet_group.db_subnet_group ]
}

# Output database connection details
output "database_url" {
  value = aws_db_instance.postgres.endpoint
}