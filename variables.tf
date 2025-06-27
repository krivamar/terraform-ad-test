#Varriable setting

## Infra

  # Resource Group Name
  variable "resource_group_name" {
    type = string
    description = "The name of the resource group"
  }

  # Location
  variable "location" {
    type = string
    description = "The Azure region to deploy the resources"
  }

  # Vnet Name
  variable "vnet_name" {
    type = string
    description = "The name of the virtual network"
  }

  # Adress Space
  variable "address_space" {
    type = string
    description = "The address space of the virtual network"
  }

  # Subnet Name
  variable "subnet_name" {
    type = string
    description = "The name of the subnet"
  }

  # Subnet Prefix
  variable "subnet_prefix" {
  type = string
  description = "The address space of the subnet"
  }

  # NSG Name
  variable "nsg_name" {
    type = string
    description = "The name of the network security group"
  }


  # NSG Rule RDP Allow
  variable "nsg_rule_rdp_allow" {
    type = string
    description = "The name of the network security group rule"
  }

  # NSG Rule WINRM Allow
  variable "nsg_rule_winrm_allow" {
    type = string
    description = "The name of the network security group rule"
  }

#DC VM
  # Public IP Name
  variable "public_ip_dc_name" {
    type = string
    description = "The name of the public IP address"
  }

  # DC VM Name
  variable "dc_vm_name" {
    type = string
    description = "The name of the DC VM"
  }

  #VM DC Size
  variable "dc_vm_size" {
    type = string
    description = "The size of the DC VM"
  }

  # IP DC VM
  variable "dc_private_ip_address" {
    type = string
    description = "The private IP address of the DC VM"
  }

# VMs

  #VM admin username
  variable "admin_username" {
    type = string
    description = "The username for the VMs"
  }

  #VM admin password
  variable "admin_password" {
    type = string
    sensitive = true
    description = "The password for the VMs"
  }

  #VM OS disk caching
  variable "os_disk_caching" {
    type = string
    description = "The caching type for the OS disk"
  }

  #VM OS disk storage type
  variable "os_disk_storage_type" {
    type = string
    description = "The storage type for the OS disk"
  }

  #VM Windows version SKU
  variable "windows_version_sku" {
    type = string
    description = "The version of Windows to use for the VM"
  }

  #VM Windows version version
  variable "windows_version_version" {
    type = string
    description = "The version of Windows to use for the VM"
  }

  #VM1 Public IP Name
  variable "public_ip_vm1_name" {
    type = string
    description = "The name of the public IP address for VM1"
  }

  #VM1 Name
  variable "vm1_name" {
    type = string
    description = "The name of the VM1"
  }

  #VM1 Size
  variable "vm1_size" {
    type = string
    description = "The size of the VM1"
  }

    variable "count_vm" {}


## AD

  #active directory FQDN
    variable "active_directory_domain" {
    type = string
    description = "The name of the Active Directory domain, for example `consoto.local`"
  }

  #active directory netbios name
  variable "active_directory_netbios_name" {
    type = string
    description = "The NetBIOS name of the Active Directory domain, for example `CONTOSO`"
  }

  #AD domain mode
  variable "domain_mode" {
    type = string
    description = "The domain mode for the Active Directory domain, for example `Windows2019`"
  }

  #safemode password
  variable "safemode_password" {
    type = string
    sensitive = true
    description = "The password associated with the local administrator account on the virtual machine"
  }

  #Username for the default domain admin
  variable "domadminuser" {
    type = string
  }

  #Password for the default domain admin
  variable "domadminpassword" {
    type = string
    sensitive = true
  }

  #time sleep
  variable "time_sleep" {
    type = string
    description = "Time to sleep in seconds before join VM to domain"
  }

  variable "dc_vm_id" {
    description = "ID of the domain controller VM"
    type        = string
    default = "dcvmid1"
  }

  variable "subnet_id" {
    description = "The ID of the subnet for the VM NIC"
    type        = string
    default     = "subnetid1"
  }
  variable "dc_vm_comp" {
    description = "ID of the domain controller VM"
    type        = string
    default     = "dcvmid2"
  }