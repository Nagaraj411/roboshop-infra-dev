data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}

# this script retrieves the VPC ID from SSM parameter store for the project and environment sent by VPC group
