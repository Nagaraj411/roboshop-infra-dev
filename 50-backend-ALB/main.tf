# This module creates a backend Application Load Balancer (ALB) for the Roboshop project in private subnets.
module "backend_alb" {
  source                     = "terraform-aws-modules/alb/aws"
  version                    = "9.16.0"
  internal                   = true
  name                       = "${var.project}-${var.environment}-backend-alb" #roboshop-dev-backend-alb
  vpc_id                     = local.vpc_id
  subnets                    = local.private_subnet_ids
  create_security_group      = false
  security_groups            = [local.backend_alb_sg_id]
  enable_deletion_protection = false
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-backend-alb"
    }
  )
}

# listeners are used to define how the ALB will handle incoming traffic only on port 80 will be allowed
resource "aws_lb_listener" "backend_alb" {
  load_balancer_arn = module.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I am from Backend ALB</h1>"
      status_code  = "200"
    }
  }
}


# This module creates a Global Accelerator to route traffic to the backend ALB.
# if catalogue service traffic got to backend ALB it goes to catalogue service
# if cart service traffic got to backend ALB it goes to cart service
resource "aws_route53_record" "backend_alb" {
  zone_id = var.zone_id
  name    = "*.backend-dev.${var.zone_name}"
  type    = "A"

  alias {
    name                   = module.backend_alb.dns_name # The DNS name of the ALB
    zone_id                = module.backend_alb.zone_id  # The zone ID of the ALB
    evaluate_target_health = true                        # Evaluate the health of the target
  }
}