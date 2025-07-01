This is 10-sg is the child folder
main parent is terraform-aws-security group

copy git link  paste in 10-sg folder as a source

🔁 Flow with Inputs and Outputs
   * VPC
    |
    |---> 🛡️ Security Group (SG)
    |         📥 Input: vpc_id
    |         📤 Output: sg_id
    |
    |---> 💻 EC2 Instance
              📥 Input: sg_id



# 🔐 Catalogue SG Rules (Simplified)

      📜 Backend_ALB  ---> catalogue : 8080   # App traffic
      📜 VPN          ---> catalogue : 8080   # Internal access

      📜 Bastion      ---> catalogue : 22     # SSH access
      📜 VPN          ---> catalogue : 22     # SSH access

      📜 catalogue    ---> MongoDB   : 27017  # DB connection