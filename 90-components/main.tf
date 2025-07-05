module "component" {
    for_each = var.components
    source = "../../terraform-aws-roboshop-module"
    component = each.key
    rule_priority = each.value.rule_priority
    
}