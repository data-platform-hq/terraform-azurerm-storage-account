locals {
  ip_rules             = var.ip_rules == null ? null : values(var.ip_rules)
  storage_account_name = substr(replace(var.custom_storage_account_name == null ? "${var.prefix}${var.project}${var.suffix}${var.env}${var.location}" : "${var.prefix}${var.custom_storage_account_name}${var.suffix}", "-", ""), 0, 24)

  # Object with parameters to assign required role to Global Azure Key Vault Principal Id to perform automated Storage Account Access Key rotations
  global_key_vault_sp_role_assignment = var.key_vault_managed_storage_keys_enabled ? [{
    name      = "global_key_vault"
    object_id = var.key_vault_global_object_id # The Global Key Vault Principal Object ID
    role      = "Storage Account Key Operator Service Role"
  }] : []

  # Creates composite list of objects that is used in role assignment creation
  permissions_objects_list = concat(var.permissions, local.global_key_vault_sp_role_assignment)
}

resource "azurerm_storage_account" "this" {
  name                            = local.storage_account_name
  resource_group_name             = var.resource_group
  location                        = var.location
  account_kind                    = var.account_kind
  account_tier                    = var.account_tier
  access_tier                     = var.access_tier
  account_replication_type        = var.replication_type
  is_hns_enabled                  = var.is_hns_enabled
  enable_https_traffic_only       = var.enable_https_traffic_only
  min_tls_version                 = var.min_tls_version
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  tags                            = var.tags

  blob_properties {
    dynamic "cors_rule" {
      for_each = var.blob_cors_rules
      content {
        allowed_headers    = cors_rule.value.allowed_headers
        allowed_methods    = cors_rule.value.allowed_methods
        allowed_origins    = cors_rule.value.allowed_origins
        exposed_headers    = cors_rule.value.exposed_headers
        max_age_in_seconds = cors_rule.value.max_age_in_seconds
      }
    }
  }

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
    for permission in local.permissions_objects_list : "${permission.object_id}-${permission.role}" => permission
    if permission.role != null
  }

  scope                = azurerm_storage_account.this.id
  role_definition_name = each.value.role
  principal_id         = each.value.object_id
}

# Creates automated Storage Account Access Key rotations using Key Vault.
resource "azurerm_key_vault_managed_storage_account" "this" {
  for_each = var.key_vault_managed_storage_keys_enabled ? toset(["key1", "key2"]) : []

  name                         = each.key
  key_vault_id                 = var.key_vault_id
  storage_account_id           = azurerm_storage_account.this.id
  storage_account_key          = each.key
  regenerate_key_automatically = var.regenerate_key_automatically
  regeneration_period          = var.regeneration_period

  depends_on = [azurerm_role_assignment.this]
}
