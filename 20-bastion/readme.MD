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