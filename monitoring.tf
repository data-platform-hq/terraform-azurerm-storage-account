data "azurerm_monitor_diagnostic_categories" "this" {
  for_each    = var.log_analytics_workspace
  resource_id = azurerm_storage_account.this.id
}

data "azurerm_monitor_diagnostic_categories" "monitoring_blob" {
  for_each    = var.log_analytics_workspace
  resource_id = "${azurerm_storage_account.this.id}/blobServices/default"
}

data "azurerm_monitor_diagnostic_categories" "monitoring_tables" {
  for_each    = var.log_analytics_workspace
  resource_id = "${azurerm_storage_account.this.id}/tableServices/default"
}

data "azurerm_monitor_diagnostic_categories" "monitoring_queue" {
  for_each    = var.log_analytics_workspace
  resource_id = "${azurerm_storage_account.this.id}/queueServices/default"
}

data "azurerm_monitor_diagnostic_categories" "monitoring_file" {
  for_each    = var.log_analytics_workspace
  resource_id = "${azurerm_storage_account.this.id}/fileServices/default"
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_storage" {
  for_each = var.log_analytics_workspace

  name                           = "monitoring-${var.project}-${var.env}-${var.location}"
  target_resource_id             = azurerm_storage_account.this.id
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.analytics_destination_type

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[each.key].metrics
    content {
      category = metric.value
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_blob" {
  for_each = var.log_analytics_workspace

  name                           = "monitoring-${var.project}-${var.env}-${var.location}"
  target_resource_id             = "${azurerm_storage_account.this.id}/blobServices/default"
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.analytics_destination_type

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.monitoring_blob[each.key].log_category_types
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[each.key].metrics
    content {
      category = metric.value
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_tables" {
  for_each = var.log_analytics_workspace

  name                           = "monitoring-${var.project}-${var.env}-${var.location}"
  target_resource_id             = "${azurerm_storage_account.this.id}/tableServices/default"
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.analytics_destination_type

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.monitoring_tables[each.key].log_category_types
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[each.key].metrics
    content {
      category = metric.value
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_queue" {
  for_each = var.log_analytics_workspace

  name                           = "monitoring-test-${var.project}-${var.env}-${var.location}"
  target_resource_id             = "${azurerm_storage_account.this.id}/queueServices/default"
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.analytics_destination_type

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.monitoring_queue[each.key].log_category_types
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[each.key].metrics
    content {
      category = metric.value
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "monitoring_file" {
  for_each = { for k, v in var.log_analytics_workspace : k => v }

  name                           = "monitoring-${var.project}-${var.env}-${var.location}"
  target_resource_id             = "${azurerm_storage_account.this.id}/fileServices/default"
  log_analytics_workspace_id     = each.value
  log_analytics_destination_type = var.analytics_destination_type

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.monitoring_file[each.key].log_category_types
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[each.key].metrics
    content {
      category = metric.value
    }
  }
}
