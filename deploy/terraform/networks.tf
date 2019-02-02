resource "azurerm_virtual_network" "vmss" {
  name                = "vmss-vnet"
  address_space       = ["172.28.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${data.azurerm_resource_group.vmss.name}"
}

resource "azurerm_subnet" "backend" {
  name                 = "backend"
  resource_group_name  = "${data.azurerm_resource_group.vmss.name}"
  virtual_network_name = "${azurerm_virtual_network.vmss.name}"
  address_prefix       = "172.28.2.0/24"
}

resource "azurerm_public_ip" "vmss-ip" {
  name                = "cd-iaac-public-ip"
  location            = "${data.azurerm_resource_group.vmss.location}"
  resource_group_name = "${data.azurerm_resource_group.vmss.name}"
  allocation_method   = "Static"
  domain_name_label   = "${replace(lower(data.azurerm_resource_group.vmss.name), "_", "-")}"
}