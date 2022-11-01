# Azure Storage Account Terraform module
Terraform module for creation Azure Storage Account

## Usage

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.23.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.24.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | The access tier for BlobStorage, FileStorage and StorageV2 | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Kind of account. [BlobStorage\|BlockBlobStorage\|FileStorage\|Storage\|StorageV2] | `string` | `"StorageV2"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Tier to use for this storage account: [Standard\|Premium] | `string` | `"Standard"` | no |
| <a name="input_bypass"></a> [bypass](#input\_bypass) | Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None. | `set(string)` | <pre>[<br>  "AzureServices"<br>]</pre> | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | Specifies the default action of allow or deny when no other rules match | `string` | `"Deny"` | no |
| <a name="input_enable_https_traffic_only"></a> [enable\_https\_traffic\_only](#input\_enable\_https\_traffic\_only) | Boolean flag which forces HTTPS if enabled: [true\|false] | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment name | `string` | n/a | yes |
| <a name="input_ip_rules"></a> [ip\_rules](#input\_ip\_rules) | Map of IP addresses permitted to access storage account | `map(string)` | `null` | no |
| <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled) | Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2: [true\|false] | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | n/a | yes |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | The minimum supported TLS version for the storage account: [TLS1\_0\|TLS1\_1\|TLS1\_2] | `string` | `"TLS1_2"` | no |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | Storage permision map | `list(map(string))` | <pre>[<br>  {<br>    "object_id": null,<br>    "role": null<br>  }<br>]</pre> | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Resource name prefix | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | n/a | yes |
| <a name="input_replication_type"></a> [replication\_type](#input\_replication\_type) | The type of replication to use: [LRS\|GRS\|RAGRS\|ZRS\|GZRS\|RAGZRS] | `string` | `"GRS"` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name of the resource group in which to create the storage account | `string` | n/a | yes |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Resource name suffix | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(any)` | `{}` | no |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | A list of resource ids for subnets | `list(string)` | `null` | no |
| <a name="input_log_analytics_workspace"></a> [tags](#input\_log\_analytics\_workspace) | Log Analytics Workspace Name to ID map | `map(string)` | `{}` | no |
| <a name="input_log_category_list"></a> [tags](#input\_log\_category_list) | Log category list | `list(string)` | ` <pre>[<br> object_id = null <br> role = null <br>]</pre>` | no |
| <a name="input_log_retention_days"></a> [tags](#input\_log\_retention\_days) | Retention log policy days | `number` | `0` | no |
| <a name="input_metric_retention_days"></a> [tags](#input\_metric\_retention\_days) | Metric policy days | `number` | `0` | no |
| <a name="input_destination_type"></a> [tags](#input\_destination_type) | Log analytics destination type | `string` | `Dedicated` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Storage account ID |
| <a name="output_name"></a> [name](#output\_name) | Storage account name |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | The endpoint URL for DFS storage in the primary location |
| <a name="output_primary_dfs_endpoint"></a> [primary\_dfs\_endpoint](#output\_primary\_dfs\_endpoint) | The endpoint URL for DFS storage in the primary location |
| <a name="output_primary_key"></a> [primary\_key](#output\_primary\_key) | Access key for Blob Storage |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-storage-account/tree/main/LICENSE)
