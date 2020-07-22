# Simple Example

This example illustrates how to use the `cloud-storage` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bucket\_readers | Map of lowercase unprefixed name => comma-delimited IAM-style bucket legacy readers. | map | `<map>` | no |
| cors | Map of maps of mixed type attributes for CORS values. See appropriate attribute types here: https://www.terraform.io/docs/providers/google/r/storage_bucket.html#cors | any | `<map>` | no |
| names | Bucket name suffixes. | list(string) | n/a | yes |
| names\_list | Names of the buckets to create. | list(string) | `<list>` | no |
| prefix | Prefix used to generate bucket names. | string | `""` | no |
| project\_id | The ID of the project in which to provision resources. | string | n/a | yes |
| set\_reader\_roles | Grant roles/storage.legacyObjectReader role to readers and bucket_readers. | bool | `"false"` | no |
| website | Map of website values. Supported attributes: main_page_suffix, not_found_page | any | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| names | Bucket names. |
| names\_list | List of bucket names. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
