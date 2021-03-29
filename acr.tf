resource "random_pet" "prefix" {
    separator = ""
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "${random_pet.prefix.id}-acr-rg"
  location  = "East US"

  tags = {
    environment = "Demo"
    cluster     = var.cluster
  }
}

resource "azurerm_management_lock" "default" {
  name = "resource-group-lock"
  scope = azurerm_resource_group.default.id
  lock_level = "CanNotDelete"
  notes = "Locked to avoid accidential deletion"
}

resource "azurerm_container_registry" "default" {
  name                  = "${random_pet.prefix.id}acr"
  resource_group_name   = azurerm_resource_group.default.name
  location              = azurerm_resource_group.default.location
  sku                   = "Basic"

  tags = {
    environment = "Demo"
    cluster     = var.cluster
  }
}