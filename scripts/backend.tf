# Sets the "backend" used to store Terraform state.
# This is required to make continous delivery work.

terraform {
    backend "azurerm" {
        resource_group_name  = "flixtube"
        storage_account_name = "testbucketstorage"
        container_name       = "testbucketstorage"
        key                  = "terraform.tfstate"
    }
}