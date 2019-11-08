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

output "bucket" {
  description = "Bucket resource (for single use)."
  value       = length(local.bucket_names_list) > 0 ? google_storage_bucket.buckets[var.names[0]] : null
}

output "name" {
  description = "Bucket name (for single use)."
  value       = lookup(local.bucket_names, var.names[0], null)
}

output "url" {
  description = "Bucket URL (for single use)."
  value       = lookup(local.bucket_urls, var.names[0], null)
}

output "buckets" {
  description = "Bucket resources."
  value       = google_storage_bucket.buckets
}

output "names" {
  description = "Bucket names."
  value       = local.bucket_names
}

output "urls" {
  description = "Bucket URLs."
  value       = local.bucket_urls
}

output "names_list" {
  description = "List of bucket names."
  value       = local.bucket_names_list
}

output "urls_list" {
  description = "List of bucket URLs."
  value       = local.bucket_urls_list
}
