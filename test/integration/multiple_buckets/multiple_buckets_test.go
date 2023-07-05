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
	"time"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/utils"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Retry if these errors are encountered.
var retryErrors = map[string]string{
	// https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/204
	".*Provider produced inconsistent final plan.*": "Provider bug, retry",
}

func TestMultipleBuckets(t *testing.T) {
	buckets := tft.NewTFBlueprintTest(t, tft.WithRetryableTerraformErrors(retryErrors, 5, time.Minute))

	buckets.DefineVerify(func(assert *assert.Assertions) {
		buckets.DefaultVerify(assert)

		projectID := buckets.GetStringOutput("project_id")
		names := terraform.OutputList(t, buckets.GetTFOptions(), "names_list")
		for _, fullBucketName := range names {
			// alpha command to list buckets has --json instead of format=json
			gcloudArgs := gcloud.WithCommonArgs([]string{"--project", projectID, "--json"})
			op := gcloud.Run(t, fmt.Sprintf("alpha storage ls --buckets gs://%s", fullBucketName), gcloudArgs).Array()[0]

			// verify lifecycle rules
			lifecycle := op.Get("metadata.lifecycle.rule").Array()[0]
			assert.Equal("NEARLINE", lifecycle.Get("action.storageClass").String(), "lifecycle action sets NEARLINE storageClass")
			assert.Equal("SetStorageClass", lifecycle.Get("action.type").String(), "lifecycle action is SetStorageClass")
			assert.Equal("10", lifecycle.Get("condition.age").String(), "lifecycle condition is age 10")
			assert.ElementsMatch([]string{"MULTI_REGIONAL", "STANDARD", "DURABLE_REDUCED_AVAILABILITY"}, utils.GetResultStrSlice(lifecycle.Get("condition.matchesStorageClass").Array()), "lifecycle conditions match")

			// peel bucket name from prefix and randomized suffix
			parts := strings.Split(fullBucketName, "-")
			bucketName := parts[len(parts) - 2]

			switch bucketName {
			case "one":
				// bucket with suffix one
				assert.True(op.Get("metadata.iamConfiguration.bucketPolicyOnly.enabled").Bool(), "bucketPolicyOnly is enabled")
				assert.True(op.Get("metadata.defaultEventBasedHold").Bool(), "defaultEventBasedHold is enabled")
				bucket_lifecycle := op.Get("metadata.lifecycle.rule").Array()[1]
				assert.Equal("Delete", bucket_lifecycle.Get("action.type").String(), "bucket lifecycle action is Delete")
				assert.Equal("90", bucket_lifecycle.Get("condition.age").String(), "bucket lifecycle condition is age 90")
			case "two":
				// bucket with suffix two
				assert.False(op.Get("metadata.iamConfiguration.bucketPolicyOnly.enabled").Bool(), "bucketPolicyOnly is disabled")
				assert.False(op.Get("metadata.defaultEventBasedHold").Bool(), "defaultEventBasedHold is disabled")
				gcloud.Run(t, fmt.Sprintf("alpha storage ls --buckets gs://%s/dev/", fullBucketName), gcloudArgs)
				gcloud.Run(t, fmt.Sprintf("alpha storage ls --buckets gs://%s/prod/", fullBucketName), gcloudArgs)
				bucket_lifecycles := op.Get("metadata.lifecycle.rule").Array()
				assert.Equal(1, len(bucket_lifecycles), "Bucket 'two' has 1 lifecycle rule")
			default:
				// fail test if unknown suffix
				t.Fatalf("Only expected two buckets with suffixes one and two. Found: %s", fullBucketName)
			}
		}
	})
	buckets.Test()
}
