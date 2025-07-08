module "user" {
    source = "git::https://github.com/Nagaraj411/terraform-aws-roboshop-module.git?ref=main"
    component = "user"
    rule_priority = 20 
}