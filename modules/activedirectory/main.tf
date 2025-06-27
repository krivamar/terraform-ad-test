############## AD - Promoting DC "tf-dc1" to Domain Controller ##############
  locals { 
  import_command       = "Import-Module ADDSDeployment"
  password_command     = "$password = ConvertTo-SecureString ${var.safemode_password} -AsPlainText -Force"
  install_ad_command   = "Add-WindowsFeature -name ad-domain-services -IncludeManagementTools"
  configure_ad_command = "Install-ADDSForest -CreateDnsDelegation:$false -DomainMode ${var.domain_mode} -DomainName ${var.active_directory_domain} -DomainNetbiosName ${var.active_directory_netbios_name} -ForestMode Win2025 -InstallDns:$true -SafeModeAdministratorPassword $password -Force:$true"
  shutdown_command     = "shutdown -r -t 10"

  
  #declarations of the exit code hack to avoid the script to fail if the command is not found:
  powershell_command   = "${local.import_command}; ${local.password_command}; ${local.install_ad_command}; ${local.configure_ad_command}; ${local.shutdown_command}; ${local.exit_code_hack}"
  
  exit_code_hack       = "exit 0"

  #Disable local firewall on the DC VM.
  #disable_fw          = "Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False"
  #powershell_command_disable_fw   = "${local.disable_fw}; ${local.exit_code_hack}"
  }

# Create Active Directory Forest, Runs the PowerShell script on the Windows VM.
    resource "azurerm_virtual_machine_extension" "create-active-directory-forest" {
    #https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension
    depends_on = [var.dc_vm_comp]
    name                 = "create-active-directory-forest"
    virtual_machine_id   =  var.dc_vm_comp
    publisher            = "Microsoft.Compute"
    type                 = "CustomScriptExtension"
    type_handler_version = "1.9"

    #executes the combined AD setup script defined in the locals.
    settings = <<SETTINGS
      {
          "commandToExecute": "powershell.exe -Command \"${local.powershell_command}\""
      }
    SETTINGS
    }
    
###### AD Join member VM to domain ######

  #### Sleep Before join to domain #####
  resource "time_sleep" "wait_seconds" {
    depends_on = [azurerm_virtual_machine_extension.create-active-directory-forest]
    create_duration = "${var.time_sleep}" # Wait for nn minutes before joining the domain
  }

  resource "azurerm_virtual_machine_extension" "configure-and-join-domain_vm" {
  count               = length(var.vm_ids)
  depends_on          = [time_sleep.wait_seconds,
                        var.vm_ids]
  name                = "configure-and-join-domain_vm${count.index + 1}"
  virtual_machine_id  = var.vm_ids[count.index]
  publisher           = "Microsoft.Compute"
  type                = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "commandToExecute": "powershell.exe -Command \"Add-Computer -DomainName ${var.active_directory_domain} -Credential (New-Object System.Management.Automation.PSCredential('${var.active_directory_domain}\\${var.domadminuser}', (ConvertTo-SecureString '${var.domadminpassword}' -AsPlainText -Force))) -Restart\""
    }
SETTINGS
  #* The command above will join the VM to the domain and restart it.
}