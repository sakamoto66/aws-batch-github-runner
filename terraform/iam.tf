resource "aws_iam_policy" "executer" {
  name   = "github-batch-executer"
  
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "batch:SubmitJob",
        "logs:GetLogEvents",
        "codebuild:StartBuild"
      ],
      "Resource": [
        "arn:aws:batch:*:${data.aws_caller_identity.now.account_id}:job-definition/${var.batch_name}",
        "arn:aws:batch:*:${data.aws_caller_identity.now.account_id}:job-queue/${var.batch_name}_*",
        "arn:aws:logs:*:${data.aws_caller_identity.now.account_id}:log-group:/aws/batch/job:log-stream:${var.batch_name}/*",
        "${module.runner_ecr.codebuild_arn}"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "batch:DescribeJobs",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "executer" {
  name = "github-batch-executer"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${resource.aws_iam_openid_connect_provider.github_actions.arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:${var.github_account}/${var.github_repository}:ref:refs/heads/*"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "executer" {
  role       = aws_iam_role.executer.name
  policy_arn = aws_iam_policy.executer.arn
}

output "AWS_ROLE_ARN" {
  value = aws_iam_role.executer.arn
  description = "Please, set this value to your Github secrets."
}