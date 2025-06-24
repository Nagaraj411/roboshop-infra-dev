resource "aws_ssm_parameter" "vpc_id" {
    name        = "/${var.project}/${var.environment}/vpc_id"
    type        = "String"
    value       = module.vpc.vpc_id
}

# this script creates an SSM parameter to store the VPC ID for the project and environment can read by SG group