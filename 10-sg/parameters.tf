resource "aws_ssm_parameter" "frontend_sg_id" {
  name  = "/${var.project}/${var.environment}/frontend_sg_id"
  type  = "String"
  value = module.frontend.sg_id
}

# When parent (terraform-aws-security-group) module is used, the security group ID will be available as an output
# Then we can use the child module parameter to store the security group ID in SSM Parameter Store for frontend instances security group

resource "aws_ssm_parameter" "frontend_alb_sg_id" {
  name  = "/${var.project}/${var.environment}/frontend_alb_sg_id"
  type  = "String"
  value = module.frontend_alb.sg_id
}

resource "aws_ssm_parameter" "bastion_sg_id" {
  name  = "/${var.project}/${var.environment}/bastion_sg_id"
  type  = "String"
  value = module.bastion.sg_id
}
# when we write bastion resource in 10-sg module parameter.tf, next we write in 20-bastion/data.tf

resource "aws_ssm_parameter" "backend_alb_sg_id" {
  name  = "/${var.project}/${var.environment}/backend_alb_sg_id"
  type  = "String"
  value = module.backend_alb.sg_id
}
# when we write backend_alb resource in 10-sg module parameter.tf, next we write in 50-backend-ALB/data.tf

resource "aws_ssm_parameter" "vpn_sg_id" {
  name  = "/${var.project}/${var.environment}/vpn_sg_id"
  type  = "String"
  value = module.vpn.sg_id
}
# when we wrote vpn SG ids in 10-sg module main.tf & now we expose the vpn security group ID in 10-sg module parameter.tf

resource "aws_ssm_parameter" "mongodb_sg_id" {
  name  = "/${var.project}/${var.environment}/mongodb_sg_id"
  type  = "String"
  value = module.mongodb.sg_id
}

# resource "aws_ssm_parameter" "redis_sg_id" {
#   name  = "/${var.project}/${var.environment}/redis_sg_id"
#   type  = "String"
#   value = module.redis.sg_id
# }

# resource "aws_ssm_parameter" "mysql_sg_id" {
#   name  = "/${var.project}/${var.environment}/mysql_sg_id"
#   type  = "String"
#   value = module.mysql.sg_id
# }

# resource "aws_ssm_parameter" "rabbitmq_sg_id" {
#   name  = "/${var.project}/${var.environment}/rabbitmq_sg_id"
#   type  = "String"
#   value = module.rabbitmq.sg_id
# }

resource "aws_ssm_parameter" "catalogue_sg_id" {
  name  = "/${var.project}/${var.environment}/catalogue_sg_id"
  type  = "String"
  value = module.catalogue.sg_id
}