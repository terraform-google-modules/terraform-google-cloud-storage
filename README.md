# Terraform Google Cloud Storage Module

This module makes it easy to create one or more GCS buckets, and assign basic permissions on them to arbitrary users.

The resources/services/activations/deletions that this module will create/trigger are:

- One or more GCS buckets
- Zero or more IAM bindings for those buckets

If you only wish to create a single bucket, consider using the
[simple bucket](modules/simple_bucket) submodule instead.

## Compatibility
This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+. If you find incompatibilities using Terraform >=0.13, please open an issue.
 If you haven't
[upgraded](https://www.terraform.io/upgrade-guides/0-13.html) and need a Terraform
0.12.x-compatible version of this module, the last released version
intended for Terraform 0.12.x is [v1.7.1](https://registry.terraform.io/modules/terraform-google-modules/-cloud-storage/google/v1.7.1).

## Usage

Basic usage of this module is as follows:

```hcl
module "gcs_buckets" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "~> 11.0"
  project_id  = "<PROJECT ID>"
  names = ["first", "second"]
  prefix = "my-unique-prefix"
  set_admin_roles = true
  admins = ["group:foo-admins@example.com"]
  versioning = {
    first = true
  }
  bucket_admins = {
    second = "user:spam@example.com,user:eggs@example.com"
  }
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admins | IAM-style members who will be granted roles/storage.objectAdmin on all buckets. | `list(string)` | `[]` | no |
| autoclass | Optional map of lowercase unprefixed bucket name => boolean, defaults to false. | `map(bool)` | `{}` | no |
| bucket\_admins | Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket admins. | `map(string)` | `{}` | no |
| bucket\_creators | Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket creators. | `map(string)` | `{}` | no |
| bucket\_hmac\_key\_admins | Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket HMAC Key admins. | `map(string)` | `{}` | no |
| bucket\_lifecycle\_rules | Additional lifecycle\_rules for specific buckets. Map of lowercase unprefixed name => list of lifecycle rules to configure. | <pre>map(set(object({<br>    # Object with keys:<br>    # - type - The type of the action of this Lifecycle Rule. Supported values: Delete and SetStorageClass.<br>    # - storage_class - (Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule.<br>    action = object({<br>      type          = string<br>      storage_class = optional(string)<br>    })<br><br>    # Object with keys:<br>    # - age - (Optional) Minimum age of an object in days to satisfy this condition.<br>    # - send_age_if_zero - (Optional) While set true, num_newer_versions value will be sent in the request even for zero value of the field.<br>    # - created_before - (Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.<br>    # - with_state - (Optional) Match to live and/or archived objects. Supported values include: "LIVE", "ARCHIVED", "ANY".<br>    # - matches_storage_class - (Optional) Storage Class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.<br>    # - matches_prefix - (Optional) One or more matching name prefixes to satisfy this condition.<br>    # - matches_suffix - (Optional) One or more matching name suffixes to satisfy this condition<br>    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.<br>    # - custom_time_before - (Optional) A date in the RFC 3339 format YYYY-MM-DD. This condition is satisfied when the customTime metadata for the object is set to an earlier date than the date used in this lifecycle condition.<br>    # - days_since_custom_time - (Optional) Days since the date set in the customTime metadata for the object.<br>    # - days_since_noncurrent_time - (Optional) Relevant only for versioned objects. Number of days elapsed since the noncurrent timestamp of an object.<br>    # - noncurrent_time_before - (Optional) Relevant only for versioned objects. The date in RFC 3339 (e.g. 2017-06-13) when the object became nonconcurrent.<br>    condition = object({<br>      age                        = optional(number)<br>      send_age_if_zero           = optional(bool)<br>      created_before             = optional(string)<br>      with_state                 = optional(string)<br>      matches_storage_class      = optional(string)<br>      matches_prefix             = optional(string)<br>      matches_suffix             = optional(string)<br>      num_newer_versions         = optional(number)<br>      custom_time_before         = optional(string)<br>      days_since_custom_time     = optional(number)<br>      days_since_noncurrent_time = optional(number)<br>      noncurrent_time_before     = optional(string)<br>    })<br>  })))</pre> | `{}` | no |
| bucket\_policy\_only | Disable ad-hoc ACLs on specified buckets. Defaults to true. Map of lowercase unprefixed name => boolean | `map(bool)` | `{}` | no |
| bucket\_storage\_admins | Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket storage admins. | `map(string)` | `{}` | no |
| bucket\_viewers | Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket viewers. | `map(string)` | `{}` | no |
| cors | Set of maps of mixed type attributes for CORS values. See appropriate attribute types here: https://www.terraform.io/docs/providers/google/r/storage_bucket.html#cors | <pre>list(object({<br>    origin          = optional(list(string))<br>    method          = optional(list(string))<br>    response_header = optional(list(string))<br>    max_age_seconds = optional(number)<br>  }))</pre> | `[]` | no |
| creators | IAM-style members who will be granted roles/storage.objectCreators on all buckets. | `list(string)` | `[]` | no |
| custom\_placement\_config | Map of lowercase unprefixed name => custom placement config object. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket#custom_placement_config | `any` | `{}` | no |
| default\_event\_based\_hold | Enable event based hold to new objects added to specific bucket. Defaults to false. Map of lowercase unprefixed name => boolean | `map(bool)` | `{}` | no |
| encryption\_key\_names | Optional map of lowercase unprefixed name => string, empty strings are ignored. | `map(string)` | `{}` | no |
| folders | Map of lowercase unprefixed name => list of top level folder objects. | `map(list(string))` | `{}` | no |
| force\_destroy | Optional map of lowercase unprefixed name => boolean, defaults to false. | `map(bool)` | `{}` | no |
| hierarchical\_namespace | Optional map of lowercase unprefixed bucket name => boolean, defaults to false. | `map(bool)` | `{}` | no |
| hmac\_key\_admins | IAM-style members who will be granted roles/storage.hmacKeyAdmin on all buckets. | `list(string)` | `[]` | no |
| hmac\_service\_accounts | List of HMAC service accounts to grant access to GCS. | `map(string)` | `{}` | no |
| ip\_filter | The IP filter configuration for a bucket. Map of lowercase unprefixed name => ip filter config object. See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket#ip_filter | <pre>map(object({<br>    mode = string<br>    public_network_source = optional(object({<br>      allowed_ip_cidr_ranges = list(string)<br>    }))<br>    vpc_network_sources = optional(list(object({<br>      network                = string<br>      allowed_ip_cidr_ranges = list(string)<br>    })))<br>  }))</pre> | `{}` | no |
| labels | Labels to be attached to the buckets | `map(string)` | `{}` | no |
| lifecycle\_rules | List of lifecycle rules to configure. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#lifecycle_rule except condition.matches\_storage\_class should be a comma delimited string. | <pre>set(object({<br>    # Object with keys:<br>    # - type - The type of the action of this Lifecycle Rule. Supported values: Delete and SetStorageClass.<br>    # - storage_class - (Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule.<br>    action = object({<br>      type          = string<br>      storage_class = optional(string)<br>    })<br><br>    # Object with keys:<br>    # - age - (Optional) Minimum age of an object in days to satisfy this condition.<br>    # - send_age_if_zero - (Optional) While set true, num_newer_versions value will be sent in the request even for zero value of the field.<br>    # - created_before - (Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.<br>    # - with_state - (Optional) Match to live and/or archived objects. Supported values include: "LIVE", "ARCHIVED", "ANY".<br>    # - matches_storage_class - (Optional) Comma delimited string for storage class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.<br>    # - matches_prefix - (Optional) One or more matching name prefixes to satisfy this condition.<br>    # - matches_suffix - (Optional) One or more matching name suffixes to satisfy this condition.<br>    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.<br>    # - custom_time_before - (Optional) A date in the RFC 3339 format YYYY-MM-DD. This condition is satisfied when the customTime metadata for the object is set to an earlier date than the date used in this lifecycle condition.<br>    # - days_since_custom_time - (Optional) The number of days from the Custom-Time metadata attribute after which this condition becomes true.<br>    # - days_since_noncurrent_time - (Optional) Relevant only for versioned objects. Number of days elapsed since the noncurrent timestamp of an object.<br>    # - noncurrent_time_before - (Optional) Relevant only for versioned objects. The date in RFC 3339 (e.g. 2017-06-13) when the object became nonconcurrent.<br>    condition = object({<br>      age                        = optional(number)<br>      send_age_if_zero           = optional(bool)<br>      created_before             = optional(string)<br>      with_state                 = optional(string)<br>      matches_storage_class      = optional(string)<br>      matches_prefix             = optional(string)<br>      matches_suffix             = optional(string)<br>      num_newer_versions         = optional(number)<br>      custom_time_before         = optional(string)<br>      days_since_custom_time     = optional(number)<br>      days_since_noncurrent_time = optional(number)<br>      noncurrent_time_before     = optional(string)<br>    })<br>  }))</pre> | `[]` | no |
| location | Bucket location. | `string` | `"EU"` | no |
| logging | Map of lowercase unprefixed name => bucket logging config object. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#logging | `any` | `{}` | no |
| names | Bucket name suffixes. | `list(string)` | n/a | yes |
| prefix | Prefix used to generate the bucket name. | `string` | `""` | no |
| project\_id | Bucket project id. | `string` | n/a | yes |
| public\_access\_prevention | Prevents public access to a bucket. Acceptable values are inherited or enforced. If inherited, the bucket uses public access prevention, only if the bucket is subject to the public access prevention organization policy constraint. | `string` | `"inherited"` | no |
| randomize\_suffix | Adds an identical, but randomized 4-character suffix to all bucket names | `bool` | `false` | no |
| retention\_policy | Map of retention policy values. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket#retention_policy | `any` | `{}` | no |
| set\_admin\_roles | Grant roles/storage.objectAdmin role to admins and bucket\_admins. | `bool` | `false` | no |
| set\_creator\_roles | Grant roles/storage.objectCreator role to creators and bucket\_creators. | `bool` | `false` | no |
| set\_hmac\_access | Set S3 compatible access to GCS. | `bool` | `false` | no |
| set\_hmac\_key\_admin\_roles | Grant roles/storage.hmacKeyAdmin role to hmac\_key\_admins and bucket\_hmac\_key\_admins. | `bool` | `false` | no |
| set\_storage\_admin\_roles | Grant roles/storage.admin role to storage\_admins and bucket\_storage\_admins. | `bool` | `false` | no |
| set\_viewer\_roles | Grant roles/storage.objectViewer role to viewers and bucket\_viewers. | `bool` | `false` | no |
| soft\_delete\_policy | Soft delete policies to apply. Map of lowercase unprefixed name => soft delete policy. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#nested_soft_delete_policy | `map(any)` | `{}` | no |
| storage\_admins | IAM-style members who will be granted roles/storage.admin on all buckets. | `list(string)` | `[]` | no |
| storage\_class | Bucket storage class. | `string` | `"STANDARD"` | no |
| versioning | Optional map of lowercase unprefixed name => boolean, defaults to false. | `map(bool)` | `{}` | no |
| viewers | IAM-style members who will be granted roles/storage.objectViewer on all buckets. | `list(string)` | `[]` | no |
| website | Map of website values. Supported attributes: main\_page\_suffix, not\_found\_page | <pre>object({<br>    main_page_suffix = optional(string)<br>    not_found_page   = optional(string)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| apphub\_service\_uri | URI in CAIS style to be used by Apphub. |
| bucket | Bucket resource (for single use). |
| buckets | Bucket resources as list. |
| buckets\_map | Bucket resources by name. |
| hmac\_keys | List of HMAC keys. |
| name | Bucket name (for single use). |
| names | Bucket names. |
| names\_list | List of bucket names. |
| url | Bucket URL (for single use). |
| urls | Bucket URLs. |
| urls\_list | List of bucket URLs. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform](https://www.terraform.io/downloads.html) >= 0.13.0
  - For Terraform v0.11 see the [Compatibility](#compatibility) section above
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

<!-- BEGIN_TF_DOCS -->
Copyright 2019 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.37.0, < 7 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.38.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.buckets](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.admins](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [google_storage_bucket_iam_binding.creators](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [google_storage_bucket_iam_binding.hmac_key_admins](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [google_storage_bucket_iam_binding.storage_admins](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [google_storage_bucket_iam_binding.viewers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [google_storage_bucket_object.folders](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_hmac_key.hmac_keys](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_hmac_key) | resource |
| [random_id.bucket_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admins"></a> [admins](#input\_admins) | IAM-style members who will be granted roles/storage.objectAdmin on all buckets. | `list(string)` | `[]` | no |
| <a name="input_autoclass"></a> [autoclass](#input\_autoclass) | Optional map of lowercase unprefixed bucket name => boolean, defaults to false. | `map(bool)` | `{}` | no |
| <a name="input_bucket_admins"></a> [bucket\_admins](#input\_bucket\_admins) | Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket admins. | `map(string)` | `{}` | no |
| <a name="input_bucket_creators"></a> [bucket\_creators](#input\_bucket\_creators) | Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket creators. | `map(string)` | `{}` | no |
| <a name="input_bucket_hmac_key_admins"></a> [bucket\_hmac\_key\_admins](#input\_bucket\_hmac\_key\_admins) | Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket HMAC Key admins. | `map(string)` | `{}` | no |
| <a name="input_bucket_lifecycle_rules"></a> [bucket\_lifecycle\_rules](#input\_bucket\_lifecycle\_rules) | Additional lifecycle\_rules for specific buckets. Map of lowercase unprefixed name => list of lifecycle rules to configure. | <pre>map(set(object({<br/>    # Object with keys:<br/>    # - type - The type of the action of this Lifecycle Rule. Supported values: Delete and SetStorageClass.<br/>    # - storage_class - (Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule.<br/>    action = object({<br/>      type          = string<br/>      storage_class = optional(string)<br/>    })<br/><br/>    # Object with keys:<br/>    # - age - (Optional) Minimum age of an object in days to satisfy this condition.<br/>    # - send_age_if_zero - (Optional) While set true, num_newer_versions value will be sent in the request even for zero value of the field.<br/>    # - created_before - (Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.<br/>    # - with_state - (Optional) Match to live and/or archived objects. Supported values include: "LIVE", "ARCHIVED", "ANY".<br/>    # - matches_storage_class - (Optional) Storage Class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.<br/>    # - matches_prefix - (Optional) One or more matching name prefixes to satisfy this condition.<br/>    # - matches_suffix - (Optional) One or more matching name suffixes to satisfy this condition<br/>    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.<br/>    # - custom_time_before - (Optional) A date in the RFC 3339 format YYYY-MM-DD. This condition is satisfied when the customTime metadata for the object is set to an earlier date than the date used in this lifecycle condition.<br/>    # - days_since_custom_time - (Optional) Days since the date set in the customTime metadata for the object.<br/>    # - days_since_noncurrent_time - (Optional) Relevant only for versioned objects. Number of days elapsed since the noncurrent timestamp of an object.<br/>    # - noncurrent_time_before - (Optional) Relevant only for versioned objects. The date in RFC 3339 (e.g. 2017-06-13) when the object became nonconcurrent.<br/>    condition = object({<br/>      age                        = optional(number)<br/>      send_age_if_zero           = optional(bool)<br/>      created_before             = optional(string)<br/>      with_state                 = optional(string)<br/>      matches_storage_class      = optional(string)<br/>      matches_prefix             = optional(string)<br/>      matches_suffix             = optional(string)<br/>      num_newer_versions         = optional(number)<br/>      custom_time_before         = optional(string)<br/>      days_since_custom_time     = optional(number)<br/>      days_since_noncurrent_time = optional(number)<br/>      noncurrent_time_before     = optional(string)<br/>    })<br/>  })))</pre> | `{}` | no |
| <a name="input_bucket_policy_only"></a> [bucket\_policy\_only](#input\_bucket\_policy\_only) | Disable ad-hoc ACLs on specified buckets. Defaults to true. Map of lowercase unprefixed name => boolean | `map(bool)` | `{}` | no |
| <a name="input_bucket_storage_admins"></a> [bucket\_storage\_admins](#input\_bucket\_storage\_admins) | Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket storage admins. | `map(string)` | `{}` | no |
| <a name="input_bucket_viewers"></a> [bucket\_viewers](#input\_bucket\_viewers) | Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket viewers. | `map(string)` | `{}` | no |
| <a name="input_cors"></a> [cors](#input\_cors) | Set of maps of mixed type attributes for CORS values. See appropriate attribute types here: https://www.terraform.io/docs/providers/google/r/storage_bucket.html#cors | <pre>list(object({<br/>    origin          = optional(list(string))<br/>    method          = optional(list(string))<br/>    response_header = optional(list(string))<br/>    max_age_seconds = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_creators"></a> [creators](#input\_creators) | IAM-style members who will be granted roles/storage.objectCreators on all buckets. | `list(string)` | `[]` | no |
| <a name="input_custom_placement_config"></a> [custom\_placement\_config](#input\_custom\_placement\_config) | Map of lowercase unprefixed name => custom placement config object. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket#custom_placement_config | `any` | `{}` | no |
| <a name="input_default_event_based_hold"></a> [default\_event\_based\_hold](#input\_default\_event\_based\_hold) | Enable event based hold to new objects added to specific bucket. Defaults to false. Map of lowercase unprefixed name => boolean | `map(bool)` | `{}` | no |
| <a name="input_encryption_key_names"></a> [encryption\_key\_names](#input\_encryption\_key\_names) | Optional map of lowercase unprefixed name => string, empty strings are ignored. | `map(string)` | `{}` | no |
| <a name="input_folders"></a> [folders](#input\_folders) | Map of lowercase unprefixed name => list of top level folder objects. | `map(list(string))` | `{}` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Optional map of lowercase unprefixed name => boolean, defaults to false. | `map(bool)` | `{}` | no |
| <a name="input_hierarchical_namespace"></a> [hierarchical\_namespace](#input\_hierarchical\_namespace) | Optional map of lowercase unprefixed bucket name => boolean, defaults to false. | `map(bool)` | `{}` | no |
| <a name="input_hmac_key_admins"></a> [hmac\_key\_admins](#input\_hmac\_key\_admins) | IAM-style members who will be granted roles/storage.hmacKeyAdmin on all buckets. | `list(string)` | `[]` | no |
| <a name="input_hmac_service_accounts"></a> [hmac\_service\_accounts](#input\_hmac\_service\_accounts) | List of HMAC service accounts to grant access to GCS. | `map(string)` | `{}` | no |
| <a name="input_ip_filter"></a> [ip\_filter](#input\_ip\_filter) | The IP filter configuration for a bucket. Map of lowercase unprefixed name => ip filter config object. See https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket#ip_filter | <pre>map(object({<br/>    mode = string<br/>    public_network_source = optional(object({<br/>      allowed_ip_cidr_ranges = list(string)<br/>    }))<br/>    vpc_network_sources = optional(list(object({<br/>      network                = string<br/>      allowed_ip_cidr_ranges = list(string)<br/>    })))<br/>  }))</pre> | `{}` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to be attached to the buckets | `map(string)` | `{}` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | List of lifecycle rules to configure. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#lifecycle_rule except condition.matches\_storage\_class should be a comma delimited string. | <pre>set(object({<br/>    # Object with keys:<br/>    # - type - The type of the action of this Lifecycle Rule. Supported values: Delete and SetStorageClass.<br/>    # - storage_class - (Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule.<br/>    action = object({<br/>      type          = string<br/>      storage_class = optional(string)<br/>    })<br/><br/>    # Object with keys:<br/>    # - age - (Optional) Minimum age of an object in days to satisfy this condition.<br/>    # - send_age_if_zero - (Optional) While set true, num_newer_versions value will be sent in the request even for zero value of the field.<br/>    # - created_before - (Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.<br/>    # - with_state - (Optional) Match to live and/or archived objects. Supported values include: "LIVE", "ARCHIVED", "ANY".<br/>    # - matches_storage_class - (Optional) Comma delimited string for storage class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.<br/>    # - matches_prefix - (Optional) One or more matching name prefixes to satisfy this condition.<br/>    # - matches_suffix - (Optional) One or more matching name suffixes to satisfy this condition.<br/>    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.<br/>    # - custom_time_before - (Optional) A date in the RFC 3339 format YYYY-MM-DD. This condition is satisfied when the customTime metadata for the object is set to an earlier date than the date used in this lifecycle condition.<br/>    # - days_since_custom_time - (Optional) The number of days from the Custom-Time metadata attribute after which this condition becomes true.<br/>    # - days_since_noncurrent_time - (Optional) Relevant only for versioned objects. Number of days elapsed since the noncurrent timestamp of an object.<br/>    # - noncurrent_time_before - (Optional) Relevant only for versioned objects. The date in RFC 3339 (e.g. 2017-06-13) when the object became nonconcurrent.<br/>    condition = object({<br/>      age                        = optional(number)<br/>      send_age_if_zero           = optional(bool)<br/>      created_before             = optional(string)<br/>      with_state                 = optional(string)<br/>      matches_storage_class      = optional(string)<br/>      matches_prefix             = optional(string)<br/>      matches_suffix             = optional(string)<br/>      num_newer_versions         = optional(number)<br/>      custom_time_before         = optional(string)<br/>      days_since_custom_time     = optional(number)<br/>      days_since_noncurrent_time = optional(number)<br/>      noncurrent_time_before     = optional(string)<br/>    })<br/>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Bucket location. | `string` | `"EU"` | no |
| <a name="input_logging"></a> [logging](#input\_logging) | Map of lowercase unprefixed name => bucket logging config object. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#logging | `any` | `{}` | no |
| <a name="input_names"></a> [names](#input\_names) | Bucket name suffixes. | `list(string)` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix used to generate the bucket name. | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Bucket project id. | `string` | n/a | yes |
| <a name="input_public_access_prevention"></a> [public\_access\_prevention](#input\_public\_access\_prevention) | Prevents public access to a bucket. Acceptable values are inherited or enforced. If inherited, the bucket uses public access prevention, only if the bucket is subject to the public access prevention organization policy constraint. | `string` | `"inherited"` | no |
| <a name="input_randomize_suffix"></a> [randomize\_suffix](#input\_randomize\_suffix) | Adds an identical, but randomized 4-character suffix to all bucket names | `bool` | `false` | no |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | Map of retention policy values. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket#retention_policy | `any` | `{}` | no |
| <a name="input_set_admin_roles"></a> [set\_admin\_roles](#input\_set\_admin\_roles) | Grant roles/storage.objectAdmin role to admins and bucket\_admins. | `bool` | `false` | no |
| <a name="input_set_creator_roles"></a> [set\_creator\_roles](#input\_set\_creator\_roles) | Grant roles/storage.objectCreator role to creators and bucket\_creators. | `bool` | `false` | no |
| <a name="input_set_hmac_access"></a> [set\_hmac\_access](#input\_set\_hmac\_access) | Set S3 compatible access to GCS. | `bool` | `false` | no |
| <a name="input_set_hmac_key_admin_roles"></a> [set\_hmac\_key\_admin\_roles](#input\_set\_hmac\_key\_admin\_roles) | Grant roles/storage.hmacKeyAdmin role to hmac\_key\_admins and bucket\_hmac\_key\_admins. | `bool` | `false` | no |
| <a name="input_set_storage_admin_roles"></a> [set\_storage\_admin\_roles](#input\_set\_storage\_admin\_roles) | Grant roles/storage.admin role to storage\_admins and bucket\_storage\_admins. | `bool` | `false` | no |
| <a name="input_set_viewer_roles"></a> [set\_viewer\_roles](#input\_set\_viewer\_roles) | Grant roles/storage.objectViewer role to viewers and bucket\_viewers. | `bool` | `false` | no |
| <a name="input_soft_delete_policy"></a> [soft\_delete\_policy](#input\_soft\_delete\_policy) | Soft delete policies to apply. Map of lowercase unprefixed name => soft delete policy. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#nested_soft_delete_policy | `map(any)` | `{}` | no |
| <a name="input_storage_admins"></a> [storage\_admins](#input\_storage\_admins) | IAM-style members who will be granted roles/storage.admin on all buckets. | `list(string)` | `[]` | no |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | Bucket storage class. | `string` | `"STANDARD"` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Optional map of lowercase unprefixed name => boolean, defaults to false. | `map(bool)` | `{}` | no |
| <a name="input_viewers"></a> [viewers](#input\_viewers) | IAM-style members who will be granted roles/storage.objectViewer on all buckets. | `list(string)` | `[]` | no |
| <a name="input_website"></a> [website](#input\_website) | Map of website values. Supported attributes: main\_page\_suffix, not\_found\_page | <pre>object({<br/>    main_page_suffix = optional(string)<br/>    not_found_page   = optional(string)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apphub_service_uri"></a> [apphub\_service\_uri](#output\_apphub\_service\_uri) | URI in CAIS style to be used by Apphub. |
| <a name="output_bucket"></a> [bucket](#output\_bucket) | Bucket resource (for single use). |
| <a name="output_buckets"></a> [buckets](#output\_buckets) | Bucket resources as list. |
| <a name="output_buckets_map"></a> [buckets\_map](#output\_buckets\_map) | Bucket resources by name. |
| <a name="output_hmac_keys"></a> [hmac\_keys](#output\_hmac\_keys) | List of HMAC keys. |
| <a name="output_name"></a> [name](#output\_name) | Bucket name (for single use). |
| <a name="output_names"></a> [names](#output\_names) | Bucket names. |
| <a name="output_names_list"></a> [names\_list](#output\_names\_list) | List of bucket names. |
| <a name="output_url"></a> [url](#output\_url) | Bucket URL (for single use). |
| <a name="output_urls"></a> [urls](#output\_urls) | Bucket URLs. |
| <a name="output_urls_list"></a> [urls\_list](#output\_urls\_list) | List of bucket URLs. |
<!-- END_TF_DOCS -->