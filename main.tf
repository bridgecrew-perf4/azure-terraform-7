# terraform {
#  backend "azurerm" {
#    storage_account_name = "sttfstate1"
#    container_name       = "tfstate"
#    key                  = "aks.tfstate"
#  }
# }

provider "azurerm" {
  version = "~> 2.42.0"
  features {}
}
