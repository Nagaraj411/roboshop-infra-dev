resource "aws_ssm_parameter" "frontend_sg_id" {
    name        = "/${var.project}/${var.environment}/frontend_sg_id"
    type        = "String"
    value       = module.frontend.sg_id
}

# When parent (terraform-aws-security-group) module is used, the security group ID will be available as an output
# Then we can use the child module parameter to store the security group ID in SSM Parameter Store for frontend instances security group


resource "aws_ssm_parameter" "bastion_sg_id" {
    name        = "/${var.project}/${var.environment}/bastion_sg_id"
    type        = "String"
    value       = module.bastion.sg_id
}
 