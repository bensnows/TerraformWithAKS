# Initialises Terraform providers and sets their version numbers.

# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "1.38.0"
    }
    tls = {
      version = "2.1.0"
    }

    kubernetes = {
      version = "1.10.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = "02b1df81-a557-4706-b3b6-e3e1242251e6"
}
# provider "tls" {
#     version = "2.1.0"
# }

provider "kubernetes" {

  host = azurerm_kubernetes_cluster.cluster.kube_config[0].host

  client_certificate     = base64decode(azurerm_kubernetes_cluster.cluster.kube_config[0].client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.cluster.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate)
}
