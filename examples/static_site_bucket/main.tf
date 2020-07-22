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

provider "google" {
  version = "~> 2.18.0"
}


##This should actually be a legitimate FQDN.
##Using a random name here due to domain ownership verification requirements
## https://cloud.google.com/storage/docs/domain-name-verification#requirements

locals {
  fqdn = "example-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

module "static_site" {
  source           = "../.."
  project_id       = var.project_id
  prefix           = ""
  names            = [local.fqdn]
  set_reader_roles = true

  bucket_readers = {
    "${local.fqdn}" = "allUsers"
  }

  website = {
    "${local.fqdn}" = {
      main_page_suffix = "index.html"
      not_found_page   = "404.html"
    },
  }

  cors = {
    "${local.fqdn}" = {
      origin          = ["http://${local.fqdn}"]
      method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
      response_header = ["*"]
      max_age_seconds = 3600
    },
  }


}
