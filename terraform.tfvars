#### Infra Variables ####
resource_group_name = "az-terraform-rg"
location = "East US"

#Network Variables
dc_private_ip_address = "10.0.1.4"
#vm_private_ip_address = "10.0.1.5"
#vm2_private_ip_address = "10.0.1.6"
vnet_name = "az-tf-vnet"
address_space = "10.0.0.0/16"
subnet_name = "az-tf-subnet"
subnet_prefix = "10.0.1.0/24"
nsg_name = "az-tf-nsg"
nsg_rule_rdp_allow = "Allow" # Allow|Deny RDP access - 3389
nsg_rule_winrm_allow = "Deny" # Allow|Deny WinRM access - 5985
public_ip_dc_name = "az-tf-dc-pip"

#Local Credentials Variables
admin_username = "adminuser"
#admin_password = ""

#### AD Domain Variables ####
#domadminpassword = ""
#safemode_password = ""
active_directory_domain = "contoso.local"
active_directory_netbios_name = "CONTOSO"
domain_mode = "Win2025"
domadminuser = "adminuser"
# Time sleep modify based on your network speed and performance of environment, short time may cause errors during join VMs to domain. Default is 10 minutes
time_sleep = "600s"

# DC VM Variables
dc_vm_name = "tf-dc1"
dc_vm_size = "Standard_F2"

# All VMs Disks and OS Variables
os_disk_caching = "ReadWrite"
os_disk_storage_type = "StandardSSD_LRS"
windows_version_sku = "2025-Datacenter"
windows_version_version = "latest"

#VM1 Variables
public_ip_vm1_name = "az-tf-vm1-pip"
vm1_name = "tf-vm1"
vm1_size = "Standard_F2"