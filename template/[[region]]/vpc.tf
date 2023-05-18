module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "runner-vpc"
  cidr = "10.0.0.0/16"

  azs            = ["<region>a"]
  public_subnets = ["10.0.101.0/24"]
  map_public_ip_on_launch = true

  default_security_group_ingress = [
    {
      description      = "TLS from VPC"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = "${module.vpc.vpc_cidr_block}"
    }
  ]
  default_security_group_egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = "0.0.0.0/0"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
