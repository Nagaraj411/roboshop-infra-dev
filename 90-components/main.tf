module "component" {
    for_each = var.components
    # source = "../../terraform-aws-roboshop-module" # local purpose
    source = "git::https://github.com/Nagaraj411/roboshop-terraform-ansible-test.git?ref=main"
    component = each.key
    rule_priority = each.value.rule_priority
}