variable "batch_name" {
  default = "github_self_runner"
}
variable "runner_secret_key" {
  default = "github/self-hosted-runner"
}
variable "codebuild_source_location" {
  default = ""
}
variable "github_account" {
  description = "Inputs github user or organization or '*'."
}
variable "github_repository" {
  description = "Inputs repository or '*'."
}

data "aws_caller_identity" "now" {}