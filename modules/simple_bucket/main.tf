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

locals {
  internal_encryption = var.internal_encryption_config.create_encryption_key ? { default_kms_key_name = module.encryption_key[0].keys[var.name] } : null
  encryption          = var.internal_encryption_config.create_encryption_key ? local.internal_encryption : var.encryption
}

resource "google_storage_bucket" "bucket" {
  name                        = var.name
  project                     = var.project_id
  location                    = var.location
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.bucket_policy_only
  labels                      = var.labels
  force_destroy               = var.force_destroy
  public_access_prevention    = var.public_access_prevention

  versioning {
    enabled = var.versioning
  }

  autoclass {
    enabled = var.autoclass
  }

  dynamic "retention_policy" {
    for_each = var.retention_policy == null ? [] : [var.retention_policy]
    content {
      is_locked        = var.retention_policy.is_locked
      retention_period = var.retention_policy.retention_period
    }
  }

  dynamic "encryption" {
    for_each = local.encryption == null ? [] : [local.encryption]
    content {
      default_kms_key_name = local.encryption.default_kms_key_name
    }
  }

  dynamic "website" {
    for_each = (var.website.main_page_suffix == null && var.website.not_found_page == null) ? toset([]) : toset([var.website])
    content {
      main_page_suffix = lookup(website.value, "main_page_suffix", null)
      not_found_page   = lookup(website.value, "not_found_page", null)
    }
  }

  dynamic "cors" {
    for_each = var.cors == null ? [] : var.cors
    content {
      origin          = lookup(cors.value, "origin", null)
      method          = lookup(cors.value, "method", null)
      response_header = lookup(cors.value, "response_header", null)
      max_age_seconds = lookup(cors.value, "max_age_seconds", null)
    }
  }

  dynamic "custom_placement_config" {
    for_each = var.custom_placement_config == null ? [] : [var.custom_placement_config]
    content {
      data_locations = var.custom_placement_config.data_locations
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
        age                        = lookup(lifecycle_rule.value.condition, "age", null)
        send_age_if_zero           = lookup(lifecycle_rule.value.condition, "send_age_if_zero", null)
        created_before             = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state                 = lookup(lifecycle_rule.value.condition, "with_state", contains(keys(lifecycle_rule.value.condition), "is_live") ? (lifecycle_rule.value.condition["is_live"] ? "LIVE" : null) : null)
        matches_storage_class      = lifecycle_rule.value.condition["matches_storage_class"] != null ? split(",", lifecycle_rule.value.condition["matches_storage_class"]) : null
        matches_prefix             = lifecycle_rule.value.condition["matches_prefix"] != null ? split(",", lifecycle_rule.value.condition["matches_prefix"]) : null
        matches_suffix             = lifecycle_rule.value.condition["matches_suffix"] != null ? split(",", lifecycle_rule.value.condition["matches_suffix"]) : null
        num_newer_versions         = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
        custom_time_before         = lookup(lifecycle_rule.value.condition, "custom_time_before", null)
        days_since_custom_time     = lookup(lifecycle_rule.value.condition, "days_since_custom_time", null)
        days_since_noncurrent_time = lookup(lifecycle_rule.value.condition, "days_since_noncurrent_time", null)
        noncurrent_time_before     = lookup(lifecycle_rule.value.condition, "noncurrent_time_before", null)
      }
    }
  }

  dynamic "logging" {
    for_each = var.log_bucket == null ? [] : [var.log_bucket]
    content {
      log_bucket        = var.log_bucket
      log_object_prefix = var.log_object_prefix
    }
  }

  dynamic "soft_delete_policy" {
    for_each = var.soft_delete_policy == {} ? [] : [var.soft_delete_policy]
    content {
      retention_duration_seconds = lookup(soft_delete_policy.value, "retention_duration_seconds", null)
    }
  }
}

resource "google_storage_bucket_iam_member" "members" {
  for_each = {
    for m in var.iam_members : "${m.role} ${m.member}" => m
  }
  bucket = google_storage_bucket.bucket.name
  role   = each.value.role
  member = each.value.member
}

data "google_storage_project_service_account" "gcs_account" {
  project = var.project_id
}

module "encryption_key" {
  source  = "terraform-google-modules/kms/google"
  version = "~> 4.0"
  count   = var.internal_encryption_config.create_encryption_key ? 1 : 0

  project_id                     = var.project_id
  location                       = lower(var.location)
  keyring                        = var.name
  prevent_destroy                = var.internal_encryption_config.prevent_destroy
  key_destroy_scheduled_duration = var.internal_encryption_config.key_destroy_scheduled_duration
  key_rotation_period            = var.internal_encryption_config.key_rotation_period
  keys                           = [var.name]
  set_decrypters_for             = [var.name]
  set_encrypters_for             = [var.name]
  decrypters                     = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
  encrypters                     = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
}
