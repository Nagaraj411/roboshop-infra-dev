## 🔁 Auto Scaling Group: catalogue

⚙️ Configuration

    🏷️ Name: ${var.project}-${var.environment}-catalogue

    📦 Desired Capacity: 1

    🔼 Max Size: 10

    🔽 Min Size: 1

    🎯 Target Group ARNs: [aws_lb_target_group.catalogue.arn]

    🌐 Subnets: local.private_subnet_ids

    ❤️ Health Check Type: ELB

    ⏳ Grace Period: 90s