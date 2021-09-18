## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 2.7.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 2.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 2.7.0 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_base_gcr"></a> [base\_gcr](#module\_base\_gcr) | terraform-google-modules/cloud-dns/google | ~> 3.1 |
| <a name="module_base_pkg_dev"></a> [base\_pkg\_dev](#module\_base\_pkg\_dev) | terraform-google-modules/cloud-dns/google | ~> 3.1 |
| <a name="module_external_firewall"></a> [external\_firewall](#module\_external\_firewall) | ./modules/external-firewall | n/a |
| <a name="module_peering_zone"></a> [peering\_zone](#module\_peering\_zone) | terraform-google-modules/cloud-dns/google | ~> 3.1 |
| <a name="module_private_googleapis"></a> [private\_googleapis](#module\_private\_googleapis) | terraform-google-modules/cloud-dns/google | ~> 3.1 |
| <a name="module_service_account"></a> [service\_account](#module\_service\_account) | ./modules/tick-service-account | n/a |
| <a name="module_tick_oss"></a> [tick\_oss](#module\_tick\_oss) | ./modules/tick-instance-group | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.allow_all_egress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_all_ingress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_iap_rdp](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_iap_ssh](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_lb](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_private_api_egress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_windows_activation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.deny_all_egress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_dns_policy.default_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_policy) | resource |
| [google_active_folder.common](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/active_folder) | data source |
| [google_compute_network.automate_vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |
| [google_compute_network.vpc_dns_hub](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |
| [google_projects.dns_hub](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/projects) | data source |
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
