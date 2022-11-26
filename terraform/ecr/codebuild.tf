# ----------------------------------------------------------
# CodeBuild
# ----------------------------------------------------------
module "build" {
  source = "cloudposse/codebuild/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "x.x.x"
  namespace = "eg"
  stage     = "test"
  name      = var.repository_name

  source_credential_server_type = "GITHUB"
  source_credential_token       = var.github_personal_access_token
  private_repository            = true

  source_type     = "GITHUB"
  source_location = var.codebuild_source_location
  git_clone_depth = 1
  artifact_type   = "NO_ARTIFACTS"

  # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
  build_image        = "aws/codebuild/standard:2.0"
  build_compute_type = "BUILD_GENERAL1_SMALL"
  build_timeout      = 300
  privileged_mode    = true

  # These attributes are optional, used as ENV variables when building Docker images and pushing them to ECR
  # For more info:
  # http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html
  # https://www.terraform.io/docs/providers/aws/r/codebuild_project.html
  image_repo_name = var.repository_name
  image_tag       = "latest"
}

resource "aws_codebuild_webhook" "build" {
  project_name = module.build.project_name

  filter_group {
    filter {
      exclude_matched_pattern = false
      pattern                 = "PUSH"
      type                    = "EVENT"
    }
    filter {
      exclude_matched_pattern = false
      pattern                 = "^refs/tags/v.*"
      type                    = "HEAD_REF"
    }
  }
}