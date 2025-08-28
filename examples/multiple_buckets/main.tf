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

resource "random_string" "prefix" {
  length  = 4
  upper   = false
  special = false
}

module "cloud_storage" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "~> 11.0"

  project_id = var.project_id

  prefix           = "multiple-buckets-${random_string.prefix.result}"
  names            = ["one", "two"]
  randomize_suffix = true

  bucket_policy_only = {
    "one" = true
    "two" = false
  }

  folders = {
    "two" = ["dev", "prod"]
  }

  lifecycle_rules = [
    {
      action = {
        type          = "SetStorageClass"
        storage_class = "NEARLINE"
      }
      condition = {
        age                   = "10"
        matches_storage_class = "MULTI_REGIONAL,STANDARD,DURABLE_REDUCED_AVAILABILITY"
      }
    }
  ]

  bucket_lifecycle_rules = {
    "one" = [
      {
        action = {
          type = "Delete"
        }
        condition = {
          age = "90"
        }
      }
    ]
  }

  retention_policy = {
    "two" = {
      is_locked        = false
      retention_period = 1
    }
  }

  default_event_based_hold = {
    "one" = true
  }
}
