provider "azurerm" {
  skip_provider_registration  = false
  skip_credentials_validation = true
  version = "~> 2.13"
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "testingtfc-rg"
  location = "northeurope"
}

resource "azurerm_storage_account" "example" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  network_rules {
    bypass                     = ["AzureServices", "Logging", "Metrics"]
    default_action             = "Deny"
    ip_rules                   = ["100.1.1.123/32"]
  }
  tags = {
    environment = "staging"
  }
}