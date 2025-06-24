 resource "aws_instance" "bastion" {
    ami = local.ami_id
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.bastion_sg_id]
    subnet_id = module.vpc.public_subnets[0] # use the first public subnet for the bastion host

    tags = {
      Name = "roboshop-dev-bastion"
    }
}
 