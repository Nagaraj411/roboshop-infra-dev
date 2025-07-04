locals {
  ami_id        = data.aws_ami.joindevops.id
  mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
  # redis_sg_id         = data.aws_ssm_parameter.redis_sg_id.value
  # mysql_sg_id         = data.aws_ssm_parameter.mysql_sg_id.value
  # rabbitmq_sg_id      = data.aws_ssm_parameter.rabbitmq_sg_id.value
  database_subnet_ids = split(",", data.aws_ssm_parameter.database_subnet_ids.value)[0] # [0] is used to get the first subnet id from the comma separated list

  common_tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = "true"
  }
}