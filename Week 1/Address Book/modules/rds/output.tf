output "rds_endpoint" {
  value = aws_db_instance.db.endpoint
}

output "db_password" {
  value = random_password.password.result
}
