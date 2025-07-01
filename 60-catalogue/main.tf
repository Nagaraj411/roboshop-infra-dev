resource "aws_lb_target_group" "catalogue" {
  name     = "${var.project}-${var.environment}-catalogue" # roboshop-dev-catalogue
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id

  health_check {
    path                = "/health"
    interval            = 5
    timeout             = 2
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
    port                = 8080
  }
}

# create instance for catalogue service
resource "aws_instance" "catalogue" {
  ami                    = local.ami_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id              = local.private_subnet_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue"
    }
  )
}

# Terraform data for catalogue
resource "terraform_data" "catalogue" { # This resource is used to manage the catalogue instance
  triggers_replace = [
    aws_instance.catalogue.id # This is used to trigger the resource to be replaced when the catalogue instance is updated 
  ]
  provisioner "file" {
    source      = "catalogue.sh"
    destination = "/tmp/catalogue.sh"
  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/catalogue.sh",
      "sudo sh /tmp/catalogue.sh catalogue" # catalogue represent as($1) is the argument passed to the script
    ]
  }
}