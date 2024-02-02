# variables.tf

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "webappsurveycortoso"
}

variable "regions" {
  description = "List of Azure regions"
  type        = list(string)
  default     = ["East US", "West US", "Central Europe", "East Asia", "Australia East"]
}
