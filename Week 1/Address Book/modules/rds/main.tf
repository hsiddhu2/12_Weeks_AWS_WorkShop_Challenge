resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_db_subnet_group" "db-subnet" {
  name       = var.db_sub_name
  subnet_ids = [var.pri_sub_5a_id, var.pri_sub_6b_id] # Replace with your private subnet IDs
}

resource "aws_db_instance" "db" {
  identifier              = "rdscluster"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  multi_az                = false
  storage_type            = "gp2"
  storage_encrypted       = false
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 0

  vpc_security_group_ids = [var.db_sg_id] # Replace with your desired security group ID

  db_subnet_group_name = aws_db_subnet_group.db-subnet.name

  tags = {
    Name = "rdscluster"
  }
}

# #====================================
# # // Store the database name, database username, database password and database endpoint in the secrets manager
# resource "aws_secretsmanager_secret" "db_secret" {
#   name = "addressbookdb-secret"
# }

# resource "aws_secretsmanager_secret_version" "db_secret_version" {
#   secret_id     = aws_secretsmanager_secret.db_secret.id
#   secret_string = jsonencode({
#     username = var.db_username
#     password = random_password.password.result
#     engine   = "mysql"
#     host     = aws_db_instance.db.address
#     port     = aws_db_instance.db.port
#     db_name  = var.db_name
#   })
# }

