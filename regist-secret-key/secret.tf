resource "aws_secretsmanager_secret" "runner" {
  name = var.runner_secret_key
}

resource "aws_secretsmanager_secret_version" "runner" {
  secret_id = resource.aws_secretsmanager_secret.runner.id
  secret_string = jsonencode({
    ACCESS_TOKEN = "${var.github_personal_access_token}"
  })
}
