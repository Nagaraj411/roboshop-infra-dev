#!/bin/bash

component=$1  # Get the component name from the first argument
dnf install ansible -y  # Install Ansible
ansible-pull -U https://github.com/Nagaraj411/ansible-roboshop-roles.git -e component=$1 main.yaml 
# Pull the latest Ansible playbooks from the repositorys to the local machine