output "id" {
  value       = azurerm_storage_account.this.id
  description = "Storage account ID"
}

output "name" {
  value       = azurerm_storage_account.this.name
  description = "Storage account name"
}

output "primary_dfs_endpoint" {
  value       = azurerm_storage_account.this.primary_dfs_endpoint
  description = "The endpoint URL for DFS storage in the primary location"
}

output "primary_blob_endpoint" {
  value       = azurerm_storage_account.this.primary_blob_endpoint
  description = "The endpoint URL for DFS storage in the primary location"
}

output "primary_key" {
  value       = azurerm_storage_account.this.primary_access_key
  description = "Access key for Blob Storage"
}

output "sas_url_query_string" {
  value = data.azurerm_storage_account_sas.this.sas
  description = "The computed Account Shared Access Signature (SAS)"
}
