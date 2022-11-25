module "runner_ecr" {
  source                       = "./ecr"
  repository_name              = "github/self-hosted-runner"
  codebuild_repository_url     = var.codebuild_repository_url
  github_personal_access_token = var.github_personal_access_token
}

module "iam_role" {
  source = "./iam_role"

  role_name_prefix      = var.batch_name
  role_batch_secret_arn = var.secret_arn
}
