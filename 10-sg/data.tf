data "aws_ssm_parameter" "vpc_id" {
    name        = "/${var.project}/${var.environment}/vpc_id"
}

# this script retrieves the VPC ID from SSM parameter store for the project and environment sent by VPC group 

data "aws_ssm_parameter" "public_subnet_ids" {
    name        = "/${var.project}/${var.environment}/public_subnet_ids"
}
# this script retrieves the public subnet IDs from SSM parameter store for the project and environment sent by VPC group

data "aws_ssm_parameter" "bastion_sg_id" {
    name        = "/${var.project}/${var.environment}/bastion_sg_id"
}
# this script retrieves the bastion security group ID from SSM parameter store for the project and environment sent by SG group
