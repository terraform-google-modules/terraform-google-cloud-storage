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
  per_module_roles = {
    simple_bucket = [
      "roles/storage.admin",
      "roles/iam.serviceAccountUser",
      "roles/cloudkms.admin",
      "roles/logging.logWriter",
    ]
    root = [
      "roles/resourcemanager.projectIamAdmin",
      "roles/serviceusage.serviceUsageAdmin",
      "roles/storage.admin",
      "roles/iam.serviceAccountAdmin",
      "roles/iam.serviceAccountUser",
    ]
  }

  int_required_roles = concat([
    "roles/cloudkms.cryptoKeyEncrypterDecrypter",
    "roles/iam.serviceAccountUser",
    "roles/storage.admin",
    "projects/${module.project.project_id}/roles/${google_project_iam_custom_role.int_test.role_id}",
  ], flatten(values(local.per_module_roles)))
}

resource "google_project_iam_custom_role" "int_test" {
  project     = module.project.project_id
  role_id     = "BypassBucketIPfiltering"
  title       = "Bypass bucket IP filtering"
  description = "Allow test service account to bypass bucket ip filtering rules"
  permissions = ["storage.buckets.exemptFromIpFilter"]
}

resource "google_service_account" "int_test" {
  project      = module.project.project_id
  account_id   = "ci-cloud-storage"
  display_name = "ci-cloud-storage"
}

resource "google_project_iam_member" "int_test" {
  count = length(local.int_required_roles)

  project = module.project.project_id
  role    = local.int_required_roles[count.index]
  member  = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_service_account_key" "int_test" {
  service_account_id = google_service_account.int_test.id
}
