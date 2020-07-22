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
    its(:stdout) { should include attribute('names_list')[0] }
  end

  get_bucket_0_cors = command("gsutil cors get gs://#{attribute("names_list")[0]}")
  describe get_bucket_0_cors do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }
  end

  describe command("gsutil iam get gs://#{attribute("names_list")[0]}") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq "" }

    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end

   describe "allUsers" do
     it "allUsers is roles/storage.legacyObjectReader" do
       expect(data['bindings']).to include(
         including(
           "members" => ["allUsers"],
           "role" => "roles/storage.legacyObjectReader"
         )
       )
     end
   end
  end

end
