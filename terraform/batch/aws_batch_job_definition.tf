resource "aws_batch_job_definition" "github_self_runner" {
  name = var.batch_name
  type = "container"

  container_properties = <<CONTAINER_PROPERTIES
{
    "image": "${var.github_self_runner_url}",
    "memory": 7000,
    "vcpus": 8,
    "environment": [
        {"name": "EPHEMERAL", "value": "1"},
        {"name": "JOBS_ACCEPTANCE_TIMEOUT", "value": "120"},
        {"name": "RUNNER_SCOPE", "value": "repo"},
        {"name": "RUNNER_NAME_PREFIX", "value": "${data.aws_region.now.id}"},
        {"name": "LABELS", "value": "${data.aws_region.now.id}"},
        {"name": "REPO_URL", "value": "https://github.com/xxx"}
    ],
    "secrets" : [
        {"name": "ACCESS_TOKEN", "valueFrom": "${var.github_self_runner_secret_arn}:ACCESS_TOKEN::"},
        {"name": "ORG_NAME", "valueFrom": "${var.github_self_runner_secret_arn}:ORG_NAME::"}
    ],
    "executionRoleArn": "${var.batch_job_execution_role_arn}"
}
CONTAINER_PROPERTIES
}

