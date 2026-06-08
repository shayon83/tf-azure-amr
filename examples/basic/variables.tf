variable "subscription_id" {
  description = "Azure subscription ID to deploy into."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to create."
  type        = string
  default     = "rg-managed-redis-dev"
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "eastus"
}

variable "name" {
  description = "Name of the Azure Managed Redis instance."
  type        = string
  default     = "redis-dev-001"
}

variable "sku_name" {
  description = "SKU for the Redis instance. Balanced_B0 is the cheapest at ~$11.68/mo."
  type        = string
  default     = "Balanced_B0"
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
