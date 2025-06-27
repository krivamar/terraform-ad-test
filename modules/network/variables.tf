variable "vnet_name" {}
variable "subnet_name" {}
variable "nsg_name" {}
variable "address_space" {}
variable "subnet_prefix" {}
variable "nsg_rule_rdp_allow" {}
variable "nsg_rule_winrm_allow" {}
variable "dc_private_ip_address" {}
variable "resource_group_name" {
    type = string
    description = "The name of the resource group"
}
variable "location" {
    type = string
    description = "The location of the resource group"
}