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
}

variable "names" {
  description = "Bucket name suffixes."
  type        = list(string)
}

variable "location" {
  description = "Bucket location."
  type        = string
  default     = "EU"
}

variable "storage_class" {
  description = "Bucket storage class."
  type        = string
  default     = "MULTI_REGIONAL"
}

variable "force_destroy" {
  description = "Optional map of lowercase unprefixed name => boolean, defaults to false."
  type        = map
  default     = {}
}

variable "versioning" {
  description = "Optional map of lowercase unprefixed name => boolean, defaults to false."
  type        = map
  default     = {}
}

variable "encryption_key_names" {
  description = "Optional map of lowercase unprefixed name => string, empty strings are ignored."
  type        = map
  default     = {}
}

variable "uniform_bucket_level_access" {
  description = "Disable ad-hoc ACLs on specified buckets. Defaults to true. Map of lowercase unprefixed name => boolean"
  type        = map
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

variable "bucket_admins" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style bucket admins."
  type        = map
  default     = {}
}

variable "bucket_creators" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style bucket creators."
  type        = map
  default     = {}
}

variable "bucket_viewers" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style bucket viewers."
  type        = map
  default     = {}
}

variable "labels" {
  description = "Labels to be attached to the buckets"
  type        = map
  default     = {}
}

variable "folders" {
  description = "Map of lowercase unprefixed name => list of top level folder objects."
  type        = map
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

variable "lifecycle_rules" {
  type = set(object({
    # Object with keys:
    # - type - The type of the action of this Lifecycle Rule. Supported values: Delete and SetStorageClass.
    # - storage_class - (Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule.
    action = map(string)

    # Object with keys:
    # - age - (Optional) Minimum age of an object in days to satisfy this condition.
    # - created_before - (Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.
    # - with_state - (Optional) Match to live and/or archived objects. Supported values include: "LIVE", "ARCHIVED", "ANY".
    # - matches_storage_class - (Optional) Comma delimited string for storage class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.
    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.
    condition = map(string)
  }))
  description = "List of lifecycle rules to configure. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#lifecycle_rule except condition.matches_storage_class should be a comma delimited string."
  default     = []
}

variable "cors" {
  description = "Map of maps of mixed type attributes for CORS values. See appropriate attribute types here: https://www.terraform.io/docs/providers/google/r/storage_bucket.html#cors"
  type        = any
  default     = {}
}

variable "website" {
  type        = any
  default     = {}
  description = "Map of website values. Supported attributes: main_page_suffix, not_found_page"
}
