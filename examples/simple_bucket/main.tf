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

module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 11.0"

  name       = "${var.project_id}-bucket"
  project_id = var.project_id
  location   = "us"

  website = {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  cors = [{
    origin          = ["http://image-store.com"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }]

  lifecycle_rules = [{
    action = {
      type = "Delete"
    }
    condition = {
      age            = 365
      with_state     = "ANY"
      matches_prefix = var.project_id
    }
  }]

  custom_placement_config = {
    data_locations : ["US-EAST4", "US-WEST1"]
  }

  iam_members = [{
    role   = "roles/storage.objectViewer"
    member = "group:test-gcp-ops@test.blueprints.joonix.net"
  }]

  autoclass = true
  retention_policy = {
    retention_period = 2
  }
}
