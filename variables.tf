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
  default     = "EU"
  type        = string
}

variable "storage_class" {
  description = "Bucket storage class."
  default     = "MULTI_REGIONAL"
  type        = string
}

variable "force_destroy" {
  description = "Optional map of lowercase unprefixed name => boolean, defaults to false."
  default     = {}
  type        = map
}

variable "versioning" {
  description = "Optional map of lowercase unprefixed name => boolean, defaults to false."
  default     = {}
  type        = map
}

variable "encryption_key_names" {
  description = "Optional map of lowercase unprefixed name => string, empty strings are ignored."
  default     = {}
  type        = map
}

variable "bucket_policy_only" {
  description = "Disable ad-hoc ACLs on specified buckets. Defaults to true. Map of lowercase unprefixed name => boolean"
  default     = {}
  type        = map
}

variable "admins" {
  description = "IAM-style members who will be granted roles/storage.objectAdmin on all buckets."
  default     = []
  type        = list(string)
}

variable "creators" {
  description = "IAM-style members who will be granted roles/storage.objectCreators on all buckets."
  default     = []
  type        = list(string)
}

variable "viewers" {
  description = "IAM-style members who will be granted roles/storage.objectViewer on all buckets."
  default     = []
  type        = list(string)
}

variable "bucket_admins" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style bucket admins."
  default     = {}
  type        = map
}

variable "bucket_creators" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style bucket creators."
  default     = {}
  type        = map
}

variable "bucket_viewers" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style bucket viewers."
  default     = {}
  type        = map
}

variable "labels" {
  description = "Labels to be attached to the buckets"
  default     = {}
  type        = map
}

# we need flags to allow member lists to contain dynamic elements

variable "set_admin_roles" {
  description = "Grant roles/storage.objectAdmin role to admins and bucket_admins."
  default     = false
  type        = bool
}

variable "set_creator_roles" {
  description = "Grant roles/storage.objectCreator role to creators and bucket_creators."
  default     = false
  type        = bool
}

variable "set_viewer_roles" {
  description = "Grant roles/storage.objectViewer role to viewers and bucket_viewers."
  default     = false
  type        = bool
}

variable "lifecycle_rules" {
  type = set(object({
    action = object({
      type          = string
      storage_class = string
    })
    condition = map(string)
  }))
  description = "List of lifecycle rules to configure. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#lifecycle_rule except condition.matches_storage_class should be a comma delimited string."
  default     = []
  type        = list(string)
}
