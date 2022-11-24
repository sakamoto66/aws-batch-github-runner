data "aws_region" "now" {}

variable "batch_name" {
  default = "github_self_runner"
}
variable "batch_service_role_arn" {
}
variable "batch_service_role_attachment" {
}
variable "ecs_instance_profile_role_arn" {
}
variable "batch_job_execution_role_arn" {
}
variable "github_self_runner_url" {
}
variable "github_self_runner_secret_arn" {
}
variable "vpc_security_group_ids" {
}
variable "vpc_subnets" {
}

