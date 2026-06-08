output "hostname" {
  description = "The FQDN used to connect to the Redis instance."
  value       = module.managed_redis.hostname
}

output "port" {
  description = "The port the Redis database listens on."
  value       = module.managed_redis.port
}

output "primary_access_key" {
  description = "Primary access key (sensitive)."
  value       = module.managed_redis.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "Secondary access key (sensitive)."
  value       = module.managed_redis.secondary_access_key
  sensitive   = true
}
