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

locals {
  prefix = "${var.prefix == "" ? "" : "${var.prefix}-"}${lower(var.location)}"
}

resource "google_storage_bucket" "buckets" {
  count   = length(var.names)
  name    = "${var.prefix}-${lower(element(var.names, count.index))}"
  project = var.project_id
  bucket_policy_only = lookup(
    var.bucket_policy_only,
    lower(element(var.names, count.index)),
    true,
  )
  location      = var.location
  storage_class = var.storage_class
  labels        = var.labels

  versioning {
    enabled = lookup(
      var.versioning,
      lower(element(var.names, count.index)),
      false,
    )
  }
}

resource "google_storage_bucket_iam_binding" "admins" {
  count  = var.set_admin_roles ? length(var.names) : 0
  bucket = element(google_storage_bucket.buckets.*.name, count.index)
  role   = "roles/storage.objectAdmin"

  members = compact(
    concat(
      var.admins,
      split(
        ",",
        lookup(var.bucket_admins, element(var.names, count.index), ""),
      ),
    ),
  )
}

resource "google_storage_bucket_iam_binding" "creators" {
  count  = var.set_creator_roles ? length(var.names) : 0
  bucket = element(google_storage_bucket.buckets.*.name, count.index)
  role   = "roles/storage.objectCreator"

  members = compact(
    concat(
      var.creators,
      split(
        ",",
        lookup(var.bucket_creators, element(var.names, count.index), ""),
      ),
    ),
  )
}

resource "google_storage_bucket_iam_binding" "viewers" {
  count  = var.set_viewer_roles ? length(var.names) : 0
  bucket = element(google_storage_bucket.buckets.*.name, count.index)
  role   = "roles/storage.objectViewer"

  members = compact(
    concat(
      var.viewers,
      split(
        ",",
        lookup(var.bucket_viewers, element(var.names, count.index), ""),
      ),
    ),
  )
}

