📦 10-sg/
    
    ├── 📜 main.tf            # 🔧 Creates SGs & ports for MongoDB, Redis, MySQL, RabbitMQ

    ├── 📜 parameter.tf       # 📤 Pushes SG IDs to AWS SSM Parameter Store

📦 databases/

    └── 📜 data.tf            # 📥 Pulls SG IDs from SSM Parameter Store