# import key-pair to aws
resource "aws_key_pair" "openvpn" {
  key_name   = "openvpn"
  public_key = file("D:\\Devops\\test\\openvpn.pub") # add keypair path link for local computer # must give like this double \\
}

resource "aws_instance" "vpn" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.vpn_sg_id]
  subnet_id = local.public_subnet_ids
  key_name = aws_key_pair.openvpn.key_name # use the key-pair name which we imported to aws
  user_data = file("openvpn.sh") # add openvpn.sh file path link for vs code editor
  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-vpn"
    } 
  )
}