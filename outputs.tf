output "resource_group_name" {
  description = "Name of the Azure resource group."
  value       = azurerm_resource_group.main.name
}

output "virtual_network_id" {
  description = "ID of the virtual network."
  value       = azurerm_virtual_network.main.id
}

output "subnet_ids" {
  description = "IDs of the public and private subnets."
  value = {
    public  = azurerm_subnet.public.id
    private = azurerm_subnet.private.id
  }
}