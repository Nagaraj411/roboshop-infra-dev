module "vpc" {
  source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"  
  # must match with module source with terraform-aws-security-group
  project               = var.project
  environment           = var.environment
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs


is_peering_required = true
}

# output "vpc_id" {
#   value = module.vpc.vpc_id  # module.vpc is the reference of 1 line in this module "vpc"
# }
