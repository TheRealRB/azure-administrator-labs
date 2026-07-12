variable "team_name" {
  description = "The name of the team"
  type        = string
  default     = "devops-team"
}

variable "project_name" {
  description = "The name of the project."
  type        = string
  default     = "terraform-devops"
}


variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus2"
}

variable "environment" {
  description = "The environment for the resources - dev, staging, prod"
  type        = string
  default     = "dev"
}

# variable "resource_group_name" {
#   description = "The name of the resource group"
#   type        = string
#   default     = "rg-terraform-demo"
# }

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
  }
}

# variable "virtual_network_name" {
#   description = "The name of the virtual network"
#   type        = string
#   default     = "vnet-terraform-demo"
# }

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "subnet_address_prefixes" {
  description = "The address prefix for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "deploy_vm" {
  description = "Controls whether Linux virtual machines are deployed."
  type        = bool
  default     = false
}

variable "vm_count" {
  description = "Number of Linux virtual machines to deploy."
  type        = number
  default     = 0
}

variable "vm_size" {
  description = "The size of the virtual machines"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for Linux VMs."
  type        = string
  default = "adminuser"
}

variable "ssh_public_key" {
  description = "Public SSH key for Linux VM access"
  type        = string
}

