module "frontend"{
    source = "../../terraform-aws-SG"
    project = var.project
    environment = var.environment
    sg_name = var.frontend_sg_name
    sg_description = var.frontend_sg_description
    vpc_id = var.vpc_id
}