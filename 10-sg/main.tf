module "frontend"{
    source = "../../terraform-aws-security group"
    #source = "git::https://github.com/Nagaraj411/terraform-aws-security-group.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name = var.frontend_sg_name
    sg_description = var.frontend_sg_description
    vpc_id = local.vpc_id # if u want to create local variable, you can use local.vpc_id
}
