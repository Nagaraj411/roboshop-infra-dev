# 🚀 Terraform Infrastructure Module Order

    📦 00-VPC             →  🧱 Base network setup (VPC, Subnets, Route Tables)
    🛡️ 10-SG              →  🔐 Security Groups
    🌐 30-VPN             →  🔒 VPN instance (access to private network)
    🗄️ 40-Database        →  🧩 Databases (MongoDB, Redis, etc.)
    🎯 50-Backend-ALB     →  📍 ALB for backend services (e.g., /catalogue)
    📘 60-Catalogue       →  📦 App instance in Auto Scaling Group
    🔐 60-ACM             →  🔏 SSL Certificates (HTTPS via ACM)
    🎨 70-Frontend-ALB    →  🌍 ALB for frontend (public-facing site)
    👥 80-User            →  🧑‍🤝‍🧑 Deploys the **User microservice**, part of backend services.
    ⚙️ 90-Components      →  🧑‍🤝‍🧑 🔧 Deploys remaining services: **Cart**, **Shipping**, **Payment**, etc.
    🚀 91-CDN             →  🌐 Sets up **CloudFront CDN** for caching & delivering frontend globally.