# 🚀 Terraform Infrastructure Module Order

    📦 00-VPC             →  🧱 Base network setup (VPC, Subnets, Route Tables)
    🛡️ 10-SG              →  🔐 Security Groups
    🌐 30-VPN             →  🔒 VPN instance (access to private network)
    🗄️ 40-Database        →  🧩 Databases (MongoDB, Redis, etc.)
    🎯 50-Backend-ALB     →  📍 ALB for backend services (e.g., /catalogue)
    📘 60-Catalogue       →  📦 App instance in Auto Scaling Group
    🔐 60-ACM             →  🔏 SSL Certificates (HTTPS via ACM)
    🎨 70-Frontend-ALB    →  🌍 ALB for frontend (public-facing site)

    | 📂 **Folder**        | 🧭 **Purpose**                                                                        
| -------------------- | -------------------------------------------------------------------------------------  |
| 📦 `00-VPC`          | 🧱 Base network setup — creates **VPC**, **Subnets**, **Route Tables**, etc.          |
| 🛡️ `10-SG`          | 🔐 Manages all **Security Groups** for application communication & isolation.          |
| 💻 `20-Bastion`      | 🧑‍💻 Deploys a **Bastion Host** for secure SSH into private instances.                  |
| 🌐 `30-VPN`          | 🔒 Sets up an **OpenVPN instance** to access private network resources.               |
| 🗄️ `40-Database`    | 🧩 Provisions **MongoDB**, **MySQL**, **Redis**, and **RabbitMQ**.                     |
| 🎯 `50-Backend-ALB`  | 📍 Creates an **Application Load Balancer** for backend services (e.g. `/catalogue`). |
| 📘 `60-Catalogue`    | 📦 Launches the **Catalogue microservice** inside an **Auto Scaling Group**.          |
| 🔐 `60-ACM`          | 🔏 Manages **SSL certificates** using **AWS Certificate Manager** (ACM).              |
| 🎨 `70-Frontend-ALB` | 🌍 Public-facing **ALB** to expose the frontend to users.                             |
| 👥 `80-User`         | 🧑‍🤝‍🧑 Deploys the **User microservice**, part of backend services.                       |
| ⚙️ `90-Components`   | 🔧 Deploys remaining services: **Cart**, **Shipping**, **Payment**, etc.              |
