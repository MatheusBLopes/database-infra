resource "aws_security_group" "security_group" {
  name   = "tech_challenge_db_sg"
  vpc_id = "vpc-0c38971aff2387bb3"

  ingress {
    from_port   = 0
    to_port     = 6000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 6000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_security_group_rule" "security_group_rule" {
  type = "egress"
  security_group_id = aws_security_group.security_group.id

  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}