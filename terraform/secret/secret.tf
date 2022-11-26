data "aws_secretsmanager_secret" "runner" {
  name = var.secret_name
}

data "aws_secretsmanager_secret_version" "runner" {
  secret_id = data.aws_secretsmanager_secret.runner.id
}

output "arn" {
  value = data.aws_secretsmanager_secret.runner.arn
}

output "access_token" {
  sensitive = true
  value = jsondecode(data.aws_secretsmanager_secret_version.runner.secret_string)["ACCESS_TOKEN"]
}
