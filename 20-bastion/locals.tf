locals {
  ami_id = data.aws_ami.joindevops.id
  bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
  }