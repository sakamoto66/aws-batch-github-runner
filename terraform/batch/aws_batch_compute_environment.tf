resource "aws_batch_compute_environment" "ec2" {
  compute_environment_name = "${var.batch_name}_ec2"

  compute_resources {
    instance_role = var.ecs_instance_profile_role_arn

    instance_type = [
      "m5",
    ]

    max_vcpus = 256
    min_vcpus = 0

    security_group_ids = var.vpc_security_group_ids
    subnets            = var.vpc_subnets

    type = "EC2"
  }

  service_role = var.batch_service_role_arn
  type         = "MANAGED"
  depends_on   = [var.batch_service_role_attachment]
}

resource "aws_batch_compute_environment" "spot" {
  compute_environment_name = "${var.batch_name}_spot"

  compute_resources {
    instance_role = var.ecs_instance_profile_role_arn

    instance_type = [
      "m5",
    ]

    max_vcpus = 256
    min_vcpus = 0

    security_group_ids = var.vpc_security_group_ids
    subnets            = var.vpc_subnets

    bid_percentage      = 50
    type                = "SPOT"
    allocation_strategy = "SPOT_CAPACITY_OPTIMIZED"
  }

  service_role = var.batch_service_role_arn
  type         = "MANAGED"
  depends_on   = [var.batch_service_role_attachment]
}

resource "aws_batch_compute_environment" "minimum" {
  compute_environment_name = "${var.batch_name}_minimum"

  compute_resources {
    instance_role = var.ecs_instance_profile_role_arn

    instance_type = [
      "m5.large",
    ]

    max_vcpus = 256
    min_vcpus = 0

    security_group_ids = var.vpc_security_group_ids
    subnets            = var.vpc_subnets

    bid_percentage      = 100
    type                = "SPOT"
    allocation_strategy = "SPOT_CAPACITY_OPTIMIZED"
  }

  service_role = var.batch_service_role_arn
  type         = "MANAGED"
  depends_on   = [var.batch_service_role_attachment]
}
