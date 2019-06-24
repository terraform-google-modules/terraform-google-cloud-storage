# Simple Example

This example illustrates how to use the `cloud-storage` module.

[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bucket\_policy\_only | Disable ad-hoc ACLs on specified buckets. Defaults to true. Map of lowercase unprefixed name => boolean | map | n/a | yes |
| names | Names of the buckets to create. | list | n/a | yes |
| prefix | Prefix used to generate bueckt names. | string | n/a | yes |
| project\_id | The ID of the project in which to provision resources. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| names | Names of the buckets created. |

[^]: (autogen_docs_end)

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
