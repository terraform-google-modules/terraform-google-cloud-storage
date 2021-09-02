# Simple Example

This example illustrates how to use the `cloud-storage` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_policy\_only | Disable ad-hoc ACLs on specified buckets. Defaults to true. Map of lowercase unprefixed name => boolean | `map(string)` | `{}` | no |
| folders | Top level bucket folders. Map of lowercase unprefixed name => list of folders to create. | `map(any)` | `{}` | no |
| names | Names of the buckets to create. | `list(string)` | <pre>[<br>  "one",<br>  "two"<br>]</pre> | no |
| project\_id | The ID of the project in which to provision resources. | `string` | n/a | yes |

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
