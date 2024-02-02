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
resource "azurerm_resource_group" "rg"{
	count = length(var.regions)
	name  = "${var.prefix}-${var.regions[count.index]}-resoursegroup"
	location = var.regions[count.index]
}

# Virtual networks
resource "azurerm_virtual_network" "vn"{
	count = length(var.regions)
	name  = "${var.prefix}-${var.regions[count.index]}-vnet"
	resource_group_name = "azurerm_resource_group.rg[count.index].name"
	location            = "azurerm_resource_group.rg[count.index].location"
	address_space       = ["10.0.0.0/16"]
}

# SQL Database
resource "azurerm_resource_group" "rg2" {
	name = "azresource_group_db"
	location = "West Europe"
}

resource "azurerm_sql_server" "sqlserver" {
	name                         = "example-sql-server"
	resource_group_name          = azurerm_resource_group.example.name
	location                     = azurerm_resource_group.example.location
	administrator_login          = "admin"
	administrator_login_password = "r00t" 
}

resource "azurerm_sql_database" "sqldb" {
	name = "azdb_sql"
	resource_group_name = azurerm_resource_group.rg2.name
	server = azurerm_sql_server.sqlserver.name
}

# Deploy web application image to Kubernetes clusters
resource "kubernetes_deployment" "webapp" {
	count = length(var.regions)
	#another params 
}
