  #DC
    #Public IP
        resource "azurerm_public_ip" "public_ip_dc" {
        name                = "${var.public_ip_dc_name}"
        resource_group_name = "${var.resource_group_name}"
        location            = var.location
        allocation_method   = "Static"
        # Static IP address allocation for DC
        }
    #NIC DC
    resource "azurerm_network_interface" "nic_dc" {
      name                = "${var.dc_vm_name}-nic"
      resource_group_name = "${var.resource_group_name}"
      location            = var.location

      ip_configuration {
        name                          = "dc-internal"
        subnet_id                     = var.subnet
        private_ip_address_allocation = "Static"
        private_ip_address            = "${var.dc_private_ip_address}"
        public_ip_address_id          = azurerm_public_ip.public_ip_dc.id
      }
    }
    #DC VM
      resource "azurerm_windows_virtual_machine" "vm_dc" {
      depends_on = [azurerm_network_interface.nic_dc]
      name                = "${var.dc_vm_name}"
      resource_group_name = "${var.resource_group_name}"
      location            = var.location
      size                = "${var.dc_vm_size}"
      admin_username      = "${var.admin_username}"
      admin_password      = "${var.admin_password}"
      network_interface_ids = [
        azurerm_network_interface.nic_dc.id,
      ]

      os_disk {
        caching              = "${var.os_disk_caching}"
        storage_account_type = "${var.os_disk_storage_type}"
      }

      source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "${var.windows_version_sku}"
        version   = "${var.windows_version_version}"
      }
    }

    ## VM Members
        #Public IP VM
        resource "azurerm_public_ip" "public_ip_vm" {
        count = "${var.count_vm}"
        name  = "${var.public_ip_vm1_name}-${count.index + 1}"
        #count (repeated block of code)
        resource_group_name = "${var.resource_group_name}"
        location            = var.location
        allocation_method   = "Static"
        }
        #NIC VM
        resource "azurerm_network_interface" "nic_vm" {
        depends_on = [ azurerm_network_interface.nic_dc ]
        count = "${var.count_vm}"
        name                = "${var.vm1_name}-nic-${count.index + 1}"
        #count (repeated block of code)
        resource_group_name = "${var.resource_group_name}"
        location            = var.location

        ip_configuration {
          name                          = "vm_internal"
          subnet_id                     = var.subnet
          private_ip_address_allocation = "Dynamic"
          # Dynamic IP address allocation for VMs
          public_ip_address_id          = azurerm_public_ip.public_ip_vm[count.index].id
          #count - identify the public IP
          #azurerm_public_ip.public_ip_vm[count.index].id,
        }
      }
    #Create VM
      resource "azurerm_windows_virtual_machine" "vm" {
      count = "${var.count_vm}"
      #count (repeated block of code)
      depends_on = [azurerm_network_interface.nic_vm]
      name                = "${var.vm1_name}-${count.index + 1}"
      resource_group_name = "${var.resource_group_name}"
      location            = var.location
      size                = "${var.vm1_size}"
      admin_username      = "${var.admin_username}"
      admin_password      = "${var.admin_password}"
      network_interface_ids = [
      azurerm_network_interface.nic_vm[count.index].id,
      #count - identify the network interface
      #azurerm_network_interface.nic_vm[count.index].id,
      ]

      os_disk {
        caching              = "${var.os_disk_caching}"
        storage_account_type = "${var.os_disk_storage_type}"
      }

      source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "${var.windows_version_sku}"
        version   = "${var.windows_version_version}"
      }
    }