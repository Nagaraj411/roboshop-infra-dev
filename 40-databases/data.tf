# This Data-sources can create the dynamic changes in AMI to create EC2 Instance
data "aws_ami" "joindevops" {
  most_recent = true
  owners      = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "mongodb_sg_id" { # This SSM parameter stores the security group ID parameter.tf for the mongodb
  name = "/${var.project}/${var.environment}/mongodb_sg_id"
}

data "aws_ssm_parameter" "database_subnet_ids" { # this SSM parameter stores in vpc parameter.tf for the database subnet IDs
  name = "/${var.project}/${var.environment}/database_subnet_ids"
}

# data "aws_ssm_parameter" "redis_sg_id" { # This SSM parameter stores the security group ID parameter.tf for the redis
#   name = "/${var.project}/${var.environment}/redis_sg_id"
# }

# #(create SG in main.tf for mongoddb, redis, mysql, rabbitmq) and pushed to SSM Parameter Store in parameter.tf in 10-sg folder 
# # and then we pull SSM Parameter Store in data.tf in databases module

# data "aws_ssm_parameter" "mysql_sg_id" { # This SSM parameter stores the security group ID parameter.tf for the mysql
#   name = "/${var.project}/${var.environment}/mysql_sg_id"
# }
# data "aws_ssm_parameter" "rabbitmq_sg_id" { # This SSM parameter stores the security group ID parameter.tf for the rabbitmq
#   name = "/${var.project}/${var.environment}/rabbitmq_sg_id"
# }

# 📦 10-sg/
# ├── 📜 main.tf            # 🔧 Creates SGs for MongoDB, Redis, MySQL, RabbitMQ
# ├── 📜 parameter.tf       # 📤 Pushes SG IDs to AWS SSM Parameter Store
#
# 📦 databases/
# └── 📜 data.tf            # 📥 Pulls SG IDs from SSM Parameter Store