# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Make will use bash instead of sh
SHELL := /usr/bin/env bash

DOCKER_TAG_VERSION_DEVELOPER_TOOLS := 1.25.4
DOCKER_IMAGE_DEVELOPER_TOOLS := cft/developer-tools
REGISTRY_URL := gcr.io/cloud-foundation-cicd

# Enter docker container for local development
.PHONY: docker_run
docker_run:
	docker run --rm -it \
		-e SERVICE_ACCOUNT_JSON \
		-v $(CURDIR):/workspace \
		$(REGISTRY_URL)/${DOCKER_IMAGE_DEVELOPER_TOOLS}:${DOCKER_TAG_VERSION_DEVELOPER_TOOLS} \
		/bin/bash

# Execute prepare tests within the docker container
.PHONY: docker_test_prepare
docker_test_prepare:
	docker run --rm -it \
		-e SERVICE_ACCOUNT_JSON \
		-e TF_VAR_org_id \
		-e TF_VAR_folder_id \
		-e TF_VAR_billing_account \
		-v $(CURDIR):/workspace \
		$(REGISTRY_URL)/${DOCKER_IMAGE_DEVELOPER_TOOLS}:${DOCKER_TAG_VERSION_DEVELOPER_TOOLS} \
		/usr/local/bin/execute_with_credentials.sh prepare_environment

# Clean up test environment within the docker container
.PHONY: docker_test_cleanup
docker_test_cleanup:
	docker run --rm -it \
		-e SERVICE_ACCOUNT_JSON \
		-e TF_VAR_org_id \
		-e TF_VAR_folder_id \
		-e TF_VAR_billing_account \
		-v $(CURDIR):/workspace \
		$(REGISTRY_URL)/${DOCKER_IMAGE_DEVELOPER_TOOLS}:${DOCKER_TAG_VERSION_DEVELOPER_TOOLS} \
		/usr/local/bin/execute_with_credentials.sh cleanup_environment

# Execute integration tests within the docker container
.PHONY: docker_test_integration
docker_test_integration:
	docker run --rm -it \
		-e SERVICE_ACCOUNT_JSON \
		-v $(CURDIR):/workspace \
		$(REGISTRY_URL)/${DOCKER_IMAGE_DEVELOPER_TOOLS}:${DOCKER_TAG_VERSION_DEVELOPER_TOOLS} \
		cft test run all

# Execute lint tests within the docker container
.PHONY: docker_test_lint
docker_test_lint:
	docker run --rm -it \
	    -e ENABLE_BPMETADATA \
		-v $(CURDIR):/workspace \
		$(REGISTRY_URL)/${DOCKER_IMAGE_DEVELOPER_TOOLS}:${DOCKER_TAG_VERSION_DEVELOPER_TOOLS} \
		/usr/local/bin/test_lint.sh

# Execute lint tests in github actions
.PHONY: docker_test_lint_gha
docker_test_lint_gha:
	docker run --rm \
		-v $(CURDIR):/workspace \
		$(REGISTRY_URL)/${DOCKER_IMAGE_DEVELOPER_TOOLS}:${DOCKER_TAG_VERSION_DEVELOPER_TOOLS} \
		/usr/local/bin/test_lint.sh --markdown --contrib-guide=../blob/master/CONTRIBUTING.md


# Generate documentation
.PHONY: docker_generate_docs
docker_generate_docs:
	docker run --rm -it \
	    -e ENABLE_BPMETADATA \
		-v $(CURDIR):/workspace \
		$(REGISTRY_URL)/${DOCKER_IMAGE_DEVELOPER_TOOLS}:${DOCKER_TAG_VERSION_DEVELOPER_TOOLS} \
		/bin/bash -c 'source /usr/local/bin/task_helper_functions.sh && generate_docs --per-module-requirements'

# Alias for backwards compatibility
.PHONY: generate_docs
generate_docs: docker_generate_docs
