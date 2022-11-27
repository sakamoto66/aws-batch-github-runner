module "runner_secret" {
  source      = "./secret"
  secret_name = var.runner_secret_key
}

module "runner_ecr" {
  source                       = "./ecr"
  repository_name              = "github/self-hosted-runner"
  codebuild_source_location    = "" == var.codebuild_source_location ? data.external.git_remote_url.result["url"] : var.codebuild_source_location
  github_personal_access_token = module.runner_secret.access_token
}

module "iam_role" {
  source = "./iam_role"

  role_name_prefix      = var.batch_name
  role_batch_secret_arn = module.runner_secret.arn
}

data "external" "git_remote_url" {
  program = ["bash", "git_remote_url.sh"]
}