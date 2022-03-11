#
# ジョブ定義用の実行ロール※Secretアクセス権限付
#
module "batch_job_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4"

  create_role = true

  role_name         = "${var.role_name_prefix}_batch_job"
  role_requires_mfa = false

  trusted_role_services = [
    "ecs-tasks.amazonaws.com"
  ]
  
  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    resource.aws_iam_policy.batch_job_role.arn
  ]
}
resource "aws_iam_policy" "batch_job_role" {
  name   = "${var.role_name_prefix}_batch_job_secret"
  policy = data.aws_iam_policy_document.batch_job_role.json
}

data "aws_iam_policy_document" "batch_job_role" {
  statement {
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]
    resources = [
      var.role_batch_secret_arn,
    ]
  }
}
