variable "location" {
  description = "The location where resources are created"
  default     = "Central US"
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources are created"
  default     = "CD_IaaS"
}

variable "immutable_image_name" {
  description = "The name of the immutable image to deploy to the ScaleSet"
  default     = "hackerthonImage"
}
