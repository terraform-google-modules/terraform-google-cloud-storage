# Terraform Google Cloud Storage Module

This module makes it easy to create a GCS bucket, and assign basic permissions on it to arbitrary users.

The resources/services/activations/deletions that this module will create/trigger are:

- One GCS bucket
- Zero or more IAM bindings for that bucket

## Compatibility

This module is meant for use with Terraform 0.13+.

## Usage

Basic usage of this module is as follows:

```hcl
module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 10.0"

  name       = "example-bucket"
  project_id = "example-project"
  location   = "us-east1"
  iam_members = [{
    role   = "roles/storage.objectViewer"
    member = "user:example-user@example.com"
  }]
}
```

Functional examples are included in the
[examples](../../examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autoclass | While set to true, autoclass is enabled for this bucket. | `bool` | `false` | no |
| bucket\_policy\_only | Enables Bucket Policy Only access to a bucket. | `bool` | `true` | no |
| cors | Configuration of CORS for bucket with structure as defined in https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket#cors. | <pre>list(object({<br>    origin          = optional(list(string))<br>    method          = optional(list(string))<br>    response_header = optional(list(string))<br>    max_age_seconds = optional(number)<br>  }))</pre> | `[]` | no |
| custom\_placement\_config | Configuration of the bucket's custom location in a dual-region bucket setup. If the bucket is designated a single or multi-region, the variable are null. | <pre>object({<br>    data_locations = list(string)<br>  })</pre> | `null` | no |
| encryption | A Cloud KMS key that will be used to encrypt objects inserted into this bucket. The key name should follow the format of `projects/<project-name>/locations/<location-name>/keyRings/<keyring-name>/cryptoKeys/<key-name>`. To use a Cloud KMS key automatically created by this module use the `internal_encryption_config` input variable. | <pre>object({<br>    default_kms_key_name = string<br>  })</pre> | `null` | no |
| force\_destroy | When deleting a bucket, this boolean option will delete all contained objects. If false, Terraform will fail to delete buckets which contain objects. | `bool` | `false` | no |
| iam\_members | The list of IAM members to grant permissions on the bucket. | <pre>list(object({<br>    role   = string<br>    member = string<br>  }))</pre> | `[]` | no |
| internal\_encryption\_config | Configuration for the creation of an internal Google Cloud Key Management Service (KMS) Key for use as Customer-managed encryption key (CMEK) for the GCS Bucket<br>  instead of creating one in advance and providing the key in the variable `encryption.default_kms_key_name`.<br>  create\_encryption\_key: If `true` a Google Cloud Key Management Service (KMS) KeyRing and a Key will be created<br>  prevent\_destroy: Set the prevent\_destroy lifecycle attribute on keys.<br>  key\_destroy\_scheduled\_duration: Set the period of time that versions of keys spend in the `DESTROY_SCHEDULED` state before transitioning to `DESTROYED`.<br>  key\_rotation\_period: Generate a new key every time this period passes. | <pre>object({<br>    create_encryption_key          = optional(bool, false)<br>    prevent_destroy                = optional(bool, false)<br>    key_destroy_scheduled_duration = optional(string, null)<br>    key_rotation_period            = optional(string, "7776000s")<br>  })</pre> | `{}` | no |
| labels | A set of key/value label pairs to assign to the bucket. | `map(string)` | `null` | no |
| lifecycle\_rules | The bucket's Lifecycle Rules configuration. | <pre>list(object({<br>    # Object with keys:<br>    # - type - The type of the action of this Lifecycle Rule. Supported values: Delete and SetStorageClass.<br>    # - storage_class - (Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule.<br>    action = object({<br>      type          = string<br>      storage_class = optional(string)<br>    })<br><br>    # Object with keys:<br>    # - age - (Optional) Minimum age of an object in days to satisfy this condition.<br>    # - send_age_if_zero - (Optional) While set true, num_newer_versions value will be sent in the request even for zero value of the field.<br>    # - created_before - (Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.<br>    # - with_state - (Optional) Match to live and/or archived objects. Supported values include: "LIVE", "ARCHIVED", "ANY".<br>    # - matches_storage_class - (Optional) Storage Class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.<br>    # - matches_prefix - (Optional) One or more matching name prefixes to satisfy this condition.<br>    # - matches_suffix - (Optional) One or more matching name suffixes to satisfy this condition<br>    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.<br>    # - custom_time_before - (Optional) A date in the RFC 3339 format YYYY-MM-DD. This condition is satisfied when the customTime metadata for the object is set to an earlier date than the date used in this lifecycle condition.<br>    # - days_since_custom_time - (Optional) Days since the date set in the customTime metadata for the object.<br>    # - days_since_noncurrent_time - (Optional) Relevant only for versioned objects. Number of days elapsed since the noncurrent timestamp of an object.<br>    # - noncurrent_time_before - (Optional) Relevant only for versioned objects. The date in RFC 3339 (e.g. 2017-06-13) when the object became nonconcurrent.<br>    condition = object({<br>      age                        = optional(number)<br>      send_age_if_zero           = optional(bool)<br>      created_before             = optional(string)<br>      with_state                 = optional(string)<br>      matches_storage_class      = optional(string)<br>      matches_prefix             = optional(string)<br>      matches_suffix             = optional(string)<br>      num_newer_versions         = optional(number)<br>      custom_time_before         = optional(string)<br>      days_since_custom_time     = optional(number)<br>      days_since_noncurrent_time = optional(number)<br>      noncurrent_time_before     = optional(string)<br>    })<br>  }))</pre> | `[]` | no |
| location | The location of the bucket. See https://cloud.google.com/storage/docs/locations. | `string` | n/a | yes |
| log\_bucket | The bucket that will receive log objects. | `string` | `null` | no |
| log\_object\_prefix | The object prefix for log objects. If it's not provided, by default GCS sets this to this bucket's name | `string` | `null` | no |
| name | The name of the bucket. | `string` | n/a | yes |
| project\_id | The ID of the project to create the bucket in. | `string` | n/a | yes |
| public\_access\_prevention | Prevents public access to a bucket. Acceptable values are inherited or enforced. If inherited, the bucket uses public access prevention, only if the bucket is subject to the public access prevention organization policy constraint. | `string` | `"inherited"` | no |
| retention\_policy | Configuration of the bucket's data retention policy for how long objects in the bucket should be retained. | <pre>object({<br>    is_locked        = bool<br>    retention_period = number<br>  })</pre> | `null` | no |
| soft\_delete\_policy | Soft delete policies to apply. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#nested_soft_delete_policy | <pre>object({<br>    retention_duration_seconds = optional(number)<br>  })</pre> | `{}` | no |
| storage\_class | The Storage Class of the new bucket. | `string` | `null` | no |
| versioning | While set to true, versioning is fully enabled for this bucket. | `bool` | `true` | no |
| website | Map of website values. Supported attributes: main\_page\_suffix, not\_found\_page | <pre>object({<br>    main_page_suffix = optional(string)<br>    not_found_page   = optional(string)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| apphub\_service\_uri | URI in CAIS style to be used by Apphub. |
| bucket | The created storage bucket |
| internal\_kms\_configuration | The intenal KMS Resource. |
| name | Bucket name. |
| url | Bucket URL. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] >= 0.13.0
- [Terraform Provider for GCP][terraform-provider-gcp] plugin >= v4.42

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
