terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.4"
}

provider "azurerm" {
  features {}
  subscription_id = "b86a521f-c7a0-48c6-a0eb-f0d96d10f8ab"
}

