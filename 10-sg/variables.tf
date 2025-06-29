variable "project" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "frontend_sg_name" {
  default = "frontend"
}

variable "frontend_sg_description" {
  default = "Security group for frontend services"
}

variable "bastion_sg_name" {
  default = "bastion"
}

variable "bastion_sg_description" {
  default = "Created Security group for bastion instance"
}

variable "vpc_ingress" {
  type    = list(number)
  default = [22, 443, 943, 1194]
}

variable "mongodb_ports_vpn" {
  default = [22, 27017]
  
}