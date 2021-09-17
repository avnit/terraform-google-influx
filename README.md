## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 2.7.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 2.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_external_firewall"></a> [external\_firewall](#module\_external\_firewall) | ./modules/external-firewall | n/a |
| <a name="module_service_account"></a> [service\_account](#module\_service\_account) | ./modules/tick-service-account | n/a |
| <a name="module_tick_oss"></a> [tick\_oss](#module\_tick\_oss) | ./modules/tick-instance-group | n/a |

## Resources

| Name | Type |
|------|------|
| [template_file.startup_script](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image"></a> [image](#input\_image) | The source image used to create the boot disk for an InfluxDB node. | `string` | n/a | yes |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | The machine type of the Compute Instance to run for each node in the cluster (e.g. n1-standard-1). | `string` | `"n1-standard-1"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the cluster (e.g. tick-oss-example). This variable is used to namespace all resources created by this module. It will also be used to name the instance group. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | ID of the GCP Project where all resources will be launched. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | All resources will be launched in this region. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tick_oss_instance_group"></a> [tick\_oss\_instance\_group](#output\_tick\_oss\_instance\_group) | Self link to the InfluxDB instance group |
| <a name="output_tick_oss_instance_group_manager"></a> [tick\_oss\_instance\_group\_manager](#output\_tick\_oss\_instance\_group\_manager) | Self link of the InfluxDB instance group manager |
