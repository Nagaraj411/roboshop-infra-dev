# this line will create certificate to (devops84)
resource "aws_acm_certificate" "devops84" {
  domain_name       = "*.${var.zone_name}"
  validation_method = "DNS"

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}"
    }
  )
  lifecycle {
    create_before_destroy = true
  }
}

# this line create the records
resource "aws_route53_record" "devops84" {
  for_each = {
    for dvo in aws_acm_certificate.devops84.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

# This line is validate the certificate
resource "aws_acm_certificate_validation" "devops84" {
  certificate_arn         = aws_acm_certificate.devops84.arn
  validation_record_fqdns = [for record in aws_route53_record.devops84 : record.fqdn]
}