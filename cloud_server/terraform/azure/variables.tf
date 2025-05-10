variable "location" {
  type        = string
  description = "The Azure region to deploy resources in."
  default     = "germanywestcentral"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
  default     = "arm-vm-rg"
}

variable "vm_name" {
  type        = string
  description = "Name for the virtual machine."
  default     = "ubuntu-arm-vm"
}

variable "vm_size" {
  type        = string
  description = "Azure VM size for the ARM instance."
  default     = "Standard_B2pls_v2"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM."
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the SSH public key to be used for the instance."
  default     = "~/.ssh/id_ed25519.pub" 
}

variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network."
  default     = "arm-vnet"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the VNet."
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  type        = string
  description = "Name of the Subnet."
  default     = "arm-subnet"
}

variable "subnet_address_prefix" {
  type        = list(string)
  description = "Address prefix for the Subnet."
  default     = ["10.0.1.0/24"]
}

variable "image_publisher" {
  type        = string
  description = "Azure Marketplace image publisher."
  default     = "Canonical"
}

variable "image_offer" {
  type        = string
  description = "Azure Marketplace image offer."
  default     = "ubuntu-24_04-lts"
}

variable "image_sku" {
  type        = string
  description = "Azure Marketplace image SKU."
  default     = "minimal-arm64"
}

variable "image_version" {
  type        = string
  description = "Azure Marketplace image version. Use 'latest' or a specific version string."
  default     = "24.04.202505020"
}

variable "vm_tags" {
  type        = map(string)
  description = "Tags to apply to the VM and related resources."
  default = {
    environment = "development"
    project     = "arm-instance"
  }
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID."
  sensitive = true
}



