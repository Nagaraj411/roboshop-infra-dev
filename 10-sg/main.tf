module "frontend" {
  source = "../../terraform-aws-security group" # Use the child path to the module
  #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
  project        = var.project
  environment    = var.environment
  sg_name        = var.frontend_sg_name
  sg_description = var.frontend_sg_description
  vpc_id         = local.vpc_id # if u want to create local variable, you can use local.vpc_id
}

# 70-frontend-alb SG details
module "frontend_alb" {
  source = "../../terraform-aws-security group" # Use the child path to the module
  #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
  project     = var.project
  environment = var.environment

  sg_name        = "frontend_alb"
  sg_description = "for frontend_alb"
  vpc_id         = local.vpc_id
}

module "bastion" {
  source = "../../terraform-aws-security group" # Use the child path to the module
  #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
  project     = var.project
  environment = var.environment

  sg_name        = var.bastion_sg_name
  sg_description = var.bastion_sg_description
  vpc_id         = local.vpc_id
}

module "backend_alb" {                          # This module is used to create a security group for the backend ALB
  source = "../../terraform-aws-security group" # Use the child path to the module
  #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
  project     = var.project
  environment = var.environment

  sg_name        = "backend-alb"
  sg_description = "for backend alb"
  vpc_id         = local.vpc_id
}

module "vpn" {                                  # This module is used to create a security group for the VPN
  source = "../../terraform-aws-security group" # Use the child path to the module
  #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
  project     = var.project
  environment = var.environment

  sg_name        = "vpn"
  sg_description = "vpn security group"
  vpc_id         = local.vpc_id
}

# mongodb security group
module "mongodb" {                              # This module is used to create a security group for the MongoDB
  source = "../../terraform-aws-security group" # Use the child path to the module
  #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
  project     = var.project
  environment = var.environment

  sg_name        = "mongodb"
  sg_description = "mongodb security group"
  vpc_id         = local.vpc_id
}

# # redis security group
module "redis" {                                # This module is used to create a security group for the Redis
  source = "../../terraform-aws-security group" # Use the child path to the module
  #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
  project     = var.project
  environment = var.environment

  sg_name        = "redis"
  sg_description = "redis security group"
  vpc_id         = local.vpc_id
}

# # mysql security group
module "mysql" {                                # This module is used to create a security group for the MySQL
  source = "../../terraform-aws-security group" # Use the child path to the module
  #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
  project     = var.project
  environment = var.environment

  sg_name        = "mysql"
  sg_description = "mysql security group"
  vpc_id         = local.vpc_id
}

# # rabbitmq security group
module "rabbitmq" {                             # This module is used to create a security group for the RabbitMQ
  source = "../../terraform-aws-security group" # Use the child path to the module
  #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
  project     = var.project
  environment = var.environment

  sg_name        = "rabbitmq"
  sg_description = "rabbitmq security group"
  vpc_id         = local.vpc_id
}

# catalogue security group
module "catalogue" {                            # This module is used to create a security group for the catalogue
  source = "../../terraform-aws-security group" # Use the child path to the module
  #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
  project     = var.project
  environment = var.environment

  sg_name        = "catalogue"
  sg_description = "catalogue security group"
  vpc_id         = local.vpc_id
}

# user security group
module "user" {                                 # This module is used to create a security group for the user
  source = "../../terraform-aws-security group" # Use the child path to the module
  #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
  project     = var.project
  environment = var.environment

  sg_name        = "user"
  sg_description = "user security group"
  vpc_id         = local.vpc_id
}

# cart security group
module "cart" {                                 # This module is used to create a security group for the cart
  source = "../../terraform-aws-security group" # Use the child path to the module
  #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
  project     = var.project
  environment = var.environment

  sg_name        = "cart"
  sg_description = "cart security group"
  vpc_id         = local.vpc_id
}

# shipping security group
module "shipping" {                             # This module is used to create a security group for the shipping
  source = "../../terraform-aws-security group" # Use the child path to the module
  #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
  project     = var.project
  environment = var.environment

  sg_name        = "shipping"
  sg_description = "shipping security group"
  vpc_id         = local.vpc_id
}

# payment security group
module "payment" {                              # This module is used to create a security group for the payment
  source = "../../terraform-aws-security group" # Use the child path to the module
  #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
  project     = var.project
  environment = var.environment

  sg_name        = "payment"
  sg_description = "payment security group"
  vpc_id         = local.vpc_id
}


#=================================================================================================================================================================
#=================================================================================================================================================================
#=================================================================================================================================================================

# Store the security group ID in SSM Parameter Store for bastion instances security group
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22 # ssh port ec2 instance
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

# vpn ports 22, 443, 943, 1194
resource "aws_security_group_rule" "vpc_ingress" {
  count             = length(var.vpc_ingress)
  type              = "ingress"
  from_port         = var.vpc_ingress[count.index]
  to_port           = var.vpc_ingress[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

# Mongodb
# 22, 27017 ports for mongodb
resource "aws_security_group_rule" "mongodb_vpn_ssh" {
  count                    = length(var.mongodb_ports)
  type                     = "ingress"
  from_port                = var.mongodb_ports[count.index] # This allows SSH and MongoDB connections 22, 27017
  to_port                  = var.mongodb_ports[count.index] # This allows SSH and MongoDB connections 22, 27017
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id # This allows the backend ALB to accept connections from the VPN security group
  security_group_id        = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongodb_bastion" {
  count                    = length(var.mongodb_ports)
  type                     = "ingress"
  from_port                = var.mongodb_ports[count.index] # This allows SSH and MongoDB connections 22, 27017
  to_port                  = var.mongodb_ports[count.index] # This allows SSH and MongoDB connections 22, 27017
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id # This allows the backend ALB to accept connections from the bastion security group
  security_group_id        = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = module.catalogue.sg_id
  security_group_id        = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id        = module.mongodb.sg_id
}

# Redis
# # redis ports 6379
resource "aws_security_group_rule" "redis_vpn_ssh" {
  count                    = length(var.redis_ports)
  type                     = "ingress"
  from_port                = var.redis_ports[count.index] # This allows SSH and Redis connections 22, 6379
  to_port                  = var.redis_ports[count.index] # This allows SSH and Redis connections 22, 6379
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id # This allows the backend ALB to accept connections from the VPN security group
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_bastion" {
  count                    = length(var.redis_ports)
  type                     = "ingress"
  from_port                = var.redis_ports[count.index] # This allows SSH and Redis connections 22, 6379
  to_port                  = var.redis_ports[count.index] # This allows SSH and Redis connections 22, 6379
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id # This allows the backend ALB to accept connections from the VPN security group
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_user" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_cart" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id        = module.redis.sg_id
}

#MySQL
# MySQL ports 3306
resource "aws_security_group_rule" "mysql_vpn_ssh" {
  count                    = length(var.mysql_ports)
  type                     = "ingress"
  from_port                = var.mysql_ports[count.index] # This allows SSH and MySQL connections 22, 3306
  to_port                  = var.mysql_ports[count.index] # This allows SSH and MySQL connections 22, 3306
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id # This allows the backend ALB to accept connections from the bastion security group
  security_group_id        = module.mysql.sg_id
}

resource "aws_security_group_rule" "mysql_bastion" {
  count                    = length(var.mysql_ports)
  type                     = "ingress"
  from_port                = var.mysql_ports[count.index] # This allows SSH and MySQL connections 22, 3306
  to_port                  = var.mysql_ports[count.index] # This allows SSH and MySQL connections 22, 3306
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id # This allows the backend ALB to accept connections from the bastion security group
  security_group_id        = module.mysql.sg_id
}


resource "aws_security_group_rule" "mysql_shipping" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id        = module.mysql.sg_id
}

# RabbitMQ
# # rabbitmq ports 5672
resource "aws_security_group_rule" "rabbitmq_bastion" {
  count                    = length(var.rabbitmq_ports)
  type                     = "ingress"
  from_port                = var.rabbitmq_ports[count.index] # This allows SSH and RabbitMQ connections 22, 5672
  to_port                  = var.rabbitmq_ports[count.index] # This allows SSH and RabbitMQ connections 22, 5672
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id # This allows the backend ALB to accept connections from the bastion security group
  security_group_id        = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "rabbitmq_vpn_ssh" {
  count                    = length(var.rabbitmq_ports)
  type                     = "ingress"
  from_port                = var.rabbitmq_ports[count.index] # This allows SSH and RabbitMQ connections 22, 5672
  to_port                  = var.rabbitmq_ports[count.index] # This allows SSH and RabbitMQ connections 22, 5672
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id # This allows the backend ALB to accept connections from the VPN security group
  security_group_id        = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id        = module.rabbitmq.sg_id
}

# catalogue_backend_alb ports 8080
resource "aws_security_group_rule" "catalogue_backend_alb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.backend_alb.sg_id # This allows the backend ALB to accept connections from the catalogue security group
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_vpn_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id # This allows the backend ALB to accept connections from the catalogue security group
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_vpn_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id # This allows the backend ALB to accept connections from the catalogue security group
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id # This allows the backend ALB to accept connections from the catalogue security group
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "frontend_alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.frontend_alb.sg_id
  security_group_id        = module.frontend.sg_id
}

#Frontend ALB
resource "aws_security_group_rule" "frontend_alb_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.frontend_alb.sg_id
}

resource "aws_security_group_rule" "frontend_alb_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.frontend_alb.sg_id
}

# Ports Permission
#User
resource "aws_security_group_rule" "user_vpn_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "user_bastion_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "user_vpn_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "user_backend_alb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id        = module.user.sg_id
}

#Cart
resource "aws_security_group_rule" "cart_vpn_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_bastion_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.cart.sg_id
}


resource "aws_security_group_rule" "cart_vpn_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_backend_alb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id        = module.cart.sg_id
}

#Shipping
resource "aws_security_group_rule" "shipping_vpn_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.shipping.sg_id
}

resource "aws_security_group_rule" "shipping_bastion_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.shipping.sg_id
}

resource "aws_security_group_rule" "shipping_vpn_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.shipping.sg_id
}

resource "aws_security_group_rule" "shipping_backend_alb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id        = module.shipping.sg_id
}

#Payment
resource "aws_security_group_rule" "payment_vpn_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.payment.sg_id
}

resource "aws_security_group_rule" "payment_bastion_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.payment.sg_id
}

resource "aws_security_group_rule" "payment_vpn_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.payment.sg_id
}

resource "aws_security_group_rule" "payment_backend_alb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.backend_alb.sg_id
  security_group_id        = module.payment.sg_id
}

#Backend ALB
# backend ALB accepting connections from my vpn host on port 80
resource "aws_security_group_rule" "backend_alb_vpn" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id # This allows the backend ALB to accept connections from the VPN security group
  security_group_id        = module.backend_alb.sg_id
}

# backend ALB accepting connections from my bastion host security group on port 80
resource "aws_security_group_rule" "backend_alb_bastion" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id # This allows the backend ALB to accept connections from the bastion security group
  security_group_id        = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "backend_alb_frontend" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "backend_alb_cart" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id        = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "backend_alb_shipping" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id        = module.backend_alb.sg_id
}

resource "aws_security_group_rule" "backend_alb_payment" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id        = module.backend_alb.sg_id
}

#Frontend
resource "aws_security_group_rule" "frontend_vpn" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.frontend.sg_id
}

resource "aws_security_group_rule" "frontend_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.frontend.sg_id
}