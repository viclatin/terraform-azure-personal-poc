output "resource_group_name" {
  description = "Name of the Azure resource group."
  value       = azurerm_resource_group.vics_resource_group.name
}

output "virtual_network_id" {
  description = "ID of the virtual network."
  value       = azurerm_virtual_network.vics_virtual_network.id
}

output "subnet_ids" {
  description = "IDs of the public and private subnets."
  value = {
    public  = azurerm_subnet.public.id
    private = azurerm_subnet.private.id
  }
}

output "app_server_public_ip" {
  description = "Public IP address for SSH access to the app server."
  value       = azurerm_public_ip.app_server.ip_address
}

output "app_server_private_ip" {
  description = "Private IP address of the app server."
  value       = azurerm_network_interface.app_server.private_ip_address
}

output "database_private_ip" {
  description = "Private IP address of the database VM."
  value       = azurerm_network_interface.database.private_ip_address
}