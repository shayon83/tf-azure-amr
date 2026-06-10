locals {
  private_endpoint_enabled = var.private_endpoint != null
}

resource "azurerm_managed_redis" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.sku_name

  high_availability_enabled = var.high_availability_enabled
  public_network_access     = local.private_endpoint_enabled ? "Disabled" : var.public_network_access

  default_database {
    access_keys_authentication_enabled = var.access_keys_authentication_enabled
    client_protocol                    = var.client_protocol
    clustering_policy                  = "OSSCluster"
    eviction_policy                    = var.eviction_policy
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "this" {
  count               = local.private_endpoint_enabled ? 1 : 0
  name                = "${var.name}-pe"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.private_endpoint.subnet_id

  private_service_connection {
    name                           = "${var.name}-psc"
    private_connection_resource_id = azurerm_managed_redis.this.id
    subresource_names              = ["redisEnterprise"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "redis-dns-zone-group"
    private_dns_zone_ids = [var.private_endpoint.dns_zone_id]
  }

  tags = var.tags
}
