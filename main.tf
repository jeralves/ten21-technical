# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

# Import vars from variables.tf
variable "prefix" {}
variable "regions" {}

# Resource groups
resource "azresource_group" "rg"{
	count = length(var.regions)
	name  = "${var.prefix}-${var.regions[count.index]}-resoursegroup"
	location = var.regions[count.index]
}

# Virtual networks
resource "az_vnets" {
	count = length(var.regions)
	name  = "${var.prefix}-${var.regions[count.index]}-vnet"
	resource_group_name = "azresource_group.rg[count.index].name"
	location            = "azresource_group.rg[count.index].location"
	address_space       = ["10.0.0.0/16"]
}

