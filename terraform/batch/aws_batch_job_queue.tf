resource "aws_batch_job_queue" "ec2" {
  name     = "${var.batch_name}_ec2"
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    resource.aws_batch_compute_environment.ec2.arn
  ]
}

resource "aws_batch_job_queue" "spot" {
  name     = "${var.batch_name}_spot"
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    resource.aws_batch_compute_environment.spot.arn
  ]
}

resource "aws_batch_job_queue" "minimum" {
  name     = "${var.batch_name}_minimum"
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    resource.aws_batch_compute_environment.minimum.arn
  ]
}
