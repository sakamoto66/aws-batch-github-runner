variable "repository_name" {
  default = "github/self-hosted-runner"
}
data "aws_region" "now" {}
data "aws_caller_identity" "now" {}

# ----------------------------------------------------------
# ECR
# ----------------------------------------------------------
resource "aws_ecr_repository" "runner" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}
 
# ----------------------------------------------------------
# Null Resource
# ----------------------------------------------------------
resource "null_resource" "runner" {
  triggers = {
    // MD5 チェックし、トリガーにする
    file_content_md5 = md5(file("${path.module}/dockerbuild.sh"))
    file_entrypoint = md5(file("../docker/entrypoint.sh"))
    file_check_jobs = md5(file("../docker/check_jobs.sh"))
    file_Dockerfile = md5(file("../docker/Dockerfile"))
  }

  provisioner "local-exec" {
    // ローカルのスクリプトを呼び出す
    command = "sh ${path.module}/dockerbuild.sh"

    // スクリプト専用の環境変数
    environment = {
      AWS_REGION     = data.aws_region.now.id
      AWS_ACCOUNT_ID = data.aws_caller_identity.now.account_id
      REPO_URL       = aws_ecr_repository.runner.repository_url
      CONTAINER_NAME = aws_ecr_repository.runner.name
    }
  }
}

output "repository_url" {
  value = resource.aws_ecr_repository.runner.repository_url
}