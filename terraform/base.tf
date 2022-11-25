terraform {
  required_version = ">= 1.2.2"
  backend "s3" {
    bucket = "aws-batch-github-runner"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
    }
  }
}
