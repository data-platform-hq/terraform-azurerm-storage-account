locals {
  ip_rules = var.ip_rules == null ? null : values(var.ip_rules)
}

resource "azurerm_storage_account" "this" {
  name = substr(replace("${var.prefix}${var.project}${var.suffix}${var.env}${var.location}", "-", ""), 0, 24)

  resource_group_name       = var.resource_group
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  access_tier               = var.access_tier
  account_replication_type  = var.replication_type
  is_hns_enabled            = var.is_hns_enabled
  enable_https_traffic_only = var.enable_https_traffic_only
  min_tls_version           = var.min_tls_version
  tags                      = var.tags

  network_rules {
    default_action             = var.default_action
    bypass                     = var.bypass
    ip_rules                   = local.ip_rules
    virtual_network_subnet_ids = var.virtual_networks
  }

  lifecycle { prevent_destroy = false }
}

resource "azurerm_role_assignment" "this" {
  for_each = {
    for permission in var.permissions : "${permission.object_id}-${permission.role}" => permission
    if permission.role != null
  }

  scope                = azurerm_storage_account.this.id
  role_definition_name = each.value.role
  principal_id         = each.value.object_id
}
