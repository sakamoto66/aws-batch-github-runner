resource "aws_batch_job_queue" "ec2" {
  name     = "${var.batch_name}_ec2"
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    resource.aws_batch_compute_environment.ec2.arn
  ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_batch_job_queue" "spot" {
  name     = "${var.batch_name}_spot"
  state    = "ENABLED"
  priority = 1
  compute_environments = [
    resource.aws_batch_compute_environment.spot.arn
  ]
  lifecycle {
    create_before_destroy = true
  }
}
