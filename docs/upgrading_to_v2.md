# Migrating to v2.x of Google Cloud Storage

The v2.0 release of Project Factory is a backwards incompatible release and features major changes, specifically with multiple resources that are now handled via `for_each` instead of `count`.

A state migration script is provided to update your existing states to minimize or eliminate resource re-creations. Note that upgrading requires you to have Python 3.x installed.

## Migration Instructions

This migration was performed with the following example configuration.

```hcl
module "gcs-tf-environments" {
  source     = "terraform-google-modules/cloud-storage/google"
  version    = "1.0.0"
  project_id      = module.project-tf.project_id
  prefix          = "${var.prefix}-tf"
  names           = var.environments
  location        = var.gcs_location
  set_admin_roles = true
  bucket_admins = zipmap(
    var.environments,
    module.service-accounts-tf-environments.iam_emails_list
  )
}
```

### Pull state

Ensure no changes are pending by running `terraform apply`, then pull and store the state file locally:

```shell
terraform state pull > state-original.json
```

### Update module version

Update the module version. Using our example above:

```hcl
module "gcs-tf-environments" {
  source     = "terraform-google-modules/cloud-storage/google"
  version    = "2.0.0"
```

The run `terraform init` to update the module.

### Define script parameters

You will need to pass the module name and `names` variable contents to the script. The module name depends on where you call the module (in the root module, or as a submodule from another module). A quick way to check the exact name you need to pass to the script is by checking state:

```shell
terraform state show |grep gcs-tf-environments
```

The output will list all module resources:

```shell
module.gcs-tf-environments.google_storage_bucket.buckets[0]
module.gcs-tf-environments.google_storage_bucket.buckets[1]
module.gcs-tf-environments.google_storage_bucket_iam_binding.admins[0]
module.gcs-tf-environments.google_storage_bucket_iam_binding.admins[1]
```

Use the full prefix from the output, `module.gcs-tf-environments` in the example above.

The last bit you need is the value passed in to the module's `names` variable, which in our example comes from a `terraform.tfvars` file:

```hcl
environments       = ["test", "dev"]
```

The order of names matters and should match the order in the module's `name` input variable. Our script arguments will be:

```shell
-m module.gcs-tf-environments -n test -n dev
```

### Download and run the script to modify state

Download the script.

```shell
wget https://raw.githubusercontent.com/terraform-google-modules/terraform-google-cloud-storage/master/docs/scripts/migrate-v2.py
chmod 755 migrate-v2.py
```

Run the script a first time to check that the replacements are correct.

```shell
cat state-orig.json | ./migrate-v2.py \
  -m module.gcs-tf-environments -n test -n dev
```

Assuming the arguments are correct, this will output a table listing the resources that will be changed, and the origin and replacement keys.

```shell
State changes:

module                     type                              name     old indexes new indexes
-------------------------- --------------------------------- -------- ----------- -----------
module.gcs-tf-environments google_storage_bucket             buckets  [0, 1]      ['test', 'dev']
module.gcs-tf-environments google_storage_bucket_iam_binding admins   [0, 1]      ['test', 'dev']
module.gcs-tf-environments google_storage_bucket_iam_binding creators []          []
module.gcs-tf-environments google_storage_bucket_iam_binding viewers  []          []

Re-run with --apply-changes to output modified state file.
```

If the output looks correct, run the script again adding the `--apply-changes` argument, and store the output in a new file.

```shell
cat state-orig.json | ./migrate-v2.py \
  -m module.gcs-tf-environments -n test -n dev --apply-changes >state-new.json
```

### Push the new state

Once done, push the new state:

```shell
terraform state push state-new.json
```

Then review current state by running a plan. If you run into issues, you can revert code to the old module version, and push the original state file after changing its `serial` attribute to be greater than the current state. You can check the current serial with:

```shell
terraform state pull |grep '"serial": '
```

`