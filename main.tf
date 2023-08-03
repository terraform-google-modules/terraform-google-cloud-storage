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

/******************************************
  Bucket random id suffix configuration
 *****************************************/
resource "random_id" "bucket_suffix" {
  count       = var.randomize_suffix ? 1 : 0
  byte_length = 2
}

locals {
  suffix       = var.randomize_suffix ? random_id.bucket_suffix[0].hex : ""
  names_set    = toset(var.names)
  buckets_list = [for name in var.names : google_storage_bucket.buckets[name]]
  first_bucket = local.buckets_list[0]
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
  for_each = local.names_set

  name                     = join("-", compact([var.prefix, each.value, local.suffix]))
  project                  = var.project_id
  location                 = var.location
  storage_class            = var.storage_class
  labels                   = merge(var.labels, { name = replace(join("-", compact([var.prefix, each.value])), ".", "-") })
  public_access_prevention = var.public_access_prevention

  force_destroy = lookup(
    var.force_destroy,
    lower(each.value),
    false,
  )
  uniform_bucket_level_access = lookup(
    var.bucket_policy_only,
    lower(each.value),
    true,
  )
  versioning {
    enabled = lookup(
      var.versioning,
      lower(each.value),
      false,
    )
  }
  default_event_based_hold = lookup(
    var.default_event_based_hold,
    lower(each.value),
    false,
  )
  autoclass {
    enabled = lookup(
      var.autoclass,
      lower(each.value),
      false,
    )
  }
  # Having a permanent encryption block with default_kms_key_name = "" works but results in terraform applying a change every run
  # There is no enabled = false attribute available to ask terraform to ignore the block
  dynamic "encryption" {
    # If an encryption key name is set for this bucket name -> Create a single encryption block
    for_each = trimspace(lookup(var.encryption_key_names, lower(each.value), "")) != "" ? [true] : []
    content {
      default_kms_key_name = trimspace(
        lookup(
          var.encryption_key_names,
          lower(each.value),
          "Error retrieving kms key name", # Should be unreachable due to the for_each check
          # Omitting default is deprecated & can help show if there was a bug
          # https://www.terraform.io/docs/configuration/functions/lookup.html
        )
      )
    }
  }
  dynamic "cors" {
    for_each = var.cors
    content {
      origin          = lookup(cors.value, "origin", null)
      method          = lookup(cors.value, "method", null)
      response_header = lookup(cors.value, "response_header", null)
      max_age_seconds = lookup(cors.value, "max_age_seconds", null)
    }
  }
  dynamic "website" {
    for_each = length(keys(var.website)) == 0 ? toset([]) : toset([var.website])
    content {
      main_page_suffix = lookup(website.value, "main_page_suffix", null)
      not_found_page   = lookup(website.value, "not_found_page", null)
    }
  }

  dynamic "retention_policy" {
    for_each = lookup(var.retention_policy, each.value, {}) != {} ? [var.retention_policy[each.value]] : []
    content {
      is_locked        = lookup(retention_policy.value, "is_locked", null)
      retention_period = lookup(retention_policy.value, "retention_period", null)
    }
  }

  dynamic "custom_placement_config" {
    for_each = lookup(var.custom_placement_config, each.value, {}) != {} ? [var.custom_placement_config[each.value]] : []
    content {
      data_locations = lookup(custom_placement_config.value, "data_locations", null)
    }
  }

  dynamic "lifecycle_rule" {
    for_each = setunion(var.lifecycle_rules, lookup(var.bucket_lifecycle_rules, each.value, toset([])))
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                        = lookup(lifecycle_rule.value.condition, "age", null)
        created_before             = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state                 = lookup(lifecycle_rule.value.condition, "with_state", contains(keys(lifecycle_rule.value.condition), "is_live") ? (lifecycle_rule.value.condition["is_live"] ? "LIVE" : null) : null)
        matches_storage_class      = contains(keys(lifecycle_rule.value.condition), "matches_storage_class") ? split(",", lifecycle_rule.value.condition["matches_storage_class"]) : null
        matches_prefix             = contains(keys(lifecycle_rule.value.condition), "matches_prefix") ? split(",", lifecycle_rule.value.condition["matches_prefix"]) : null
        matches_suffix             = contains(keys(lifecycle_rule.value.condition), "matches_suffix") ? split(",", lifecycle_rule.value.condition["matches_suffix"]) : null
        num_newer_versions         = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
        custom_time_before         = lookup(lifecycle_rule.value.condition, "custom_time_before", null)
        days_since_custom_time     = lookup(lifecycle_rule.value.condition, "days_since_custom_time", null)
        days_since_noncurrent_time = lookup(lifecycle_rule.value.condition, "days_since_noncurrent_time", null)
        noncurrent_time_before     = lookup(lifecycle_rule.value.condition, "noncurrent_time_before", null)
      }
    }
  }

  dynamic "logging" {
    for_each = lookup(var.logging, each.value, {}) != {} ? { v = lookup(var.logging, each.value) } : {}
    content {
      log_bucket        = lookup(logging.value, "log_bucket", null)
      log_object_prefix = lookup(logging.value, "log_object_prefix", null)
    }
  }
}

resource "google_storage_bucket_iam_binding" "admins" {
  for_each = var.set_admin_roles ? local.names_set : []
  bucket   = google_storage_bucket.buckets[each.value].name
  role     = "roles/storage.objectAdmin"
  members = compact(
    concat(
      var.admins,
      split(
        ",",
        lookup(var.bucket_admins, each.value, ""),
      ),
    ),
  )
}

resource "google_storage_bucket_iam_binding" "creators" {
  for_each = var.set_creator_roles ? local.names_set : toset([])
  bucket   = google_storage_bucket.buckets[each.value].name
  role     = "roles/storage.objectCreator"
  members = compact(
    concat(
      var.creators,
      split(
        ",",
        lookup(var.bucket_creators, each.value, ""),
      ),
    ),
  )
}

resource "google_storage_bucket_iam_binding" "viewers" {
  for_each = var.set_viewer_roles ? local.names_set : toset([])
  bucket   = google_storage_bucket.buckets[each.value].name
  role     = "roles/storage.objectViewer"
  members = compact(
    concat(
      var.viewers,
      split(
        ",",
        lookup(var.bucket_viewers, each.value, ""),
      ),
    ),
  )
}

resource "google_storage_bucket_iam_binding" "hmac_key_admins" {
  for_each = var.set_hmac_key_admin_roles ? local.names_set : toset([])
  bucket   = google_storage_bucket.buckets[each.key].name
  role     = "roles/storage.hmacKeyAdmin"
  members = compact(
    concat(
      var.hmac_key_admins,
      split(
        ",",
        lookup(var.bucket_hmac_key_admins, each.key, ""),
      ),
    ),
  )
}

resource "google_storage_bucket_iam_binding" "storage_admins" {
  for_each = var.set_storage_admin_roles ? local.names_set : toset([])
  bucket   = google_storage_bucket.buckets[each.value].name
  role     = "roles/storage.admin"
  members = compact(
    concat(
      var.storage_admins,
      split(
        ",",
        lookup(var.bucket_storage_admins, each.value, ""),
      ),
    ),
  )
}

resource "google_storage_bucket_object" "folders" {
  for_each = { for obj in local.folder_list : "${obj.bucket}_${obj.folder}" => obj }
  bucket   = google_storage_bucket.buckets[each.value.bucket].name
  name     = "${each.value.folder}/" # Declaring an object with a trailing '/' creates a directory
  content  = "foo"                   # Note that the content string isn't actually used, but is only there since the resource requires it
}

resource "google_storage_hmac_key" "hmac_keys" {
  project               = var.project_id
  for_each              = var.set_hmac_access ? var.hmac_service_accounts : {}
  service_account_email = each.key
  state                 = each.value
}
