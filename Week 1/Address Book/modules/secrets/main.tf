#====================================
# // Store the database name, database username, database password and database endpoint in the secrets manager
resource "aws_secretsmanager_secret" "db_secret" {
  name = "mysecret"
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = var.rds_endpoint
    dbname   = var.db_name
  })

  depends_on = [
    var.rds_endpoint
  ]
}
