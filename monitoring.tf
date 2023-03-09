locals {
  diagnostics_name = var.custom_diagnostics_name == null ? "${var.project}-${var.env}-${var.location}" : var.custom_diagnostics_name
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_storage" {
  for_each = var.log_analytics_workspace

  name                           = "storage-${local.diagnostics_name}"
  target_resource_id             = azurerm_storage_account.this.id
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.destination_type

  metric {
    category = "Transaction"
    enabled  = true
    retention_policy {
      enabled = false
      days    = 0
    }
  }

  metric {
    category = "Capacity"
    enabled  = true
    retention_policy {
      enabled = false
      days    = 0
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_blob" {
  for_each = var.log_analytics_workspace

  name                       = "blob-${local.diagnostics_name}"
  target_resource_id         = "${azurerm_storage_account.this.id}/blobServices/default"
  log_analytics_workspace_id = each.value

  dynamic "enabled_log" {
    for_each = var.log_category_list
    content {
      category = enabled_log.value
    }
  }

  metric {
    category = "Transaction"
    enabled  = true
    retention_policy {
      enabled = false
      days    = 0
    }
  }

  metric {
    category = "Capacity"
    enabled  = true
    retention_policy {
      enabled = false
      days    = 0
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_tables" {
  for_each = var.log_analytics_workspace

  name                           = "table-${local.diagnostics_name}"
  target_resource_id             = "${azurerm_storage_account.this.id}/tableServices/default"
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.destination_type

  dynamic "enabled_log" {
    for_each = var.log_category_list
    content {
      category = enabled_log.value
    }
  }

  metric {
    category = "Transaction"
    enabled  = true
    retention_policy {
      enabled = false
      days    = 0
    }
  }

  metric {
    category = "Capacity"
    enabled  = true
    retention_policy {
      enabled = false
      days    = 0
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_queue" {
  for_each = var.log_analytics_workspace

  name                           = "queue-${local.diagnostics_name}"
  target_resource_id             = "${azurerm_storage_account.this.id}/queueServices/default"
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.destination_type

  dynamic "enabled_log" {
    for_each = var.log_category_list
    content {
      category = enabled_log.value
    }
  }

  metric {
    category = "Transaction"
    enabled  = true
    retention_policy {
      enabled = false
      days    = 0
    }
  }

  metric {
    category = "Capacity"
    enabled  = true
    retention_policy {
      enabled = false
      days    = 0
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_file" {
  for_each = var.log_analytics_workspace

  name                           = "file-${local.diagnostics_name}"
  target_resource_id             = "${azurerm_storage_account.this.id}/fileServices/default"
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.destination_type

  dynamic "enabled_log" {
    for_each = var.log_category_list
    content {
      category = enabled_log.value
    }
  }

  metric {
    category = "Transaction"
    enabled  = true
    retention_policy {
      enabled = false
      days    = 0
    }
  }

  metric {
    category = "Capacity"
    enabled  = true
    retention_policy {
      enabled = false
      days    = 0
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}
