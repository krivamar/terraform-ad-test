variable "public_ip_dc_name" {}
variable "dc_vm_name" {}
variable "dc_private_ip_address" {}
variable "dc_vm_size" {}
variable "admin_username" {}
variable "admin_password" {}
variable "os_disk_caching" {}
variable "os_disk_storage_type" {}
variable "windows_version_sku" {}
variable "windows_version_version" {}
variable "public_ip_vm1_name" {}
variable "vm1_name" {}
variable "vm1_size" {}
variable resource_group_name {
   type = string
   description = "The name of the resource group"
}
variable "subnet" {}
variable "location" {}
variable "count_vm" {}
variable "vm_ids" {
  description = "List of VM IDs to join to the domain"
  type        = list(string)
}