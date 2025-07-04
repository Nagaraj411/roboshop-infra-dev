data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}
# this script retrieves the VPC ID from SSM parameter store for the project and environment sent by VPC group

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project}/${var.environment}/public_subnet_ids"
}
# this script retrieves the private subnet IDs from SSM parameter store for the project and environment sent by VPC group

data "aws_ssm_parameter" "frontend_alb_sg_id" {
  name = "/${var.project}/${var.environment}/frontend_alb_sg_id"
}
# if u mention backend_alb_sg_id in 10/sg/parameters.tf,
# then we can retrieve the backend ALB security group ID from SSM parameter store to 50-backend-ALB/data.tf

data "aws_ssm_parameter" "acm_certificate_arn" {
  name = "/${var.project}/${var.environment}/acm_certificate_arn"
}