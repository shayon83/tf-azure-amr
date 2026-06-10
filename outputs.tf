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

output "private_endpoint_id" {
  description = "Resource ID of the private endpoint (null when private_endpoint variable is not set)."
  value       = local.private_endpoint_enabled ? azurerm_private_endpoint.this[0].id : null
}

output "private_ip_address" {
  description = "Private IP address assigned to the Redis endpoint NIC (null when private_endpoint variable is not set)."
  value       = local.private_endpoint_enabled ? azurerm_private_endpoint.this[0].private_service_connection[0].private_ip_address : null
}
