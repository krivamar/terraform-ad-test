    #Vnet
        resource "azurerm_virtual_network" "vnet" {
        name                = "${var.vnet_name}"
        location            = var.location
        resource_group_name = "${var.resource_group_name}"
        address_space       = ["${var.address_space}"]
        dns_servers         = ["${var.dc_private_ip_address}"] # DNS server IP address from DC!
        }
     # Subnet
        resource "azurerm_subnet" "subnet" {
        name                 = "${var.subnet_name}"
        resource_group_name  = "${var.resource_group_name}"
        virtual_network_name = azurerm_virtual_network.vnet.name
        address_prefixes     = ["${var.subnet_prefix}"]
        }

    # Network Security Group
        # NSG with 2 rule allowing RDP connection and WINRM connection port 5986
            resource "azurerm_network_security_group" "nsg" {
                name                = "${var.nsg_name}"
                location            = var.location
                resource_group_name = "${var.resource_group_name}"

            security_rule {
                name                       = "RDP"
                priority                   = 1001
                direction                  = "Inbound"
                access                     = "${var.nsg_rule_rdp_allow}"
                protocol                   = "Tcp"
                source_port_range          = "*"
                destination_port_range     = "3389"
                source_address_prefix      = "*"
                destination_address_prefix = "*"
            }
                # WinRM rule - optional
            security_rule {
                name                       = "WINRM"
                priority                   = 1002
                direction                  = "Inbound"
                access                     = "${var.nsg_rule_winrm_allow}"
                protocol                   = "Tcp"
                source_port_range          = "*"
                destination_port_range     = "5986"
                source_address_prefix      = "*"
                destination_address_prefix = "*"
                }
            }

    # NSG association with subnet
        resource "azurerm_subnet_network_security_group_association" "example" {
        subnet_id                 = azurerm_subnet.subnet.id
        network_security_group_id = azurerm_network_security_group.nsg.id
        }