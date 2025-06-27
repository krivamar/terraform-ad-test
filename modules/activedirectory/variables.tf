variable "safemode_password" {}
variable "domain_name" {}
variable "domain_mode" {}
variable "active_directory_netbios_name" {}
variable "active_directory_domain" {}
variable "time_sleep" {}
variable "domadminuser" {}
variable "domadminpassword" {}
variable "dc_vm_comp" {
  description = "ID of the domain controller VM"
  type        = string
}
variable "configure-and-join-domain_vm" {}
variable "count_vm" {}
variable "vm_ids" {
  description = "List of VM IDs to join to the domain"
  type        = list(string)
}


