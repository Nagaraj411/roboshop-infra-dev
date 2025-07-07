module "component" {
    for_each = var.components
    source = "git::https://github.com/Nagaraj411/roboshop-terraform-ansible-test.git?ref=main"
    components = each.key
    rule_priority = each.value.rule_priority
}