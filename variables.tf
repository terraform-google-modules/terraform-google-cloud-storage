/**
 * Copyright 2018 Google LLC
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
  description = "Bucket project id."
  type        = string
}

variable "prefix" {
  description = "Prefix used to generate the bucket name."
  type        = string
  default     = ""
}

variable "names" {
  description = "Bucket name suffixes."
  type        = list(string)
}

variable "randomize_suffix" {
  description = "Adds an identical, but randomized 4-character suffix to all bucket names"
  type        = bool
  default     = false
}

variable "location" {
  description = "Bucket location."
  type        = string
  default     = "EU"
}

variable "storage_class" {
  description = "Bucket storage class."
  type        = string
  default     = "STANDARD"
}

variable "force_destroy" {
  description = "Optional map of lowercase unprefixed name => boolean, defaults to false."
  type        = map(bool)
  default     = {}
}

variable "versioning" {
  description = "Optional map of lowercase unprefixed name => boolean, defaults to false."
  type        = map(bool)
  default     = {}
}

variable "autoclass" {
  description = "Optional map of lowercase unprefixed bucket name => boolean, defaults to false."
  type        = map(bool)
  default     = {}
}

variable "hierarchical_namespace" {
  description = "Optional map of lowercase unprefixed bucket name => boolean, defaults to false."
  type        = map(bool)
  default     = {}
}

variable "encryption_key_names" {
  description = "Optional map of lowercase unprefixed name => string, empty strings are ignored."
  type        = map(string)
  default     = {}
}

variable "bucket_policy_only" {
  description = "Disable ad-hoc ACLs on specified buckets. Defaults to true. Map of lowercase unprefixed name => boolean"
  type        = map(bool)
  default     = {}
}

variable "default_event_based_hold" {
  description = "Enable event based hold to new objects added to specific bucket. Defaults to false. Map of lowercase unprefixed name => boolean"
  type        = map(bool)
  default     = {}
}

variable "admins" {
  description = "IAM-style members who will be granted roles/storage.objectAdmin on all buckets."
  type        = list(string)
  default     = []
}

variable "creators" {
  description = "IAM-style members who will be granted roles/storage.objectCreators on all buckets."
  type        = list(string)
  default     = []
}

variable "viewers" {
  description = "IAM-style members who will be granted roles/storage.objectViewer on all buckets."
  type        = list(string)
  default     = []
}

variable "hmac_key_admins" {
  description = "IAM-style members who will be granted roles/storage.hmacKeyAdmin on all buckets."
  type        = list(string)
  default     = []
}

variable "storage_admins" {
  description = "IAM-style members who will be granted roles/storage.admin on all buckets."
  type        = list(string)
  default     = []
}

variable "bucket_admins" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket admins."
  type        = map(string)
  default     = {}
}

variable "bucket_creators" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket creators."
  type        = map(string)
  default     = {}
}

variable "bucket_viewers" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket viewers."
  type        = map(string)
  default     = {}
}

variable "bucket_hmac_key_admins" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket HMAC Key admins."
  type        = map(string)
  default     = {}
}

variable "bucket_storage_admins" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style per-bucket storage admins."
  type        = map(string)
  default     = {}
}

variable "labels" {
  description = "Labels to be attached to the buckets"
  type        = map(string)
  default     = {}
}

variable "folders" {
  description = "Map of lowercase unprefixed name => list of top level folder objects."
  type        = map(list(string))
  default     = {}
}

# we need flags to allow member lists to contain dynamic elements

variable "set_admin_roles" {
  description = "Grant roles/storage.objectAdmin role to admins and bucket_admins."
  type        = bool
  default     = false
}

variable "set_creator_roles" {
  description = "Grant roles/storage.objectCreator role to creators and bucket_creators."
  type        = bool
  default     = false
}

variable "set_viewer_roles" {
  description = "Grant roles/storage.objectViewer role to viewers and bucket_viewers."
  type        = bool
  default     = false
}

variable "set_hmac_key_admin_roles" {
  description = "Grant roles/storage.hmacKeyAdmin role to hmac_key_admins and bucket_hmac_key_admins."
  type        = bool
  default     = false
}

variable "set_storage_admin_roles" {
  description = "Grant roles/storage.admin role to storage_admins and bucket_storage_admins."
  type        = bool
  default     = false
}

variable "lifecycle_rules" {
  type = set(object({
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
    # - matches_storage_class - (Optional) Comma delimited string for storage class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.
    # - matches_prefix - (Optional) One or more matching name prefixes to satisfy this condition.
    # - matches_suffix - (Optional) One or more matching name suffixes to satisfy this condition.
    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.
    # - custom_time_before - (Optional) A date in the RFC 3339 format YYYY-MM-DD. This condition is satisfied when the customTime metadata for the object is set to an earlier date than the date used in this lifecycle condition.
    # - days_since_custom_time - (Optional) The number of days from the Custom-Time metadata attribute after which this condition becomes true.
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
  description = "List of lifecycle rules to configure. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#lifecycle_rule except condition.matches_storage_class should be a comma delimited string."
  default     = []
}

variable "bucket_lifecycle_rules" {
  type = map(set(object({
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
  })))
  description = "Additional lifecycle_rules for specific buckets. Map of lowercase unprefixed name => list of lifecycle rules to configure."
  default     = {}
}

variable "cors" {
  description = "Set of maps of mixed type attributes for CORS values. See appropriate attribute types here: https://www.terraform.io/docs/providers/google/r/storage_bucket.html#cors"
  type = list(object({
    origin          = optional(list(string))
    method          = optional(list(string))
    response_header = optional(list(string))
    max_age_seconds = optional(number)
  }))
  default = []
}

variable "website" {
  type = object({
    main_page_suffix = optional(string)
    not_found_page   = optional(string)
  })
  default     = {}
  description = "Map of website values. Supported attributes: main_page_suffix, not_found_page"
}

variable "retention_policy" {
  type        = any
  default     = {}
  description = "Map of retention policy values. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket#retention_policy"
}

variable "custom_placement_config" {
  type        = any
  default     = {}
  description = "Map of lowercase unprefixed name => custom placement config object. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket#custom_placement_config"
}

variable "logging" {
  description = "Map of lowercase unprefixed name => bucket logging config object. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#logging"
  type        = any
  default     = {}
}

variable "set_hmac_access" {
  description = "Set S3 compatible access to GCS."
  type        = bool
  default     = false
}

variable "hmac_service_accounts" {
  description = "List of HMAC service accounts to grant access to GCS."
  type        = map(string)
  default     = {}
}

variable "public_access_prevention" {
  description = "Prevents public access to a bucket. Acceptable values are inherited or enforced. If inherited, the bucket uses public access prevention, only if the bucket is subject to the public access prevention organization policy constraint."
  type        = string
  default     = "inherited"
}

variable "soft_delete_policy" {
  description = "Soft delete policies to apply. Map of lowercase unprefixed name => soft delete policy. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#nested_soft_delete_policy"
  type        = map(any)
  default     = {}
}
