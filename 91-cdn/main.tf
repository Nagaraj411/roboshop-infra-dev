resource "aws_cloudfront_distribution" "roboshop" {
  origin {
    domain_name = "cdn.${var.zone_name}"
    custom_origin_config {
      http_port              = 80 // Required to be set but not used
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
    origin_id = "cdn.${var.zone_name}" #cdn.devops84.shop
  }

  enabled = true

  aliases = ["cdn.devops84.shop"]

  default_cache_behavior { # 🔄 Methods CloudFront accepts from viewers
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]        # 🗃️ Only GET/HEAD requests are cached
    target_origin_id = "cdn.${var.zone_name}" # 🎯 Link behavior to the origin defined above

    viewer_protocol_policy = "https-only"                                     # 🔐 Viewers must use HTTPS (secure)
    cache_policy_id        = data.aws_cloudfront_cache_policy.cacheDisable.id # 🚫 Caching disabled via custom policy
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/media/*"                 # 🎯 Only applies to /media/ paths (e.g., /media/file.jpg)
    allowed_methods  = ["GET", "HEAD", "OPTIONS"] # ✅ HTTP methods allowed
    cached_methods   = ["GET", "HEAD", "OPTIONS"] # 🗃️ These responses will be cached
    target_origin_id = "cdn.${var.zone_name}"     # 🔗 Connects to defined origin

    viewer_protocol_policy = "https-only"                                    # 🔐 Force HTTPS from viewer
    cache_policy_id        = data.aws_cloudfront_cache_policy.cacheEnable.id # ✅ Enable caching
  }


  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"              # ✅ Allow only specific countries
      locations        = ["US", "CA", "GB", "DE"] # 🌍 Users only from US, Canada, UK, Germany
    }
  }

  tags = merge(
    local.common_tags, {
      Name = "${var.project}-${var.environment}"
    }
  )

  viewer_certificate {
    acm_certificate_arn = local.acm_certificate_arn # 🔐 SSL cert from ACM (must be in us-east-1)
    ssl_support_method  = "sni-only"                # ✅ Cheaper SSL method for modern browsers
  }
}

resource "aws_route53_record" "frontend_alb" {
  zone_id = var.zone_id
  name    = "cdn.${var.zone_name}" #cdn.devops84.shop
  type    = "A"                    # 🔁 Alias record type (IPv4)

  alias {
    name                   = aws_cloudfront_distribution.roboshop.domain_name    # 📡 Points to CloudFront
    zone_id                = aws_cloudfront_distribution.roboshop.hosted_zone_id # 🆔 Hosted zone of CloudFront
    evaluate_target_health = true                                                # ✅ DNS failover if target is unhealthy
  }
}