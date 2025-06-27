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
  subscription_id = "9174b98d-a763-47ad-a94a-ca7066b103c6"
}