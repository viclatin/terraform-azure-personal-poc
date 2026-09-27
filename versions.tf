terraform {
  required_version = "~> 1.16"

  cloud {
    organization = "terraform-azure-personal-poc"

    workspaces {
      name = "terraform-azure-personal-poc"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }
}