📌 Description
* This module creates a complete VPC architecture including:

* Public subnets (for internet-facing resources)

* Private subnets (for internal resources like app servers)

* Database subnets (isolated subnets for DB layer)

* Supports VPC peering when is_peering_required is set to true.

===================================================================

# 🔧 VPC Module Full Structure

🌐 VPC
│  📥 Input: cidr_block
│  📤 Output: vpc_id
│
├──📦 Public Subnet(s)
│    📥 Input: vpc_id, cidr_block, availability_zone
│    📤 Output: subnet_id
│
├──🔐 Security Group (SG)
│    📥 Input: vpc_id
│    📤 Output: sg_id
│
├──🚪 Internet Gateway (IGW)
│    📥 Input: vpc_id
│    📤 Output: igw_id
│
├──🛣️ Route Table (for public)
│    📥 Input: vpc_id, igw_id
│    📤 Output: route_table_id
│
├──🔁 Route Table Association
│    📥 Input: subnet_id, route_table_id
│
├──🌩️ NAT Gateway (Optional)
│    📥 Input: elastic_ip, subnet_id
│    📤 Output: nat_gw_id
│
├──📦 Private Subnet(s)
│    📥 Input: vpc_id, cidr_block, availability_zone
│    📤 Output: subnet_id
│
├──🛣️ Route Table (for private)
│    📥 Input: vpc_id, nat_gw_id
│    📤 Output: route_table_id
│
├──🔁 Route Table Association (private)
│    📥 Input: subnet_id, route_table_id
│
├──💻 EC2 Instance
│    📥 Input: subnet_id, sg_id, ami_id
│    📤 Output: instance_id, public_ip
│
└──🔗 Peering Connection (Optional)
     📥 Input: vpc_id, peer_vpc_id
     📤 Output: peering_connection_id
