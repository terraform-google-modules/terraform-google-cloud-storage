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
  per_module_services = {
    simple_bucket = [
      "storage.googleapis.com",
      "cloudkms.googleapis.com",
      "iam.googleapis.com",
    ]
    root = [
      "storage.googleapis.com",
      "iam.googleapis.com",
      "serviceusage.googleapis.com",
      "cloudresourcemanager.googleapis.com",
    ]
  }
}

module "project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.0"

  name              = "ci-cloud-storage"
  random_project_id = "true"
  org_id            = var.org_id
  folder_id         = var.folder_id
  billing_account   = var.billing_account

  activate_apis = concat([
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "serviceusage.googleapis.com",
    "storage-api.googleapis.com",
  ], flatten(values(local.per_module_services)))
}
