variable "resource_group" {
  type    = string
  default = "rg"
}

variable "resource_group_location" {
  type    = string
  default = "eastus"
}

variable "vnet_name" {
  type    = string
  default = "vnet-default"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "web_subnet_name" {
  type    = string
  default = "websubnet"
}

variable "web_subnet_address" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "source_address_prefix" {
  type    = string
  default = "20.115.19.92/32"
}