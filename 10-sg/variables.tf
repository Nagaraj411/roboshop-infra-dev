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

variable "vpc_id" {
  type = string
  default = {}
}
