# 🧠 Concept: Roboshop Database Instance Setup with Terraform
In this setup, we use Terraform to provision EC2 instances on AWS for each database/service: MongoDB, Redis, MySQL, and RabbitMQ. Each instance is configured using a bootstrap.sh script passed via SSH.

## 🧱 Architecture Components

    🖥️ EC2 Instance – One per service

    🛡️ Security Group – Allows specific port access

    📦 AMI – Predefined OS image for all instances

    🌐 Subnet (Database) – All instances are launched in private subnets

    ⚙️ bootstrap.sh – Common provisioning script

    🔐 IAM Role – Used by MySQL to fetch secrets

🏷️ Tags – For naming & identification



📦 10-sg/
    
    ├── 📜 main.tf            # 🔧 Creates SGs & ports for MongoDB, Redis, MySQL, RabbitMQ

    ├── 📜 parameter.tf       # 📤 Pushes SG IDs to AWS SSM Parameter Store

📦 databases/

    └── 📜 data.tf            # 📥 Pulls SG IDs from SSM Parameter Store