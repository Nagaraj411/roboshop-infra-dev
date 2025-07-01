# mongoDB instance configuration with ansible for roboshop project
# This file creates a MongoDB instance in AWS using Terraform & provisions it with a bootstrap script running on the instance.
resource "aws_instance" "mongodb" {
  ami                    = local.ami_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id              = local.database_subnet_ids

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-mongodb"
    }
  )
}

resource "terraform_data" "mongodb" { # This resource is used to manage the MongoDB instance
  triggers_replace = [
    aws_instance.mongodb.id # This is used to trigger the resource to be replaced when the MongoDB instance is updated 
  ]
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh", # r--- read rwx---
      "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}" # mongodb represent as($1) is the argument passed to the script
    ]
  }
}

# redis instance configuration with ansible for roboshop project
# This file creates a Redis instance in AWS using Terraform & provisions it with a bootstrap script running on the instance.
# resource "aws_instance" "redis" {
#   ami                    = local.ami_id
#   instance_type          = "t3.micro"
#   vpc_security_group_ids = [local.redis_sg_id]
#   subnet_id              = local.database_subnet_ids

#   tags = merge(
#     local.common_tags,
#     {
#       Name = "${var.project}-${var.environment}-redis"
#     }
#   )
# }

# resource "terraform_data" "redis" { # This resource is used to manage the Redis instance
#   triggers_replace = [
#     aws_instance.redis.id # This is used to trigger the resource to be replaced when the Redis instance is updated 
#   ]
#   provisioner "file" {
#     source      = "bootstrap.sh"
#     destination = "/tmp/bootstrap.sh"
#   }
#   connection {
#     type     = "ssh"
#     user     = "ec2-user"
#     password = "DevOps321"
#     host     = aws_instance.redis.private_ip
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/bootstrap.sh",
#       "sudo sh /tmp/bootstrap.sh redis ${var.environment}" # redis represent as($1) is the argument passed to the script
#     ]
#   }
# }

# # mysql instance configuration with ansible for roboshop project
# # This file creates a mysql instance in AWS using Terraform & provisions it with a bootstrap script running on the instance.
# resource "aws_instance" "mysql" {
#   ami                    = local.ami_id
#   instance_type          = "t3.micro"
#   vpc_security_group_ids = [local.mysql_sg_id]
#   subnet_id              = local.database_subnet_ids
#   iam_instance_profile   = "EC2RoleToFetchSMM" # This will create and attach the IAM role to the instance for fetching secrets from AWS Secrets Manager

#   tags = merge(
#     local.common_tags,
#     {
#       Name = "${var.project}-${var.environment}-mysql"
#     }
#   )
# }

# resource "terraform_data" "mysql" { # This resource is used to manage the mysql instance
#   triggers_replace = [
#     aws_instance.mysql.id # This is used to trigger the resource to be replaced when the mysql instance is updated 
#   ]
#   provisioner "file" {
#     source      = "bootstrap.sh"
#     destination = "/tmp/bootstrap.sh"
#   }
#   connection {
#     type     = "ssh"
#     user     = "ec2-user"
#     password = "DevOps321"
#     host     = aws_instance.mysql.private_ip
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/bootstrap.sh",
#       "sudo sh /tmp/bootstrap.sh mysql ${var.environment}" # mysql represent as($1) is the argument passed to the script
#     ]
#   }
# }

# # rabbitmq instance configuration with ansible for roboshop project
# # This file creates a rabbitmq instance in AWS using Terraform & provisions it with a bootstrap script running on the instance.
# resource "aws_instance" "rabbitmq" {
#   ami                    = local.ami_id
#   instance_type          = "t3.micro"
#   vpc_security_group_ids = [local.rabbitmq_sg_id]
#   subnet_id              = local.database_subnet_ids

#   tags = merge(
#     local.common_tags,
#     {
#       Name = "${var.project}-${var.environment}-rabbitmq"
#     }
#   )
# }

# resource "terraform_data" "rabbitmq" { # This resource is used to manage the rabbitmq instance
#   triggers_replace = [
#     aws_instance.rabbitmq.id # This is used to trigger the resource to be replaced when the rabbitmq instance is updated 
#   ]
#   provisioner "file" {
#     source      = "bootstrap.sh"
#     destination = "/tmp/bootstrap.sh"
#   }
#   connection {
#     type     = "ssh"
#     user     = "ec2-user"
#     password = "DevOps321"
#     host     = aws_instance.rabbitmq.private_ip
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/bootstrap.sh",
#       "sudo sh /tmp/bootstrap.sh rabbitmq ${var.environment}" # rabbitmq represent as($1) is the argument passed to the script
#     ]
#   }
# }

# Creating route 53 Record for mongodb
resource "aws_route53_record" "mongodb" {
  zone_id = var.zone_id
  name    = "mongodb-${var.environment}.${var.zone_name}" #mongodb-dev.daws84s.site
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.private_ip]
  allow_overwrite = true
}


# # Creating route 53 Record for redis
# resource "aws_route53_record" "redis" {
#   zone_id = var.zone_id
#   name    = "redis-${var.environment}.${var.zone_name}" #redis-dev.daws84s.site
#   type    = "A"
#   ttl     = 1
#   records = [aws_instance.redis.private_ip]
#   allow_overwrite = true
# }

# # Creating route 53 Record for mysql
# resource "aws_route53_record" "mysql" {
#   zone_id = var.zone_id
#   name    = "mysql-${var.environment}.${var.zone_name}" #mysql-dev.daws84s.site
#   type    = "A"
#   ttl     = 1
#   records = [aws_instance.mysql.private_ip]
#   allow_overwrite = true
# }

# # Creating route 53 Record for rabbitmq
# resource "aws_route53_record" "rabbitmq" {
#   zone_id = var.zone_id
#   name    = "rabbitmq-${var.environment}.${var.zone_name}" #rabbitmq-dev.daws84s.site
#   type    = "A"
#   ttl     = 1
#   records = [aws_instance.rabbitmq.private_ip]
#   allow_overwrite = true
# }