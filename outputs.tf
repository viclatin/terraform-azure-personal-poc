# Ansible mapping: outputs are registered facts other plays (or other root
# modules, via remote state) can consume after the run.

output "resource_group_name" {
  description = "Name of the resource group created by this root module."
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "Fully qualified Azure resource ID of the resource group."
  value       = azurerm_resource_group.main.id
}

output "location" {
  description = "Azure region the resource group was created in."
  value       = azurerm_resource_group.main.location
}
