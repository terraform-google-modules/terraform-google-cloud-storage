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
  value       = google_storage_bucket.buckets[0]
}

output "name" {
  description = "Bucket name (for single use)."
  value       = google_storage_bucket.buckets[0].name
}

output "url" {
  description = "Bucket URL (for single use)."
  value       = google_storage_bucket.buckets[0].url
}

output "buckets" {
  description = "Bucket resources."
  value       = google_storage_bucket.buckets
}

output "names" {
  description = "Bucket names."
  value       = zipmap(var.names, slice(google_storage_bucket.buckets[*].name, 0, length(var.names)))
}

output "urls" {
  description = "Bucket URLs."
  value       = zipmap(var.names, slice(google_storage_bucket.buckets[*].url, 0, length(var.names)))
}

output "names_list" {
  description = "List of bucket names."
  value       = google_storage_bucket.buckets[*].name
}

output "urls_list" {
  description = "List of bucket URLs."
  value       = google_storage_bucket.buckets[*].url
}
