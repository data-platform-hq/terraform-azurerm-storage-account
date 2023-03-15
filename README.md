# Azure Storage Account Terraform module
Terraform module for creation Azure Storage Account

## Usage
This module provides an ability to deploy Azure Storage Account and configuring access to it.
Note that if you destroy the resources and try to deploy the same instance (with the same name), it can only be done after 6 hours. Otherwise, change the value for custom_storage_account_name (if you're using one) or add/change values for the prefix/suffix variables.
```hcl
data "azurerm_virtual_network" "example" {
  name                = "example-law"
  resource_group_name = "example-rg"
  location            = "eastus"
}

module "storage_account" {
  source  = "data-platform-hq/storage-account/azurerm"

  project                         = "datahq"
  env                             = "example"
  location                        = "eastus"
  resource_group                  = "example_rg"
  ip_rules                        = {
    "example-vpn-eu"              = "172.16.14.128/29"
    "example-vpn-us"              = "172.16.119.208/28"
    "example-vpn-ua"              = "172.16.141.72/29"
  }
  virtual_networks                = [data.azurerm_virtual_network.example.id]
  allow_nested_items_to_be_public = false
  custom_storage_account_name     = "examplesaccname"
  custom_diagnostics_name         = "examplesacomponentsname"
}
```


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version   |
| ------------------------------------------------------------------------- | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.40.0 |

## Providers

| Name                                                          | Version   |
| ------------------------------------------------------------- | --------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.40.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                             | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment)                  | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)                  | resource |
| [monitor_diagnostic_setting.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [monitor_diagnostic_setting.blob](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)    | resource |
| [monitor_diagnostic_setting.table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)   | resource |
| [monitor_diagnostic_setting.queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)   | resource |
| [monitor_diagnostic_setting.file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)    | resource |

## Inputs

| Name                                                                                                                                      | Description                                                                                                                                                                                                                                                         | Type                | Default                                                                             | Required |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- | ----------------------------------------------------------------------------------- | :------: |
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier)                                                                     | The access tier for BlobStorage, FileStorage and StorageV2                                                                                                                                                                                                          | `string`            | `"Hot"`                                                                             |    no    |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind)                                                                  | Kind of account. [BlobStorage\BlockBlobStorage\FileStorage\Storage\ StorageV2]                                                                                                                                                                                      | `string`            | `"StorageV2"`                                                                       |    no    |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier)                                                                  | Tier to use for this storage account: [Standard\Premium]                                                                                                                                                                                                            | `string`            | `"Standard"`                                                                        |    no    |
| <a name="input_bypass"></a> [bypass](#input\_bypass)                                                                                      | Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.                                                                                                             | `set(string)`       | <pre>[<br>  "AzureServices"<br>]</pre>                                              |    no    |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action)                                                            | Specifies the default action of allow or deny when no other rules match                                                                                                                                                                                             | `string`            | `"Deny"`                                                                            |    no    |
| <a name="input_enable_https_traffic_only"></a> [enable\_https\_traffic\_only](#input\_enable\_https\_traffic\_only)                       | Boolean flag which forces HTTPS if enabled: [true\false]                                                                                                                                                                                                            | `bool`              | `true`                                                                              |    no    |
| <a name="input_env"></a> [env](#input\_env)                                                                                               | Environment name                                                                                                                                                                                                                                                    | `string`            | n/a                                                                                 |   yes    |
| <a name="input_ip_rules"></a> [ip\_rules](#input\_ip\_rules)                                                                              | Map of IP addresses permitted to access storage account                                                                                                                                                                                                             | `map(string)`       | `null`                                                                              |    no    |
| <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled)                                                          | Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2: [true\false]                                                                                                                                                                | `bool`              | `true`                                                                              |    no    |
| <a name="input_location"></a> [location](#input\_location)                                                                                | Azure location                                                                                                                                                                                                                                                      | `string`            | n/a                                                                                 |   yes    |
| <a name="input_custom_storage_account_name"></a> [custom\_storage\_account\_name](#input\_custom\_storage\_account\_name)                 | Specifies the name of the storage account. The maximum permissible length of the name is 24 characters, including the prefix and suffix. If the total length of the name exceeds the permissible length, the name will be automatically shortened to 24 characters. | `string`            | `null`                                                                              |    no    |
| <a name="input_custom_diagnostics_name"></a> [custom\_diagnostics\_name](#input\_custom\_diagnostics\_name)                               | Custom name for Diagnostic Settings that monitors Storage Account sub-resources                                                                                                                                                                                     | `string`            | `null`                                                                              |    no    |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version)                                                       | The minimum supported TLS version for the storage account: [TLS1\_0\ TLS1\_1\ TLS1\_2]                                                                                                                                                                              | `string`            | `"TLS1_2"`                                                                          |    no    |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | Allow or disallow nested items within this Account to opt into being public.                                                                                                                                                                                        | `bool`              | `true`                                                                              |    no    |
| <a name="input_permissions"></a> [permissions](#input\_permissions)                                                                       | Storage permision map                                                                                                                                                                                                                                               | `list(map(string))` | <pre>[<br>  {<br>    "object_id": null,<br>    "role": null<br>  }<br>]</pre>       |    no    |
| <a name="input_prefix"></a> [prefix](#input\_prefix)                                                                                      | Resource name prefix                                                                                                                                                                                                                                                | `string`            | `""`                                                                                |    no    |
| <a name="input_project"></a> [project](#input\_project)                                                                                   | Project name                                                                                                                                                                                                                                                        | `string`            | n/a                                                                                 |   yes    |
| <a name="input_replication_type"></a> [replication\_type](#input\_replication\_type)                                                      | The type of replication to use: [LRS\GRS\RAGRS\ZRS\GZRS\RAGZRS]                                                                                                                                                                                                     | `string`            | `"GRS"`                                                                             |    no    |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group)                                                            | The name of the resource group in which to create the storage account                                                                                                                                                                                               | `string`            | n/a                                                                                 |   yes    |
| <a name="input_suffix"></a> [suffix](#input\_suffix)                                                                                      | Resource name suffix                                                                                                                                                                                                                                                | `string`            | `""`                                                                                |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                            | A mapping of tags to assign to the resource                                                                                                                                                                                                                         | `map(any)`          | `{}`                                                                                |    no    |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks)                                                      | A list of resource ids for subnets                                                                                                                                                                                                                                  | `list(string)`      | `null`                                                                              |    no    |
| <a name="input_log_analytics_workspace"></a> [log_analytics\_workspace](#input\_log\_analytics\_workspace)                                | Log Analytics Workspace Name to ID map                                                                                                                                                                                                                              | `map(string)`       | `{}`                                                                                |    no    |
| <a name="input_log_category_list"></a> [log\_category\_list](#input\_log\_category_list)                                                  | Log category list                                                                                                                                                                                                                                                   | `list(string)`      | <pre> [ <br> "StorageRead", <br> "StorageWrite", <br> "StorageDelete" <br> ] </pre> |    no    |
| <a name="input_destination_type"></a> [destination\_type](#input\_destination\_type)                                                      | Log analytics destination type                                                                                                                                                                                                                                      | `string`            | `Dedicated`                                                                         |    no    |
| <a name="input_blob_cors_rules"></a> [blob\_cors\_rules](#input\_blob\_cors\_rules)                                                       | List of Blob CORS rules                                                                                                                                                                                                                                             | `list(object({}))`  | `[]`                                                                                |    no    |


## Outputs

| Name                                                                                                    | Description                                              |
| ------------------------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| <a name="output_id"></a> [id](#output\_id)                                                              | Storage account ID                                       |
| <a name="output_name"></a> [name](#output\_name)                                                        | Storage account name                                     |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | The endpoint URL for DFS storage in the primary location |
| <a name="output_primary_dfs_endpoint"></a> [primary\_dfs\_endpoint](#output\_primary\_dfs\_endpoint)    | The endpoint URL for DFS storage in the primary location |
| <a name="output_primary_key"></a> [primary\_key](#output\_primary\_key)                                 | Access key for Blob Storage                              |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-storage-account/tree/main/LICENSE)
