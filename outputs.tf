output "resource_group_name" {
  value = azurerm_resource_group.default.name
}

output "acr_name" {
  value = azurerm_container_registry.default.name
}