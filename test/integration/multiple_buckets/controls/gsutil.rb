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

require 'json'

control "gsutil" do
  title "gsutil"

  describe command("gsutil ls -p #{attribute("project_id")}") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should include attribute('names').values[0] }
    its(:stdout) { should include attribute('names').values[1] }
  end

  describe command("gsutil ls gs://#{attribute("names_list")[1]}") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should include "gs://#{attribute("names_list")[1]}/dev/" }
    its(:stdout) { should include "gs://#{attribute("names_list")[1]}/prod/" }
  end

  describe command("gsutil bucketpolicyonly get gs://#{attribute("names_list")[0]}") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should include "Enabled: True" }
  end

  describe command("gsutil bucketpolicyonly get gs://#{attribute("names_list")[1]}") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    its(:stdout) { should include "Enabled: False" }
  end

  get_lifecycle_0_out = command("gsutil lifecycle get gs://#{attribute("names_list")[0]}")
  rule = JSON.parse(get_lifecycle_0_out.stdout)['rule'][0]

  describe get_lifecycle_0_out do
    let(:action) { rule['action'] }
    let(:condition) { rule['condition'] }

    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    it { expect(action['storageClass']).to eq("NEARLINE") }
    it { expect(action['type']).to eq("SetStorageClass") }
    it { expect(condition['age']).to eq(10) }
    it { expect(condition['isLive']).to eq(false) }
    it { expect(condition['matchesStorageClass']).to eq(%w(MULTI_REGIONAL STANDARD DURABLE_REDUCED_AVAILABILITY)) }
  end

  get_lifecycle_1_out = command("gsutil lifecycle get gs://#{attribute("names_list")[1]}")
  rule_1 = JSON.parse(get_lifecycle_1_out.stdout)['rule'][0]

  describe command("gsutil lifecycle get gs://#{attribute("names_list")[1]}") do
    let(:action) { rule_1['action'] }
    let(:condition) { rule_1['condition'] }

    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
    it { expect(action['storageClass']).to eq("NEARLINE") }
    it { expect(action['type']).to eq("SetStorageClass") }
    it { expect(condition['age']).to eq(10) }
    it { expect(condition['isLive']).to eq(false) }
    it { expect(condition['matchesStorageClass']).to eq(%w(MULTI_REGIONAL STANDARD DURABLE_REDUCED_AVAILABILITY)) }
  end

  # CODELAB: Copy paste the below test in gsutil.rb to test silly_label feature.
  # command to get the labels for bucket_1
  describe command("gsutil label get gs://#{attribute("names_list")[0]}") do
    # check if the command gave a valid response
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }

    # parse the command's output into JSON
    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

    # check if bucket_1 has the new "silly" label with the value "awesome"
    describe "bucket_1" do
      it "has label" do
        data.each do |bucket|
          expect(data["silly"]).to include("awesome")
        end
      end
    end
  end

end
