   output "dc_vm_id" {
   value = azurerm_windows_virtual_machine.vm_dc.id
   }
   # This output provides the ID of the Domain Controller VM. 
   # This is useful for other modules or resources that need to reference the DC VM.
   
   output "vm_id" {
    description = "The ID of the member VM"
     value       = azurerm_windows_virtual_machine.vm[*].id
     #identify the VM by its index [*] splat operator
     # This output provides the IDs of the member VMs created in the compute module.
     # This is useful for other modules or resources that need to reference these VMs.
     # The [*].id syntax collects the id attribute from each VM in the resource (when using count or for_each).
      }