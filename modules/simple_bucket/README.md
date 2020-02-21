# Terraform Google Cloud Storage Module

This module makes it easy to create a GCS bucket, and assign basic permissions on it to arbitrary users.

The resources/services/activations/deletions that this module will create/trigger are:

- One GCS bucket
- Zero or more IAM bindings for that bucket

## Compatibility

This module is meant for use with Terraform 0.12.

## Usage

Basic usage of this module is as follows:

```hcl
module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 1.3"

  name       = "example-bucket"
  project_id = "example-project"
  location   = "us-east1"
  iam_members = [{
    role   = "roles/storage.viewer"
    member = "user:example-user@example.com"
  }]
}
```

Functional examples are included in the
[examples](../../examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bucket\_policy\_only | Enables Bucket Policy Only access to a bucket. | bool | `"true"` | no |
| encryption | A Cloud KMS key that will be used to encrypt objects inserted into this bucket | object | `"null"` | no |
| force\_destroy | When deleting a bucket, this boolean option will delete all contained objects. If false, Terraform will fail to delete buckets which contain objects. | bool | `"false"` | no |
| iam\_members | The list of IAM members to grant permissions on the bucket. | object | `<list>` | no |
| labels | A set of key/value label pairs to assign to the bucket. | map(string) | `"null"` | no |
| location | The location of the bucket. | string | n/a | yes |
| name | The name of the bucket. | string | n/a | yes |
| project\_id | The ID of the project to create the bucket in. | string | n/a | yes |
| retention\_policy | Configuration of the bucket's data retention policy for how long objects in the bucket should be retained. | object | `"null"` | no |
| storage\_class | The Storage Class of the new bucket. | string | `"null"` | no |
| versioning | While set to true, versioning is fully enabled for this bucket. | bool | `"true"` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.12
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.0

### Service Account

User or service account credentials with the following roles must be used to provision the resources of this module:

- Storage Admin: `roles/storage.admin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Storage JSON API: `storage-api.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
