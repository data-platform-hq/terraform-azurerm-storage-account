resource "azurerm_monitor_diagnostic_setting" "monitoring_storage" {
  for_each = var.log_analytics_workspace

  name                           = "monitoring-${var.project}-${var.env}-${var.location}"
  target_resource_id             = azurerm_storage_account.this.id
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.destination_type

  metric {
    category = "Transaction"
    enabled  = true
    retention_policy {
      enabled = false
      days    = var.metric_retention_days
    }
  }

  metric {
    category = "Capacity"
    enabled  = true
    retention_policy {
      enabled = false
      days    = var.metric_retention_days
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_blob" {
  for_each = var.log_analytics_workspace

  name                       = "monitoring-${var.project}-${var.env}-${var.location}"
  target_resource_id         = "${azurerm_storage_account.this.id}/blobServices/default"
  log_analytics_workspace_id = each.value

  dynamic "enabled_log" {
    for_each = var.log_category_list
    content {
      category = enabled_log.value
      retention_policy {
        enabled = true
        days    = var.log_retention_days
      }
    }
  }

  metric {
    category = "Transaction"
    enabled  = true
    retention_policy {
      enabled = false
      days    = var.metric_retention_days
    }
  }

  metric {
    category = "Capacity"
    enabled  = true
    retention_policy {
      enabled = false
      days    = var.metric_retention_days
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_tables" {
  for_each = var.log_analytics_workspace

  name                           = "monitoring-${var.project}-${var.env}-${var.location}"
  target_resource_id             = "${azurerm_storage_account.this.id}/tableServices/default"
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.destination_type

  dynamic "enabled_log" {
    for_each = var.log_category_list
    content {
      category = enabled_log.value
      retention_policy {
        enabled = true
        days    = var.log_retention_days
      }
    }
  }

  metric {
    category = "Transaction"
    enabled  = true
    retention_policy {
      enabled = false
      days    = var.metric_retention_days
    }
  }

  metric {
    category = "Capacity"
    enabled  = true
    retention_policy {
      enabled = false
      days    = var.metric_retention_days
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_queue" {
  for_each = var.log_analytics_workspace

  name                           = "monitoring-${var.project}-${var.env}-${var.location}"
  target_resource_id             = "${azurerm_storage_account.this.id}/queueServices/default"
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.destination_type

  dynamic "enabled_log" {
    for_each = var.log_category_list
    content {
      category = enabled_log.value
      retention_policy {
        enabled = true
        days    = var.log_retention_days
      }
    }
  }

  metric {
    category = "Transaction"
    enabled  = true
    retention_policy {
      enabled = false
      days    = var.metric_retention_days
    }
  }

  metric {
    category = "Capacity"
    enabled  = true
    retention_policy {
      enabled = false
      days    = var.metric_retention_days
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_file" {
  for_each = var.log_analytics_workspace

  name                           = "monitoring-${var.project}-${var.env}-${var.location}"
  target_resource_id             = "${azurerm_storage_account.this.id}/fileServices/default"
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.destination_type

  dynamic "enabled_log" {
    for_each = var.log_category_list
    content {
      category = enabled_log.value
      retention_policy {
        enabled = true
        days    = var.log_retention_days
      }
    }
  }

  metric {
    category = "Transaction"
    enabled  = true
    retention_policy {
      enabled = true
      days    = var.metric_retention_days
    }
  }

  metric {
    category = "Capacity"
    enabled  = true
    retention_policy {
      enabled = true
      days    = var.metric_retention_days
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}
