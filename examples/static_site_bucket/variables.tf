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
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "names_list" {
  description = "Names of the buckets to create."
  type        = list(string)
  default     = ["example.com"]
}

variable "prefix" {
  description = "Prefix used to generate bucket names."
  type        = string
  default     = ""
}

variable "names" {
  description = "Bucket name suffixes."
  type        = list(string)
}

variable "set_reader_roles" {
  description = "Grant roles/storage.legacyObjectReader role to readers and bucket_readers."
  type        = bool
  default     = false
}

variable "bucket_readers" {
  description = "Map of lowercase unprefixed name => comma-delimited IAM-style bucket legacy readers."
  type        = map
  default     = {}
}

variable "website" {
  type        = any
  default     = {}
  description = "Map of website values. Supported attributes: main_page_suffix, not_found_page"
}

variable "cors" {
  description = "Map of maps of mixed type attributes for CORS values. See appropriate attribute types here: https://www.terraform.io/docs/providers/google/r/storage_bucket.html#cors"
  type        = any
  default     = {}
}

