output "resource_group_name" {
    
  description = "The name of the resource group."
  value       = azurerm_resource_group.main.name
  
}

output "virtual_network_id" {
    
  description = "The ID of the virtual network."
  value       = azurerm_virtual_network.main.id
  
}

output "vm_ids" {
    
  description = "The IDs of the virtual machines."
  value       = azurerm_linux_virtual_machine.main[*].id
  
 }
