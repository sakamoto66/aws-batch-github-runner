data "aws_region" "now" {}

variable "batch_name" {
  default = "self_hosted_runner"
}
variable "batch_service_role_arn" {
}
variable "batch_service_role_attachment" {
}
variable "ecs_instance_profile_role_arn" {
}
variable "batch_job_execution_role_arn" {
}
variable "self_hosted_runner_url" {
}
variable "self_hosted_runner_secret_arn" {
}
variable "vpc_security_group_ids" {
}
variable "vpc_subnets" {
}

