# Introduction 
  Create test environment with VMs - Windows Servers , one of them is a Domain Controller and the other are 
  member servers. Platform MS Azure.
  Use for test environments , passwords are not encrypted!  </br>
 !! Parameters pls. add to terraform.tfvars file !! </br>
  The Domain Controller is created first and then the member server is joined to the domain. </br>
  MK (C) Free for use! Part for AD-Forest code based on https://github.com/cfalta/activedirectory-lab?tab=BSD-3-Clause-1-ov-file - Copyright (c) 2021, Christoph Falta.

# Version
## Version History

| Version | Date       | Description                                                                 |
|---------|------------|-----------------------------------------------------------------------------|
| v0.9    | 04.05.2025 | Create script                                                              |
| v0.91   | 05.05.2025 | Added vars and dependency                                                  |
| v0.92   | 09.05.2025 | Modify time sleep                                                         |
| v0.93   | 10.05.2025 | Added domain join for VM2                                                 |
| v0.94   | 10.05.2025 | Update structure and vars                                                 |
| v0.95   | 19.05.2025 | Created modules for network, compute, and Active Directory                |
| v0.96   | 16.06.2025 | Added variables for compute module, count_vm variable, and vm_ids output  |
| v0.97   | 17.06.2025 | Optimization - removed unused vars, commented in compute module           |
| v0.98   | 25.06.2025 | Review                                                                    |
| v0.99   | 26.06.2025 | Update credentials vars                                                   |
| v1.00   | 27.06.2025 | Updated README                                                            |


# Warranty 
Creator is not responsible aboout issues and damges caused by run this code or modification. Use only for testing.

# Getting Started
1. Azure Subscription
2. Terraform - https://developer.hashicorp.com/terraform/install
3. Recommended - Visual Studio Code
4. Create config file "provider.tf" or update maint.tf </br>

Provider.tf example: </br>
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.22.0" # Specify the version you want to use
    }
   }
     required_version = ">= 1.5.7" # Specify the Terraform version you want to use
}
 provider "azurerm" {
  features {}
  subscription_id = "your subscription"
}

</br>
https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build






# Build and Test
1. terraform init
2. terraform validate
3. terraform plan
4. terraform apply
5. Write local password
6. Write number of VMs max based on your limitation in Az-subscription recomended is 8.
7. Write domain password
8. Write domain recovery password.

Note! Passwords must be complex..


# Contribute
TODO: Explain how other users and developers can contribute to make your code better. 

If you want to learn more about creating good readme files then refer the following [guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/git/create-a-readme?view=azure-devops). You can also seek inspiration from the below readme files:
- [Visual Studio Code](https://github.com/Microsoft/vscode)
- Terraform - https://developer.hashicorp.com/terraform/docs
