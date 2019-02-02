terraform {
  backend "azurerm" {
    storage_account_name = "cdiaastfstate"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    resource_group_name  = "CD_IaaS"
    arm_subscription_id  = "8f5caaee-a2d8-4d9a-a89c-f065af38e8c1"
    arm_client_id        = "5e797ef7-38a7-4961-8f93-614b18940c99"
    arm_client_secret    = "39e60284-a945-4486-89a2-c35698686024"
    arm_tenant_id        = "93a1a893-ba64-4392-ae8c-d98cad77199c"
  }
}

data "azurerm_resource_group" "vmss" {
  name     = "${var.resource_group_name}"
}

data "azurerm_image" "image" {
  name                = "${var.immutable_image_name}"
  resource_group_name = "${data.azurerm_resource_group.vmss.name}"
}