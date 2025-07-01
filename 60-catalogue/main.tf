resource "aws_lb_target_group" "catalogue" {
  name     = "${var.project}-${var.environment}-catalogue" # roboshop-dev-catalogue
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id

  health_check {
    path                = "/health"
    interval            = 5
    timeout             = 2
    healthy_threshold  = 2
    unhealthy_threshold = 2
    matcher = "200-299"
    port = 8080
  }
}

# create instance for catalogue service
resource "aws_instance" "catalogue" {
  ami                    = local.ami_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id              = local.private_subnet_ids

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-mongodb"
    }
  )
}
