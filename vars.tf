# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  description = "The prefix which should be used for all resources in this project"
}

variable "location" {
  description = "The Azure region in which all resources in this example should be created"
  default     = "East US"
}

variable "username" {
  description = "Username to be used in the VM"
  default     = "AdminUser"
}

variable "password" {
  description = "Password to be used in the VM"
  default     = "A@min123"
}
