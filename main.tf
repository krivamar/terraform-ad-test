
# CReate resource group #
  resource "azurerm_resource_group" "name1" {
    name     = "${var.resource_group_name}"
    location = "${var.location}"
  }
################### INfra Network ###################
  # Virtual Network
module "network" {
  source = "./modules/network"
  vnet_name = var.vnet_name
  subnet_name = var.subnet_name
  nsg_name = var.nsg_name
  address_space = var.address_space
  subnet_prefix = var.subnet_prefix
  nsg_rule_rdp_allow = var.nsg_rule_rdp_allow
  nsg_rule_winrm_allow = var.nsg_rule_winrm_allow
  dc_private_ip_address = var.dc_private_ip_address
  resource_group_name = azurerm_resource_group.name1.name
  location = var.location
}
module "compute" {
  source = "./modules/compute"
  ############## VM Creation DC tf-dc1 ##############
    public_ip_dc_name = var.public_ip_dc_name
    #This passes a variable from the root module (var.public_ip_dc_name) into the compute module as public_ip_dc_name.
    dc_vm_name = var.dc_vm_name
    dc_vm_size = var.dc_vm_size
    dc_private_ip_address = var.dc_private_ip_address
    admin_username = var.admin_username
    admin_password = var.admin_password
    os_disk_caching = var.os_disk_caching
    os_disk_storage_type = var.os_disk_storage_type
    windows_version_sku = var.windows_version_sku
    windows_version_version = var.windows_version_version
    resource_group_name = azurerm_resource_group.name1.name
  ############## VM Creation member VMs ##############
    public_ip_vm1_name = var.public_ip_vm1_name
    vm1_name = var.vm1_name
    vm1_size = var.vm1_size
  ##...other variables...#############################
    subnet = module.network.subnet_id
    #This line assigns the output value subnet_id from the network module to the subnet variable in the compute module.
    # module.network refers to the instance of your network module.
    # subnet_id must be defined as an output in outputs.tf,
    location = var.location
    count_vm = var.count_vm
    # count_vm is an input variable for your compute module.
    vm_ids = module.compute.vm_id
  } 

module "activedirectory" {
  source = "./modules/activedirectory"
  # Active Directory Domain Variables
  ############## AD - Promoting DC "tf-dc1" to Domain Controller ##############
  safemode_password = var.safemode_password
  domain_name = var.active_directory_domain
  domain_mode = var.domain_mode
  active_directory_domain = var.active_directory_domain
  active_directory_netbios_name = var.active_directory_netbios_name
  ############# AD - Join member VMs to Domain ##############
  domadminuser = var.domadminuser
  domadminpassword = var.domadminpassword
  time_sleep = var.time_sleep
  # ...other variables...
  dc_vm_comp = module.compute.dc_vm_id
  #dc_vm_comp is an input variable for your activedirectory module.
  #module.compute.dc_vm_id is an output from your compute module,
  #which should contain the ID of the domain controller VM (created inside the compute module).
  vm_ids = module.compute.vm_id
  count_vm = var.count_vm
  # count_vm is an input variable for your activedirectory module.
  configure-and-join-domain_vm = module.compute.vm_id
}