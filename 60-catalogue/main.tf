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
      "sudo sh /tmp/catalogue.sh catalogue ${var.environment}" # catalogue represent as($1) is the argument passed to the script $ catalogue-dev
    ]
  }
}


###  Deployment process to Autoscaling
# This script will staop runnign instance & take the AMI ID
resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state = "stopped"
  depends_on = [terraform_data.catalogue] # when line 34-51 execut complete the this command will works
}


# This will takes the AMI id after instance stopped
resource "aws_ami_from_instance" "catalogue" {  
  name = "${var.project}-${var.environment}-catalogue"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [aws_ec2_instance_state.catalogue]
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue"
    }
  )
}


# Terraform data delete process for catalogue
resource "terraform_data" "catalogue_delete" { 
  triggers_replace = [
    aws_instance.catalogue.id 
  ]

  # make sure you have aws configure in your laptop
  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${aws_instance.catalogue.id}"
  }

  depends_on = [aws_ami_from_instance.catalogue]
}