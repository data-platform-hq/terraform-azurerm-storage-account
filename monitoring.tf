resource "azurerm_monitor_diagnostic_setting" "monitoring_storage" {
  for_each = { for k, v in var.log_analytics_workspace : k => v }

  name                           = "monitoring-${var.project}-${var.env}-${var.location}"
  target_resource_id             = azurerm_storage_account.this.id
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.destination_type

  metric {
    category = "Transaction"
    enabled  = true
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_blob" {
  for_each = { for k, v in var.log_analytics_workspace : k => v }

  name                       = "monitoring-${var.project}-${var.env}-${var.location}"
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
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_tables" {
  for_each = { for k, v in var.log_analytics_workspace : k => v }

  name                           = "monitoring-${var.project}-${var.env}-${var.location}"
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
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_queue" {
  for_each = { for k, v in var.log_analytics_workspace : k => v }

  name                           = "monitoring-${var.project}-${var.env}-${var.location}"
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
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_file" {
  for_each = { for k, v in var.log_analytics_workspace : k => v }

  name                           = "monitoring-${var.project}-${var.env}-${var.location}"
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
  }
}

