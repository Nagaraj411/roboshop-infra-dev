# 🔐 Security Group Rules Matrix
* 🧱 Component	🔢 Ports	      📥 Source (Allowed From)
      🔑 Bastion	22 (SSH)	0.0.0.0/0 (Public)
      🔑 VPN	22, 443, 943, 1194	0.0.0.0/0 (Public)
      🗄 MongoDB	22, 27017	VPN, Bastion, Catalogue, User
      🧠 Redis	22, 6379	VPN, Bastion, User, Cart
      🛢 MySQL	22, 3306	VPN, Bastion, Shipping
      📦 RabbitMQ	22, 5672	VPN, Bastion, Payment
      📦 Catalogue	8080	Backend ALB
      22	VPN, Bastion
      👥 User	8080	Backend ALB
      22	VPN, Bastion
      🛒 Cart	8080	Backend ALB
      22	VPN, Bastion
      🚚 Shipping	8080	Backend ALB
      22	VPN, Bastion
      💳 Payment	8080	Backend ALB
      22	VPN, Bastion
      🌐 Backend ALB	80	VPN, Bastion, Frontend, Cart, Shipping, Payment
      🌐 Frontend ALB	80, 443	0.0.0.0/0 (Public)

## ✅ Notes

### 🔢 Standard Service Ports

      | 💠 **Service**        | 🔌 **Port**   |
      |----------------------------------------|
      | 🔐 SSH                | `22`          |
      | 📚 MongoDB            | `27017`       |
      | ⚡ Redis              | `5679`        |
      | 🗄️ MySQL              | `3306`        |
      | 📨 RabbitMQ           | `5672`        |
      | 🧩 App Services       | `8080`        |


### 📘 Implementation Guidelines

      - 🧱 All rules are implemented using `aws_security_group_rule`.
      - 🔁 Inter-service communication is restricted via `source_security_group_id`.
      - 🚫 No public access (`0.0.0.0/0`) is allowed **unless explicitly required** (e.g., for ALBs).
      - 🛡️ Security Groups follow **least privilege** principle to minimize attack surface.
      - 🧩 Each microservice has its **own isolated security group** for better control.
      - 🔄 Rules are **modular** and can be reused across environments.


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