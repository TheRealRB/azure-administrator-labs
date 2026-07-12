locals {
  resource_suffix       = "${var.environment}-${var.project_name}-compute"

  common_tags           = merge(
    var.tags,
    {
        environment = var.environment
        team_name   = var.team_name
        project_name = var.project_name
        managed_by   = "Terraform"
        module_name   = "compute"
    }  
  )
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${local.resource_suffix}"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-${local.resource_suffix}"
  address_space       = var.address_space
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.common_tags
}

resource "azurerm_subnet" "main" {
  name                 = "subnet-${local.resource_suffix}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet_address_prefixes[0]]
}


resource "azurerm_network_interface" "main" {
  count = var.deploy_vm ? var.vm_count : 0
# resource "azurerm_network_interface" "main" {
  # count               = var.vm_count
  name                = "nic-${local.resource_suffix}-${count.index + 1}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "ipconfig-${local.resource_suffix}-${count.index + 1}"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = local.common_tags
}

resource "azurerm_linux_virtual_machine" "main" {
  count = var.deploy_vm ? var.vm_count : 0

  name                = "vm-${local.resource_suffix}-${count.index + 1}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
  username   = var.admin_username
  public_key = var.ssh_public_key
}
 
  network_interface_ids = [
    azurerm_network_interface.main[count.index].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = local.common_tags
}