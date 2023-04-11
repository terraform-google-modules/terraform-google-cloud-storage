# Upgrading to v4.0

The v4.0 release of the terraform-google-cloud-storage module is a backwards incompatible release, due to the following breaking changes:

- The bucket doesn't have location as mandatory part of the name prefix.
- The minimum Terraform Google Provider version was increased to 4.42.

## Migration Instructions

A migration from 3.x to 4.x as showcased below

```diff
module "cloud_storage" {
   source  = "terraform-google-modules/cloud-storage/google"
-  version = "~> 3.0"
+  version = "~> 4.0"
```
will produce the following output during a `terraform plan`:

```bash
# module.cloud_storage.google_storage_bucket.buckets["one"] must be replaced
...
~ name = "multiple-buckets-iost-eu-one" -> "multiple-buckets-iost-one" # forces replacement
...
# module.cloud_storage.google_storage_bucket.buckets["two"] must be replaced
...
~ name = "multiple-buckets-iost-eu-two" -> "multiple-buckets-iost-two" # forces replacement
...
Plan: 2 to add, 0 to change, 2 to destroy.
```

In the module bucket prefix contained `location` before. To preserve the same bucket name with `location` in prefix you should make some code adjustments:

```diff
- prefix = "multiple-buckets-${random_string.prefix.result}"
+ prefix = "multiple-buckets-${random_string.prefix.result}-eu"
```

Re-running the plan should show that the storage bucket resources are no longer showing a diff.

```
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```
