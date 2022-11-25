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

output "repository_url" {
  value = resource.aws_ecr_repository.runner.repository_url
}