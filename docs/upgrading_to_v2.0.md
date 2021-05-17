# Upgrading to v2.0

The v2.0 release of the terraform-google-cloud-storage module is a backwards incompatible release, due to the following breaking changes:

- The module now uses for_each instead of count.
- The minimum Terraform version was increased to 0.13.

## Migration Instructions

A migration from 1.x to 2.x as showcased below

```diff
module "cloud_storage" {
   source  = "terraform-google-modules/cloud-storage/google"
-  version = "1.7.2"
+  version = "~> 2.0"
```
will produce the following output during a `terraform plan`:

```bash
module.cloud_storage.google_storage_bucket.buckets will be destroyed
module.cloud_storage.google_storage_bucket.buckets[1] will be destroyed
  .
  .
module.cloud_storage.google_storage_bucket.buckets["one"]
module.cloud_storage.google_storage_bucket.buckets["two"]
  .
  .
Plan: 2 to add, 0 to change, 2 to destroy.
```

To prevent bucket recreation, it is recommended to migrate the state locations using commands like this:

```shell
terraform state mv module.cloud_storage.google_storage_bucket.buckets[0] 'module.cloud_storage.google_storage_bucket.buckets["one"]'
terraform state mv module.cloud_storage.google_storage_bucket.buckets[1] 'module.cloud_storage.google_storage_bucket.buckets["two"]'
```

Re-running the plan should show that the storage bucket resources are no longer showing a diff.

```
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```
