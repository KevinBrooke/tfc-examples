provider "azurerm" {
  skip_provider_registration  = false
  skip_credentials_validation = true
  version = "~> 2.13"
  features {}
}

variable "tags" {
  default = {
    foo = "bar"
  }
}

variable "prefix" {
  default = "tfctagcheck"
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-rg"
  location = "northeurope"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

module "windowsservers-pass" {
  source              = "../modules/az-compute"
  resource_group_name = azurerm_resource_group.main.name
  is_windows_image    = true
  vm_hostname         = "mywinvm"
  admin_password      = "ComplxP@ssw0rd!"
  vm_os_simple        = "WindowsServer"
  public_ip_dns       = ["winsimplevmips"]
  vnet_subnet_id      = azurerm_subnet.internal.id
  tags = merge(
    var.tags,
    { customer = "foo" },
    { project = "bar" },
    { environment = "dev" },
    { backmeup = "false" },
    { terraform = "true" }
  )
}

module "linuxservers-fail" {
  source              = "../modules/az-compute"
  resource_group_name = azurerm_resource_group.main.name
  vm_os_simple        = "UbuntuServer"
  nb_public_ip        = 0
  public_ip_dns       = ["linsimplevmips"]
  vnet_subnet_id      = azurerm_subnet.internal.id
  tags = merge(
    var.tags,
    { customer = "foo" },
    { project = "bar" },
    { environment = "dev" }
  )
}

