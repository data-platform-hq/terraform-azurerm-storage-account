resource "azurerm_monitor_diagnostic_setting" "monitoring_storage" {
  for_each = { for k, v in var.log_analytics_workspace : k => v }

  name                           = "monitoring-${var.project}-${var.env}-${var.location}"
  target_resource_id             = azurerm_storage_account.this.id
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.destination_type

  metric {
    category = "Transaction"
    enabled  = true

    retention_policy {
      days    = var.metric_retention_days
      enabled = false
    }
  }

  depends_on = [azurerm_storage_account.this]
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_blob" {
  for_each = { for k, v in var.log_analytics_workspace : k => v }

  name                       = "monitoring-${var.project}-${var.env}-${var.location}"
  target_resource_id         = "${azurerm_storage_account.this.id}/blobServices/default"
  log_analytics_workspace_id = each.value

  dynamic "log" {
    for_each = var.log_category_list
    content {
      category = log.value
      enabled  = true

      retention_policy {
        days    = var.log_retention_days
        enabled = false
      }
    }
  }

  metric {
    category = "Transaction"
    enabled  = true

    retention_policy {
      days    = var.metric_retention_days
      enabled = false
    }
  }

  depends_on = [azurerm_storage_account.this]
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_tableServices" {
  for_each = { for k, v in var.log_analytics_workspace : k => v }

  name                           = "monitoring-${var.project}-${var.env}-${var.location}"
  target_resource_id             = "${azurerm_storage_account.this.id}/tableServices/default"
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.destination_type

  dynamic "log" {
    for_each = var.log_category_list
    content {
      category = log.value
      enabled  = true

      retention_policy {
        days    = var.log_retention_days
        enabled = false
      }
    }
  }

  metric {
    category = "Transaction"
    enabled  = true

    retention_policy {
      days    = var.metric_retention_days
      enabled = false
    }
  }

 depends_on = [azurerm_storage_account.this]
}