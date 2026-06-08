output "id" {
  description = "The resource ID of the Azure Managed Redis instance."
  value       = azurerm_managed_redis.this.id
}

output "hostname" {
  description = "The FQDN used to connect to the Redis instance."
  value       = azurerm_managed_redis.this.hostname
}

output "port" {
  description = "The port the Redis database listens on (typically 10000 for TLS)."
  value       = azurerm_managed_redis.this.default_database[0].port
}

output "primary_access_key" {
  description = "Primary access key for authenticating with the Redis instance."
  value       = azurerm_managed_redis.this.default_database[0].primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "Secondary access key for authenticating with the Redis instance."
  value       = azurerm_managed_redis.this.default_database[0].secondary_access_key
  sensitive   = true
}
