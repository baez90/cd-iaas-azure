resource "azurerm_virtual_machine_scale_set" "vmss" {
  name                = "cd-iaas-scaleset"
  location            = "${data.azurerm_resource_group.vmss.location}"
  resource_group_name = "${data.azurerm_resource_group.vmss.name}"

  upgrade_policy_mode  = "Manual"

  # required when using rolling upgrade policy
  health_probe_id = "${azurerm_lb_probe.vmss-probe.id}"

  sku {
    name     = "Standard_B2s"
    tier     = "Standard"
    capacity = 2
  }

  storage_profile_image_reference {
    id = "${data.azurerm_image.image.id}"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = 10
  }

  os_profile {
    computer_name_prefix = "cd-iaas"
    admin_username       = "deploy"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/deploy/.ssh/authorized_keys"
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVJuiiV79847mYLheqO15UuNoq24rQpR4/nz3G4d0u7o82Hwn+C7gfCU5wSyl6QoYrgIiwsnZ83yM2v4lZzmIA0EbO6Ilau6yHnlYndTryVBtSWhGIjuWTDAG1koEzTdw4CSnXBhg7PH++6D4zP3nE1zGGkAlldAs9MsTcbn46P8ShPq56IPgNysRqkba3AnckfJe7o7ZDKz9F0KGAT+TI/IiSj6a4ebSeD1RmXF5MUj3huFs6m7DIy2rssZwZ3GCq1/IRNuxH1I+T/YsJ31XuMyMaRid5OQw6/jkKp0dTuX3Bcn7ZvaitaBOvn0sw3rM5xqABVaUJPZV/ljdVKFur 59:32:3a:20:0f:fa:57:52:db:de:ff:e2:48:a4:ea:86 peter.kurfer@googlemail.com"
    }
  }

  network_profile {
    name    = "terraformnetworkprofile"
    primary = true

    ip_configuration {
      name                                   = "TestIPConfiguration"
      primary                                = true
      subnet_id                              = "${azurerm_subnet.backend.id}"
      load_balancer_backend_address_pool_ids = ["${azurerm_lb_backend_address_pool.bpepool.id}"]
    }
  }
}
