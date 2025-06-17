control "gsutil" do
 <..>

# CODELAB: Copy paste the below test in gsutil.rb to test silly_label feature.

# command to get the labels for bucket_1
describe command("gsutil label get gs://#{attribute("names_list")[0]}") do
   //check if the command gave a valid response
   its(:exit_status) { should eq 0 }
   its(:stderr) { should eq "" }

   //parse the command's output into JSON
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
