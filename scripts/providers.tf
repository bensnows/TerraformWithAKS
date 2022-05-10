# Initialises Terraform providers and sets their version numbers.

# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = "02b1df81-a557-4706-b3b6-e3e1242251e6"
}
provider "tls" {
    version = "2.1.0"
}
