resource "aws_instance" "bastion" {
  ami                    = local.ami_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id              = local.public_subnet_ids


  # need more for terraform
  root_block_device {
    volume_size = 50     # 💽 Size of the root EBS volume in GB (here, 50 GB)
    volume_type = "gp3"  # 🧱 Type of volume: "gp3" = General Purpose SSD (faster & cheaper than gp2)
  }
  user_data = file("bastion.sh")  # 📝 Script (bastion.sh) that runs automatically on the instance at first boot
  iam_instance_profile = "TerraformAdmin" # 🔐 IAM Role Attachment


  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-bastion"
    }
  )
}