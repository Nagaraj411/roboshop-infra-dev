# 🔐 Security Group Rules Matrix

      | 🧱 **Component**     | 🔢 **Port(s)**     | 🔄 **Protocol** | 🔓 **Access From**                                        | 📝 **Purpose**                     |
      | --------------------  | ------------------  | --------------- | --------------------------------------------------------- | ---------------------------------- |
      | 🔑 **Bastion**       | 22                 | TCP             | 🌐 `0.0.0.0/0`                                             | SSH to EC2                         |
      | 🔐 **VPN**           | 22, 443, 943, 1194 | TCP             | 🌐 `0.0.0.0/0`                                             | VPN connectivity                   |
      | 🗄️ **MongoDB**       | 22, 27017          | TCP             | 🔐 VPN, 🔑 Bastion, 📦 Catalogue, 👥 User                 | DB access (SSH + MongoDB)          |
      | 🧠 **Redis**         | 22, 6379           | TCP             | 🔐 VPN, 🔑 Bastion, 👥 User, 🛒 Cart                      | Cache access (SSH + Redis)         |
      | 🛢️ **MySQL**         | 22, 3306           | TCP             | 🔐 VPN, 🔑 Bastion, 🚚 Shipping                           | DB access (SSH + MySQL)            |
      | 🐇 **RabbitMQ**      | 22, 5672           | TCP             | 🔐 VPN, 🔑 Bastion, 💳 Payment                            | MQ access (SSH + AMQP)             |
      | 📦 **Catalogue**     | 8080, 22           | TCP             | 🔐 VPN, 🔑 Bastion, 🌐 Backend ALB                        | API + SSH access                   |
      | 👥 **User**          | 8080, 22           | TCP             | 🔐 VPN, 🔑 Bastion, 🌐 Backend ALB                        | API + SSH access                   |
      | 🛒 **Cart**          | 8080, 22           | TCP             | 🔐 VPN, 🔑 Bastion, 🌐 Backend ALB                        | API + SSH access                   |
      | 🚚 **Shipping**      | 8080, 22           | TCP             | 🔐 VPN, 🔑 Bastion, 🌐 Backend ALB                        | API + SSH access                   |
      | 💳 **Payment**       | 8080, 22           | TCP             | 🔐 VPN, 🔑 Bastion, 🌐 Backend ALB                        | API + SSH access                   |
      | 🌐 **Backend ALB**   | 80                 | TCP             | 🔐 VPN, 🔑 Bastion, 🔼 Frontend, 🛒 Cart, 🚚 Ship, 💳 Pay | Load Balancer for Backend Services |
      | 🌍 **Frontend ALB**  | 80, 443            | TCP             | 🌐 `0.0.0.0/0`                                            | Public Load Balancer               |
      | 🖥️ **Frontend App**  | 22, 80             | TCP             | 🔐 VPN, 🔑 Bastion, 🌐 Frontend ALB                       | App access + ALB connection        |

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