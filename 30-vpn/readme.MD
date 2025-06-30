# 🔐 Key Concepts – VPN (OpenVPN) with Terraform

🔑 Key Pair Import – Upload local public key to AWS for SSH access.

🖥️ EC2 Instance – Launch a t3.micro instance for the VPN server.

📄 User Data Script – Run openvpn.sh at launch to install OpenVPN.

🌐 Public Subnet – Place instance in a public subnet for external access.

🛡️ Security Group – Allow VPN ports (e.g., 1194/UDP) for OpenVPN traffic.

🏷️ Tags – Add project/environment labels for easy identification.