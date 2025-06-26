module "frontend"{
    source = "../../terraform-aws-security group" # Use the child path to the module
    #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.frontend_sg_name
    sg_description = var.frontend_sg_description
    vpc_id = local.vpc_id # if u want to create local variable, you can use local.vpc_id
}

module "bastion"{
    source = "../../terraform-aws-security group" # Use the child path to the module
    #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = var.bastion_sg_name
    sg_description = var.bastion_sg_description
    vpc_id = local.vpc_id # if u want to create local variable, you can use local.vpc_id
}

# Store the security group ID in SSM Parameter Store for frontend instances security group
resource "aws_security_group_rule" "bastion_ingress" {
  type              = "ingress"
  from_port         = 22 # ssh port ec2 instance
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

#====================================================================================================================