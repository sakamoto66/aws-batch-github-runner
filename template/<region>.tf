module "<region>" {
  source = "./<region>"

  batch_name                    = var.batch_name
  self_hosted_runner_url        = module.runner_ecr.repository_url
  self_hosted_runner_secret_arn = var.secret_arn

  batch_service_role_arn        = module.iam_role.batch_service_role_arn
  batch_service_role_attachment = module.iam_role.batch_service_role_attachment
  ecs_instance_profile_role_arn = module.iam_role.ecs_instance_profile_role_arn
  batch_job_execution_role_arn  = module.iam_role.batch_job_execution_role_arn
}
