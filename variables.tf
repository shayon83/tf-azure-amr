variable "name" {
  description = "Name of the Azure Managed Redis instance."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the Redis instance. Must already exist."
  type        = string
}

variable "location" {
  description = "Azure region where the Redis instance will be created (e.g. \"eastus\")."
  type        = string
}

variable "sku_name" {
  description = "SKU of the Azure Managed Redis instance. Smallest options: Balanced_B0 (~$11.68/mo), Balanced_B1 (~$23.36/mo), Balanced_B3 (~$47.45/mo)."
  type        = string
  default     = "Balanced_B0"

  validation {
    condition     = can(regex("^(Balanced_B|MemoryOptimized_M|ComputeOptimized_X|FlashOptimized_A)", var.sku_name))
    error_message = "sku_name must start with one of: Balanced_B, MemoryOptimized_M, ComputeOptimized_X, FlashOptimized_A."
  }
}

variable "high_availability_enabled" {
  description = "Whether high availability is enabled. WARNING: this field is immutable — changing it after creation forces resource replacement."
  type        = bool
  default     = true
}

variable "public_network_access" {
  description = "Whether public network access is enabled. Use \"Disabled\" with private endpoints in production."
  type        = string
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Disabled"], var.public_network_access)
    error_message = "public_network_access must be \"Enabled\" or \"Disabled\"."
  }
}

variable "eviction_policy" {
  description = "Cache eviction policy. VolatileLRU evicts keys with a TTL set, which is the standard policy for an application cache."
  type        = string
  default     = "VolatileLRU"

  validation {
    condition = contains([
      "AllKeysLFU", "AllKeysLRU", "AllKeysRandom",
      "NoEviction",
      "VolatileLFU", "VolatileLRU", "VolatileRandom", "VolatileTTL",
    ], var.eviction_policy)
    error_message = "eviction_policy must be a valid Redis eviction policy."
  }
}

variable "client_protocol" {
  description = "Protocol clients must use to connect. \"Encrypted\" enforces TLS; \"Plaintext\" allows unencrypted connections."
  type        = string
  default     = "Encrypted"

  validation {
    condition     = contains(["Encrypted", "Plaintext"], var.client_protocol)
    error_message = "client_protocol must be \"Encrypted\" or \"Plaintext\"."
  }
}

variable "access_keys_authentication_enabled" {
  description = "Whether access key authentication is enabled. Required for most application connection strings."
  type        = bool
  default     = true
}

variable "private_endpoint" {
  description = "Private endpoint configuration. When set, public_network_access is forced to Disabled. The dns_zone_id must reference a privatelink.redis.azure.net zone that is already linked to the VNet."
  type = object({
    subnet_id   = string
    dns_zone_id = string
  })
  default = null
}

variable "tags" {
  description = "Tags to apply to the Redis instance."
  type        = map(string)
  default     = {}
}
