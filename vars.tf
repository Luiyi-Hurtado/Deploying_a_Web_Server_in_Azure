# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  description = "The prefix which should be used for all resources in this project"
  default     = "Azuredevops"
}

variable "location" {
  description = "The Azure region in which all resources in this example should be created"
  default     = "East US"
}

variable "vm_number" {
  description = "The number of the VMs"
  default     = 3
}

variable "username" {
  description = "The admin-Username for VM"
  default     = "Admin-username"
}

variable "password" {
  description = "The admin-password for VM"
  default     = "Admin@Password1"
}
