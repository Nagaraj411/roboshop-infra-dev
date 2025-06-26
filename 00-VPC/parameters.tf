resource "aws_ssm_parameter" "vpc_id" {
    name        = "/${var.project}/${var.environment}/vpc_id"
    type        = "String"
    value       = module.vpc.vpc_id
}

# this script creates an SSM parameter to store the VPC ID for the project and environment can read by SG group


resource "aws_ssm_parameter" "public_subnet_ids" {
    name        = "/${var.project}/${var.environment}/public_subnet_ids"
    type        = "StringList"
    value       = join(",", module.vpc.│ Error: Unsupported attribute
│
│   on parameters.tf line 13, in resource "aws_ssm_parameter" "public_subnet_ids":
│   13:     value       = join(",", module.vpc.public_subnet_ids)
│     ├────────────────
│     │ module.vpc is a object
│
│ This object does not have an attribute named "public_subnet_ids".
)
}

# resource "aws_ssm_parameter" "private_subnet_ids" {
#     name        = "/${var.project}/${var.environment}/private_subnet_ids"
#     type        = "String"
#     value       = join(",", module.vpc.private_subnet_ids)
# }

# resource "aws_ssm_parameter" "database_subnet_ids" {
#     name        = "/${var.project}/${var.environment}/database_subnet_ids" 
#     type        = "String"
#     value       = join(",", module.vpc.database_subnet_ids)
# }