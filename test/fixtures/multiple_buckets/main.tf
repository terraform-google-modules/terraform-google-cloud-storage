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

provider "random" {
  version = "~> 2.0"
}

resource "random_string" "prefix" {
  length  = 4
  upper   = false
  special = false
}

module "example" {
  source     = "../../../examples/multiple_buckets"
  project_id = var.project_id
  prefix     = "multiple-buckets-${random_string.prefix.result}"
  names      = ["one", "two"]

  bucket_policy_only = {
    "one" = true
    "two" = false
  }
}
