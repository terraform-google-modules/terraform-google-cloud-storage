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
  # [for o in var.list : o.interfaces[0].name]
  topics = [for o in var.bucket_configs : o.topic]
}

# Create the notifications
resource "google_storage_notification" "notifications" {
  for_each = var.bucket_configs

  # project_id = var.project_id
  bucket         = lookup(each.value, "bucket")
  payload_format = "JSON_API_V1"

  topic       = lookup(each.value, "topic")
  event_types = var.event_types

  depends_on = [module.pubsub-iam-bindings.members]
}

# Enable IAM
data "google_storage_project_service_account" "gcs_account" {
  project = var.project_id
}

module "pubsub-iam-bindings" {
  source  = "terraform-google-modules/iam/google//modules/pubsub_topics_iam"
  version = "~> 5.0"

  project = var.project_id

  pubsub_topics = local.topics
  mode          = "additive"

  bindings = {
    "roles/pubsub.publisher" = [
      "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
    ]
  }
}
