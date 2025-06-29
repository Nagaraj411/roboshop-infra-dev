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