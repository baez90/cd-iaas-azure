resource "azurerm_lb" "vmss-lb" {
  name                = "cd-iaac-lb"
  location            = "${data.azurerm_resource_group.vmss.location}"
  resource_group_name = "${data.azurerm_resource_group.vmss.name}"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = "${azurerm_public_ip.vmss-ip.id}"
  }
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  resource_group_name = "${data.azurerm_resource_group.vmss.name}"
  loadbalancer_id     = "${azurerm_lb.vmss-lb.id}"
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "vmss-probe" {
  resource_group_name = "${data.azurerm_resource_group.vmss.name}"
  loadbalancer_id     = "${azurerm_lb.vmss-lb.id}"
  protocol            = "Http"
  name                = "http-probe"
  request_path        = "/health"
  port                = 5000
}

resource "azurerm_lb_rule" "vmss-lb-rule" {
  resource_group_name            = "${data.azurerm_resource_group.vmss.name}"
  loadbalancer_id                = "${azurerm_lb.vmss-lb.id}"
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 5000
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = "${azurerm_lb_probe.vmss-probe.id}"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.bpepool.id}"
}
