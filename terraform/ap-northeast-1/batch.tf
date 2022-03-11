
module "batch" {
  source = "../batch"

  batch_name                    = var.batch_name
  self_hosted_runner_url        = var.self_hosted_runner_url
  self_hosted_runner_secret_arn = var.self_hosted_runner_secret_arn

  batch_service_role_arn        = var.batch_service_role_arn
  batch_service_role_attachment = var.batch_service_role_attachment
  ecs_instance_profile_role_arn = var.ecs_instance_profile_role_arn
  batch_job_execution_role_arn  = var.batch_job_execution_role_arn

  vpc_security_group_ids = [
    module.vpc.default_security_group_id
  ]
  vpc_subnets = module.vpc.public_subnets
}
