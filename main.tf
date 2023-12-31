# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "Azuredevops" {
  name     = var.prefix
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/22"]
  location            = azurerm_resource_group.Azuredevops.location
  resource_group_name = azurerm_resource_group.Azuredevops.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.Azuredevops.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "subnet_association" {
  subnet_id                 = azurerm_subnet.internal.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_network_security_group" "main" {
  name                = "${var.prefix}-nsg"
  location            = azurerm_resource_group.Azuredevops.location
  resource_group_name = azurerm_resource_group.Azuredevops.name

  security_rule {
    name                       = "AllowSubnetConnection"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = "10.0.1.0/24"
    source_address_prefix      = "10.0.1.0/24"
  }

  security_rule {
    name                       = "DenyInternetAccess"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "10.0.1.0/24"
  }

  security_rule {
    name                       = "AllowOutAccess"
    priority                   = 104
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    destination_address_prefix = "10.0.1.0/24"
    source_address_prefix      = "10.0.1.0/24"
  }

  security_rule {
    name                       = "AllowTcpAccess"
    priority                   = 104
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "10.0.1.0/24"
  }
}

resource "azurerm_network_interface" "main" {
  count               = var.vm_number
  name                = "${var.prefix}-nic${count.index}"
  location            = azurerm_resource_group.Azuredevops.location
  resource_group_name = azurerm_resource_group.Azuredevops.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-pip"
  location            = azurerm_resource_group.Azuredevops.location
  resource_group_name = azurerm_resource_group.Azuredevops.name
  allocation_method   = "Dynamic"
}

resource "azurerm_lb" "main" {
  name                = "${var.prefix}-lb"
  location            = azurerm_resource_group.Azuredevops.location
  resource_group_name = azurerm_resource_group.Azuredevops.name

  frontend_ip_configuration {
    name                 = "PublicIpAddress"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

resource "azurerm_lb_backend_address_pool" "main" {
  loadbalancer_id = azurerm_lb.main.id
  name            = "BackendAddressPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "main" {
  count                   = var.vm_number
  network_interface_id    = element(azurerm_network_interface.main[*].id, count.index)
  ip_configuration_name   = azurerm_network_interface.main[count.index].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
}

resource "azurerm_availability_set" "main" {
  name                = "${var.prefix}-set"
  location            = azurerm_resource_group.Azuredevops.location
  resource_group_name = azurerm_resource_group.Azuredevops.name
}

data "azurerm_image" "main" {
  name                = "myProjectImage"
  resource_group_name = azurerm_resource_group.Azuredevops.name
}
resource "azurerm_linux_virtual_machine" "main" {
  count                           = var.vm_number
  name                            = "${var.prefix}-vm-${count.index}"
  resource_group_name             = azurerm_resource_group.Azuredevops.name
  location                        = azurerm_resource_group.Azuredevops.location
  size                            = "Standard_D2s_v3"
  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false
  network_interface_ids = [
    element(azurerm_network_interface.main[*].id, count.index)
  ]
  availability_set_id = azurerm_availability_set.main.id

  source_image_id = data.azurerm_image.main.id

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  tags = {
    ProjectName = "${var.prefix}-"
    Enviroment  = "production"
  }
}
