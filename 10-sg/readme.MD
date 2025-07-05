# 🔐 Roboshop Security Groups & Ingress Rules

### 📦 Security Group Classification

      | 🔖 **Category**      | 🧩 **Components**                                  |
      | ------------------------------------------------------------------------- |
      | 🗄️ **DB**            | `mongodb`, `redis`, `mysql`, `rabbitmq`            |
      | ⚙️ **APP**           | `catalogue`, `user`, `cart`, `shipping`, `payment` |
      | 🎯 **BACKEND\_ALB**  | —                                                  |
      | 🌐 **FRONTEND**      | —                                                  |
      | 🎯 **FRONTEND\_ALB** | —                                                  |
      | 🔐 **VPN**           | —                                                  |
      | 🛠️ **BASTION**       | —                                                  |

# 🛡️ Ingress Rules per Component

### 📚 MongoDB

      | 🔑 **Rule Name**    | 🎯 **Purpose**                    |
      | -------------------------------------------------------- |
      | `mongodb_vpn`       | 🔓 Allow `22`, `27017` from `vpn` |
      | `mongodb_catalogue` | 🔓 Allow `27017` from `catalogue` |
      | `mongodb_user`      | 🔓 Allow `27017` from `user`      |

### ⚡ Redis

      | 🔑 **Rule Name** | 🎯 **Purpose**                   |
      | ---------------------------------------------------- |
      | `mysql_vpn`      | 🔓 Allow `22`, `3306` from `vpn` |
      | `mysql_shipping` | 🔓 Allow `3306` from `shipping`  |

### 🗄️ MySQL

      | 🔑 **Rule Name** | 🎯 **Purpose**                   |
      | ---------------------------------------------------- |
      | `mysql_vpn`      | 🔓 Allow `22`, `3306` from `vpn` |
      | `mysql_shipping` | 🔓 Allow `3306` from `shipping`  |

### 📨 RabbitMQ

      | 🔑 **Rule Name**   | 🎯 **Purpose**                   |
      | ------------------------------------------------------ |
      | `rabbitmq_vpn`     | 🔓 Allow `22`, `5672` from `vpn` |
      | `rabbitmq_payment` | 🔓 Allow `5672` from `payment`   |

### 🧩 Catalogue

      | 🔑 **Rule Name**        | 🎯 **Purpose**                     |
      | ------------------------------------------------------------- |
      | `catalogue_vpn`         | 🔓 Allow `22` from `vpn`           |
      | `catalogue_backend_alb` | 🔓 Allow `8080` from `backend_alb` |


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