output "vm_public_ip" {
  description = "Public IP address of the Azure ARM VM."
  value       = azurerm_public_ip.pip.ip_address
}

output "vm_id" {
  description = "ID of the Azure ARM VM."
  value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_admin_username" {
  description = "Admin username for the VM."
  value       = var.admin_username
}

output "resource_group_name" {
  description = "Name of the resource group."
  value       = azurerm_resource_group.rg.name
}
output "generated_ansible_inventory_path" {
  description = "Path to the generated Ansible inventory file."
  value       = local_file.ansible_inventory.filename
}