

output "batch_job_execution_role_arn" {
  value = module.batch_job_role.iam_role_arn
}
output "batch_service_role_arn" {
  value = resource.aws_iam_role.aws_batch_service_role.arn
}
output "batch_service_role_attachment" {
  value = resource.aws_iam_role_policy_attachment.aws_batch_service_role
}
output "ecs_instance_profile_role_arn" {
  value = resource.aws_iam_instance_profile.ecs_instance_role.arn
}
