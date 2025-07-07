#!/bin/bash

component=$1  # Get the component name from the first argument
dnf install ansible -y  # Install Ansible
ansible-pull -U https://github.com/Nagaraj411/roboshop-terraform-ansible-test.git -e component=$1 -e env=$2 main.yaml 
# Pull the latest Ansible playbooks from the repository to the local machine