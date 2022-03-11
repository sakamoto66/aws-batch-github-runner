output "vpc_default_security_group_id" {
  value = module.vpc.default_security_group_id
}
output "vpc_public_subnets" {
  value = module.vpc.public_subnets
}
