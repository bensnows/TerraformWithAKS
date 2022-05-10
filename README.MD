# Example-1

This example uses Terraform to create a resource group in Azure.

Run this example using:

```bash
cd example-1/scripts
terraform.exe apply -auto-approve #start terraform
terraform.exe destroy #destroy the services built by terraform
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


example-2
due to the exposed value  is dangerous,
the sensitive = true is necessary while exporting the password
```tf

output "registry_pw" {
  value = azurerm_container_registry.container_registry.admin_password
  sensitive = true 
}

```

example-3

following the book to create service principle by git bash under windows and the error was happened
```bash
az account show
az ad sp create-for-rbac --role="Contributor"  --scopes="/subscriptions/<subscription-id>"
WARNING: The underlying Active Directory Graph API will be replaced by Microsoft Graph API in a future version of Azure CLI. Please carefully review all breaking changes introduced during this migration: https://docs.microsoft.com/cli/azure/microsoft-graph-migration
WARNING: Creating 'Contributor' role assignment under scope 'C:/Program Files/Git/subscriptions/02b1df81-a557-4706-b3b6-e3e1242251e6'
WARNING:   Role assignment creation failed.

ERROR: Error occurred in request., InvalidSchema: No connection adapters were found for 'C:/Program Files/Git/subscriptions/02b1df81-a557-4706-b3b6-e3e1242251e6/providers/Microsoft.Authorization/roleDefinitions?$filter=roleName%20eq%20%27Contributor%27&api-version=2018-01-01-preview'
```

Add   MSYS_NO_PATHCONV=1 before the az command to solve the problem (https://github.com/Azure/azure-cli/blob/dev/doc/use_cli_with_git_bash.md#auto-translation-of-resource-ids)

```bash
MSYS_NO_PATHCONV=1 az ad sp create-for-rbac --role="Contributor"  --scopes="/subscriptions/<subscription-id>"
```


Create vm_size = "Standard_B2ms" in westus is not available,

the azure resource command is important to get the zone which can provide such scale is important
```bash
az vm list-skus --size Standard_B2ms --resource-type virtualMachines --zone --output table
```

https://docs.microsoft.com/en-us/azure/azure-resource-manager/troubleshooting/error-sku-not-available?tabs=azure-cli


Inject aks credentials to kubectl
az aks get-credentials --resource-group <your-app-name>  --name <your-app-name>

Install dashboard to AKS
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.4/aio/deploy/recommended.yaml