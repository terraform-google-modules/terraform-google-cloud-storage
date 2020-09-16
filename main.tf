/**
 * Copyright 2019 Google LLC
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
  prefix = var.prefix == "" ? "" : join("-", list(var.prefix, lower(var.location), ""))
  folder_list = flatten([
    for bucket, folders in var.folders : [
      for folder in folders : {
        bucket = bucket,
        folder = folder
      }
    ]
  ])
}

resource "google_storage_bucket" "buckets" {
  count         = length(var.names)
  name          = "${local.prefix}${lower(element(var.names, count.index))}"
  project       = var.project_id
  location      = var.location
  storage_class = var.storage_class
  labels        = merge(var.labels, { name = replace("${local.prefix}${lower(element(var.names, count.index))}", ".", "-") })
  force_destroy = lookup(
    var.force_destroy,
    lower(element(var.names, count.index)),
    false,
  )
  uniform_bucket_level_access = lookup(
    var.uniform_bucket_level_access,
    lower(element(var.names, count.index)),
    true,
  )
  versioning {
    enabled = lookup(
      var.versioning,
      lower(element(var.names, count.index)),
      false,
    )
  }
  # Having a permanent encryption block with default_kms_key_name = "" works but results in terraform applying a change every run
  # There is no enabled = false attribute available to ask terraform to ignore the block
  dynamic "encryption" {
    # If an encryption key name is set for this bucket name -> Create a single encryption block
    for_each = trimspace(lookup(var.encryption_key_names, lower(element(var.names, count.index)), "")) != "" ? [true] : []
    content {
      default_kms_key_name = trimspace(
        lookup(
          var.encryption_key_names,
          lower(element(var.names, count.index)),
          "Error retrieving kms key name", # Should be unreachable due to the for_each check
          # Omitting default is deprecated & can help show if there was a bug
          # https://www.terraform.io/docs/configuration/functions/lookup.html
        )
      )
    }
  }
  dynamic "cors" {
    for_each = lookup(var.cors, element(var.names, count.index), {}) != {} ? { v = lookup(var.cors, element(var.names, count.index)) } : {}
    content {
      origin          = lookup(cors.value, "origin", null)
      method          = lookup(cors.value, "method", null)
      response_header = lookup(cors.value, "response_header", null)
      max_age_seconds = lookup(cors.value, "max_age_seconds", null)
    }
  }
  dynamic "website" {
    for_each = lookup(var.website, element(var.names, count.index), {}) != {} ? { v = lookup(var.website, element(var.names, count.index)) } : {}
    content {
      main_page_suffix = lookup(website.value, "main_page_suffix", null)
      not_found_page   = lookup(website.value, "not_found_page", null)
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                   = lookup(lifecycle_rule.value.condition, "age", null)
        created_before        = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state            = lookup(lifecycle_rule.value.condition, "with_state", null)
        is_live               = lookup(lifecycle_rule.value.condition, "is_live", null)
        matches_storage_class = contains(keys(lifecycle_rule.value.condition), "matches_storage_class") ? split(",", lifecycle_rule.value.condition["matches_storage_class"]) : null
        num_newer_versions    = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
      }
    }
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

resource "google_storage_bucket_object" "folders" {
  for_each = { for obj in local.folder_list : "${obj.bucket}_${obj.folder}" => obj }
  bucket   = element(google_storage_bucket.buckets.*.name, index(var.names, each.value.bucket))
  name     = "${each.value.folder}/" # Declaring an object with a trailing '/' creates a directory
  content  = "foo"                   # Note that the content string isn't actually used, but is only there since the resource requires it
}
