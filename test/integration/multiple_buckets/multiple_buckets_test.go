// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package multiple_buckets

import (
	"fmt"
	"strings"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/utils"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestMultipleBuckets(t *testing.T) {
	buckets := tft.NewTFBlueprintTest(t)

	buckets.DefineVerify(func(assert *assert.Assertions) {
		buckets.DefaultVerify(assert)

		projectID := buckets.GetStringOutput("project_id")
		names := terraform.OutputList(t, buckets.GetTFOptions(), "names_list")
		for _, bucketName := range names {
			// alpha command to list buckets has --json instead of format=json
			gcloudArgs := gcloud.WithCommonArgs([]string{"--project", projectID, "--json"})
			op := gcloud.Run(t, fmt.Sprintf("alpha storage ls --buckets gs://%s", bucketName), gcloudArgs).Array()[0]

			// verify lifecycle rules
			lifecycle := op.Get("metadata.lifecycle.rule").Array()[0]
			assert.Equal("NEARLINE", lifecycle.Get("action.storageClass").String(), "lifecycle action sets NEARLINE storageClass")
			assert.Equal("SetStorageClass", lifecycle.Get("action.type").String(), "lifecycle action is SetStorageClass")
			assert.Equal("10", lifecycle.Get("condition.age").String(), "lifecycle condition is age 10")
			assert.ElementsMatch([]string{"MULTI_REGIONAL", "STANDARD", "DURABLE_REDUCED_AVAILABILITY"}, utils.GetResultStrSlice(lifecycle.Get("condition.matchesStorageClass").Array()), "lifecycle conditions match")

			bucketSuffix := bucketName[strings.LastIndex(bucketName, "-")+1:]
			switch bucketSuffix {
			case "one":
				// bucket with suffix one
				assert.True(op.Get("metadata.iamConfiguration.bucketPolicyOnly.enabled").Bool(), "bucketPolicyOnly is enabled")
			case "two":
				// bucket with suffix two
				assert.False(op.Get("metadata.iamConfiguration.bucketPolicyOnly.enabled").Bool(), "bucketPolicyOnly is disabled")
				gcloud.Run(t, fmt.Sprintf("alpha storage ls --buckets gs://%s/dev/", bucketName), gcloudArgs)
				gcloud.Run(t, fmt.Sprintf("alpha storage ls --buckets gs://%s/prod/", bucketName), gcloudArgs)
			default:
				// fail test if unknown suffix
				t.Fatalf("Only expected two buckets with suffixes one and two. Found: %s", bucketName)
			}
		}
	})
	buckets.Test()
}
