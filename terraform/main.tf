module "runner_ecr" {
  source          = "./ecr"
  repository_name = "github/self-hosted-runner"
}

module "iam_role" {
  source = "./iam_role"

  role_name_prefix      = var.batch_name
  role_batch_secret_arn = var.secret_arn
}
