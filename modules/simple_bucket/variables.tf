/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  description = "The ID of the project to create the bucket in."
  type        = string
}

variable "location" {
  description = "The location of the bucket. See https://cloud.google.com/storage/docs/locations."
  type        = string
}

variable "name" {
  description = "The name of the bucket."
  type        = string
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects. If false, Terraform will fail to delete buckets which contain objects."
  type        = bool
  default     = false
}

variable "iam_members" {
  description = "The list of IAM members to grant permissions on the bucket."
  type = list(object({
    role   = string
    member = string
  }))
  default = []
}

variable "storage_class" {
  description = "The Storage Class of the new bucket."
  type        = string
  default     = null
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the bucket."
  type        = map(string)
  default     = null
}


variable "bucket_policy_only" {
  description = "Enables Bucket Policy Only access to a bucket."
  type        = bool
  default     = true
}

variable "versioning" {
  description = "While set to true, versioning is fully enabled for this bucket."
  type        = bool
  default     = true
}

variable "autoclass" {
  description = "While set to true, autoclass is enabled for this bucket."
  type        = bool
  default     = false
}

variable "retention_policy" {
  description = "Configuration of the bucket's data retention policy for how long objects in the bucket should be retained."
  type = object({
    is_locked        = bool
    retention_period = number
  })
  default = null
}

variable "custom_placement_config" {
  description = "Configuration of the bucket's custom location in a dual-region bucket setup. If the bucket is designated a single or multi-region, the variable are null."
  type = object({
    data_locations = list(string)
  })
  default = null
}

variable "cors" {
  description = "Configuration of CORS for bucket with structure as defined in https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket#cors."
  type = list(object({
    origin          = optional(list(string))
    method          = optional(list(string))
    response_header = optional(list(string))
    max_age_seconds = optional(number)
  }))
  default = []
}

variable "encryption" {
  description = "A Cloud KMS key that will be used to encrypt objects inserted into this bucket. The key name should follow the format of `projects/<project-name>/locations/<location-name>/keyRings/<keyring-name>/cryptoKeys/<key-name>`. To use a Cloud KMS key automatically created by this module use the `internal_encryption_config` input variable."
  type = object({
    default_kms_key_name = string
  })
  default = null
}

variable "lifecycle_rules" {
  description = "The bucket's Lifecycle Rules configuration."
  type = list(object({
    # Object with keys:
    # - type - The type of the action of this Lifecycle Rule. Supported values: Delete and SetStorageClass.
    # - storage_class - (Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule.
    action = object({
      type          = string
      storage_class = optional(string)
    })

    # Object with keys:
    # - age - (Optional) Minimum age of an object in days to satisfy this condition.
    # - send_age_if_zero - (Optional) While set true, num_newer_versions value will be sent in the request even for zero value of the field.
    # - created_before - (Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.
    # - with_state - (Optional) Match to live and/or archived objects. Supported values include: "LIVE", "ARCHIVED", "ANY".
    # - matches_storage_class - (Optional) Storage Class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.
    # - matches_prefix - (Optional) One or more matching name prefixes to satisfy this condition.
    # - matches_suffix - (Optional) One or more matching name suffixes to satisfy this condition
    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.
    # - custom_time_before - (Optional) A date in the RFC 3339 format YYYY-MM-DD. This condition is satisfied when the customTime metadata for the object is set to an earlier date than the date used in this lifecycle condition.
    # - days_since_custom_time - (Optional) Days since the date set in the customTime metadata for the object.
    # - days_since_noncurrent_time - (Optional) Relevant only for versioned objects. Number of days elapsed since the noncurrent timestamp of an object.
    # - noncurrent_time_before - (Optional) Relevant only for versioned objects. The date in RFC 3339 (e.g. 2017-06-13) when the object became nonconcurrent.
    condition = object({
      age                        = optional(number)
      send_age_if_zero           = optional(bool)
      created_before             = optional(string)
      with_state                 = optional(string)
      matches_storage_class      = optional(string)
      matches_prefix             = optional(string)
      matches_suffix             = optional(string)
      num_newer_versions         = optional(number)
      custom_time_before         = optional(string)
      days_since_custom_time     = optional(number)
      days_since_noncurrent_time = optional(number)
      noncurrent_time_before     = optional(string)
    })
  }))
  default = []
}

variable "log_bucket" {
  description = "The bucket that will receive log objects."
  type        = string
  default     = null
}

variable "log_object_prefix" {
  description = "The object prefix for log objects. If it's not provided, by default GCS sets this to this bucket's name"
  type        = string
  default     = null
}

variable "website" {
  type = object({
    main_page_suffix = optional(string)
    not_found_page   = optional(string)
  })
  default     = {}
  description = "Map of website values. Supported attributes: main_page_suffix, not_found_page"
}

variable "public_access_prevention" {
  description = "Prevents public access to a bucket. Acceptable values are inherited or enforced. If inherited, the bucket uses public access prevention, only if the bucket is subject to the public access prevention organization policy constraint."
  type        = string
  default     = "inherited"
}

variable "soft_delete_policy" {
  description = "Soft delete policies to apply. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#nested_soft_delete_policy"
  type = object({
    retention_duration_seconds = optional(number)
  })
  default = {}
}

variable "internal_encryption_config" {
  description = <<EOT
  Configuration for the creation of an internal Google Cloud Key Management Service (KMS) Key for use as Customer-managed encryption key (CMEK) for the GCS Bucket
  instead of creating one in advance and providing the key in the variable `encryption.default_kms_key_name`.
  create_encryption_key: If `true` a Google Cloud Key Management Service (KMS) KeyRing and a Key will be created
  prevent_destroy: Set the prevent_destroy lifecycle attribute on keys.
  key_destroy_scheduled_duration: Set the period of time that versions of keys spend in the `DESTROY_SCHEDULED` state before transitioning to `DESTROYED`.
  key_rotation_period: Generate a new key every time this period passes.
  EOT
  type = object({
    create_encryption_key          = optional(bool, false)
    prevent_destroy                = optional(bool, false)
    key_destroy_scheduled_duration = optional(string, null)
    key_rotation_period            = optional(string, "7776000s")
  })
  default = {}
}
