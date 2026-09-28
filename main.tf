locals {
  common_tags = merge(
    {
      project     = var.project
      environment = var.environment
      managed_by  = "terraform"
      workspace   = terraform.workspace
    },
    var.tags,
  )
}

resource "azurerm_resource_group" "vics_resource_group" {
  name     = "rg-${var.project}-${var.environment}"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_virtual_network" "vics_virtual_network" {
  name                = "${var.project}-${var.environment}-vnet"
  location            = azurerm_resource_group.vics_resource_group.location
  resource_group_name = azurerm_resource_group.vics_resource_group.name
  address_space       = ["10.0.0.0/16"]
  tags                = local.common_tags
}

resource "azurerm_subnet" "public" {
  name                 = "public"
  resource_group_name  = azurerm_resource_group.vics_resource_group.name
  virtual_network_name = azurerm_virtual_network.vics_virtual_network.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "private" {
  name                 = "private"
  resource_group_name  = azurerm_resource_group.vics_resource_group.name
  virtual_network_name = azurerm_virtual_network.vics_virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "public" {
  name                = "${var.project}-${var.environment}-public-nsg"
  location            = azurerm_resource_group.vics_resource_group.location
  resource_group_name = azurerm_resource_group.vics_resource_group.name
  tags                = local.common_tags

  security_rule {
    name                       = "allow-ssh-from-admin"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.admin_source_cidr
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "private" {
  name                = "${var.project}-${var.environment}-private-nsg"
  location            = azurerm_resource_group.vics_resource_group.location
  resource_group_name = azurerm_resource_group.vics_resource_group.name
  tags                = local.common_tags

  security_rule {
    name                       = "allow-postgresql-from-public-subnet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "10.0.0.0/24"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.public.id
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.private.id
}
