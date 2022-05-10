# Example-1

This example uses Terraform to create a resource group in Azure.

Run this example using:

```bash
cd example-1/scripts
terraform apply
```


Error was happened when using the azurerm 1.38.0 version 
```bash
1909002@1909002NB50 MINGW64 /d/MicroserviceTraining/Sample/working/scripts (master)
$ terraform.exe apply
╷
│ Warning: Version constraints inside provider configuration blocks are deprecated
│
│   on providers.tf line 4, in provider "azurerm":
│    4:     version = "1.38.0"
│
│ Terraform 0.13 and earlier allowed provider version constraints inside the
│ provider configuration block, but that is now deprecated and will be
│ removed in a future version of Terraform. To silence this warning, move the
│ provider version constraint into the required_providers block.
╵
╷
│ Error: Error building AzureRM Client: Error populating Client ID from the Azure CLI: No Authorization Tokens were found - please ensure the Azure CLI is installed and then log-in with `az login`.
│
│   with provider["registry.terraform.io/hashicorp/azurerm"],
│   on providers.tf line 3, in provider "azurerm":
│    3: provider "azurerm" {
│
╵
```

the provider.tf was replaced by newer version 
```tf
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
```