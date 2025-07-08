module "component" {
  for_each     = var.components
  source = "git::https://github.com/Nagaraj411/terraform-aws-roboshop-module.git?ref=main"
  # source       = "../../terraform-aws-roboshop-module"
  component    = each.key
  rule_priority = each.value.rule_priority
}