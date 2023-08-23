variable "project" {
  type        = string
  description = "Project name"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "resource_group" {
  type        = string
  description = "The name of the resource group in which to create the storage account"
}

variable "location" {
  type        = string
  description = "Azure location"
}

variable "custom_storage_account_name" {
  type        = string
  description = "Specifies the name of the storage account"
  default     = null
}

variable "custom_diagnostics_name" {
  type        = string
  description = "Custom name for Diagnostic Settings that monitors Storage Account sub-resources"
  default     = null
}

variable "prefix" {
  type        = string
  description = "Resource name prefix"
  default     = ""
}

variable "suffix" {
  type        = string
  description = "Resource name suffix"
  default     = ""
}

variable "account_kind" {
  type        = string
  description = "Kind of account. [BlobStorage|BlockBlobStorage|FileStorage|Storage|StorageV2]"
  default     = "StorageV2"
}

variable "account_tier" {
  type        = string
  description = "Tier to use for this storage account: [Standard|Premium]"
  default     = "Standard"
}

variable "replication_type" {
  type        = string
  description = "The type of replication to use: [LRS|GRS|RAGRS|ZRS|GZRS|RAGZRS]"
  default     = "GRS"
}

variable "access_tier" {
  type        = string
  description = "The access tier for BlobStorage, FileStorage and StorageV2"
  default     = "Hot"
}

variable "enable_https_traffic_only" {
  type        = bool
  description = "Boolean flag which forces HTTPS if enabled: [true|false]"
  default     = true
}

variable "min_tls_version" {
  type        = string
  description = "The minimum supported TLS version for the storage account: [TLS1_0|TLS1_1|TLS1_2]"
  default     = "TLS1_2"
}

variable "is_hns_enabled" {
  type        = bool
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2: [true|false]"
  default     = true
}

variable "allow_nested_items_to_be_public" {
  type        = bool
  description = "Allow or disallow nested items within this Account to opt into being public."
  default     = true
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "default_action" {
  type        = string
  description = "Specifies the default action of allow or deny when no other rules match"
  default     = "Deny"
}

variable "bypass" {
  type        = set(string)
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
  default     = ["AzureServices"]
}

variable "ip_rules" {
  type        = map(string)
  description = "Map of IP addresses permitted to access storage account"
  default     = null
}

variable "virtual_networks" {
  type        = list(string)
  description = "A list of resource ids for subnets"
  default     = null
}

variable "permissions" {
  type = list(object({
    name      = string
    object_id = string
    role      = string
  }))
  description = "Set of objects, where you can assign role to certain principal and name this assignment."
  default     = []
}

variable "log_analytics_workspace" {
  type        = map(string)
  description = "Log Analytics Workspace Name to ID map"
  default     = {}
}

variable "log_category_list" {
  type        = list(string)
  description = "Log category list"
  default = [
    "StorageRead",
    "StorageWrite",
    "StorageDelete"
  ]
}

variable "destination_type" {
  type        = string
  description = "Log analytics destination type"
  default     = "Dedicated"
}

variable "blob_cors_rules" {
  type = list(object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))
  default     = []
  description = "List of Blob CORS rules"
}

variable "key_vault_managed_storage_keys_enabled" {
  type        = bool
  description = "Boolean flag that determines whether Storage Account Access Keys are automatically managed and rotated by Key Vault"
  default     = false
}

variable "key_vault_id" {
  type        = string
  description = "The ID of the Key Vault"
  default     = null
}

variable "key_vault_global_object_id" {
  type        = string
  description = "Azure Key Vault Global Object ID value"
  default     = "12b3bdbf-e278-42d6-87af-4867477e2571"
}

variable "regenerate_key_automatically" {
  type        = bool
  description = "Storage Account access key regenerated periodically switch"
  default     = true
}

variable "regeneration_period" {
  type        = string
  description = "Storage Account access key regeneration frequency period"
  default     = "P85D"
}
