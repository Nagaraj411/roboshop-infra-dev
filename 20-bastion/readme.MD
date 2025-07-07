# 🛡️ Bastion Host
This Terraform resource creates a Bastion EC2 instance in a public subnet to securely access private resources inside the VPC.

## 📌 Purpose
Allows SSH access to private EC2 instances

Deployed in public subnet with restricted security group

Used as a jump server for internal access

## 🔍 Terraform Data Sources
AMI Lookup: Dynamically fetches the latest RHEL-9-DevOps-Practice AMI using filters.

Bastion SG ID: Gets the Bastion host Security Group ID from SSM Parameter Store.

Public Subnet IDs: Retrieves public subnet IDs from SSM for dynamic EC2 placement.


* While running with bastion to access private & database servers this steps to folow
    Must give aws configure
    00-vpc ( run Bash )
    10-SG   ( run Bash )
    20-Bastion  ( run Bash )
    60-acm  ( run Bash )
    40-Database in run 1: MobaXterm (mongodb, redis, mysql, rabbitmq)
    50-Backend-ALB  ( run Bash )
    60-catalogue ( run 2 MobaXterm )
    70-Frontend-ALB ( run Bash )
    80-user  ( run 3 MobaXterm )
    90-components (cart, shipping, payment, frontend) ( run 4 in MobaXterm )

