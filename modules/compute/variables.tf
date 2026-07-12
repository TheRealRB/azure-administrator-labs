variable "project_name" {
    description = "The name of the project."
    type        = string
    default = "Terraform Azure DevOps Demo"
}

variable "team_name" {
    description = "The name of the team."
    type        = string
    default = "DevOps Team 1"
}

variable "environment" {
    description = "The environment for the deployment (e.g., dev, staging, prod)."
    type        = string
    default = "dev"

    validation {
      condition = contains(["dev", "staging", "prod"], lower(var.environment))
      error_message = "The environment must be one of: dev, staging, prod."
    }
}

variable "location" {
    description = "The location/region for the resources."
    type        = string
    default = "eastus2"
}

variable "deploy_vm" {
  description = "Controls whether Linux virtual machines are deployed."
  type        = bool
  default     = false
}

variable "vm_count" {
  description = "The number of VMs to create."
  type        = number
  default     = 0

  validation {
    condition     = var.vm_count >= 0 && var.vm_count <= 5
    error_message = "The VM count must be between 0 and 5."
  }
}

variable "vm_size" {
    description = "The size of the virtual machines."
    type        = string
    default     = "Standard_B1s"
}

variable "address_space" {
    description = "The address space for the virtual network."
    type        = list(string)
    default = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
    description = "The address prefixes for the subnets."
    type        = list(string)
    default     = ["10.0.1.0/24", "10.0.2.0/24"]
  
}

variable "admin_username" {
  description = "Admin username for Linux VMs."
  type        = string
}

variable "tags" {
    description = "A map of tags to assign to the resources."
    type        = map(string)
    default     = {
    }
}

variable "ssh_public_key" {
  description = "Public SSH key for Linux VM access"
  type        = string
}