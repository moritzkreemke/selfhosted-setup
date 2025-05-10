[azure_arm_servers]
${vm_name} ansible_host=${vm_public_ip}

[azure_arm_servers:vars]
ansible_user=${admin_username}
ansible_python_interpreter=/usr/bin/python3

[all:vars]
# Add any global variables for your Ansible plays here
# Example:
# app_version=1.2.3
vm_name=${vm_name} # Making vm_name available as a var in Ansible too
