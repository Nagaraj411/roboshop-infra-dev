## 📘 SSM Parameters Used
* VPC ID: Retrieved from SSM for environment-specific VPC configuration.

* Private Subnet IDs: Fetched from SSM to place resources in private subnets.

* Backend ALB SG ID: Gets the ALB Security Group ID from SSM for secure access setup.

## 🌐 Backend ALB Configuration
* Creates an internal Application Load Balancer (ALB) in private subnets.

* Uses existing Security Group and private subnet IDs.

* Listener on port 80 handles HTTP traffic and returns a fixed HTML response