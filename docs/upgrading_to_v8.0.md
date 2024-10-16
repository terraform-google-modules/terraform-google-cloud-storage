# Upgrading to v8.0

The v8.0 release of the terraform-google-cloud-storage module is a backwards incompatible release, due to the following breaking change:

- The fix for the issue [Error when using simple bucket with kms created in the same configuration](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/339) in the [Simple Bucket](../modules/simple_bucket/README.md) module replaced the creation of an internal KMS key based in the variable `encryption.default_kms_key_name` having a `null` value with an explicit control flag `internal_encryption_config.create_encryption_key`.

## Migration Instructions

To migrate from 5.x or 6.0.0 no change is necessary for the Simple Bucket module.

To migrate from 6.1.0 or 7.x:

- If the feature to auto create KMS keys was not used no change is necessary for the Simple Bucket module
- If the feature to auto create KMS keys was used, a migration from 7.x to 8.x for the Simple Bucket module as showcased below

```diff
module "simple_bucket" {
   source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
-  version = "~> 7.0"
+  version = "~> 8.0"
```

will produce the following output during a `terraform plan`:

```

Error: Missing required argument

  with module.simple_bucket.google_storage_bucket.bucket,
  on .terraform/modules/simple_bucket/main.tf line 22, in resource "google_storage_bucket" "bucket":
  22: resource "google_storage_bucket" "bucket" {

The argument "encryption.0.default_kms_key_name" is required, but no definition was found.
```

Removing the `null` valued `encryption.default_kms_key_name`

```diff
- -encryption = {
-    default_kms_key_name = null
-  }
```

will produce the following output during a `terraform plan`:

```
  # module.simple_bucket.google_storage_bucket.bucket will be updated in-place

  # module.simple_bucket.module.encryption_key[0].google_kms_crypto_key.key_ephemeral[0] will be destroyed
  # (because module.simple_bucket.module.encryption_key[0] is not in configuration)

  # module.simple_bucket.module.encryption_key[0].google_kms_crypto_key_iam_binding.decrypters[0] will be destroyed
  # (because module.simple_bucket.module.encryption_key[0] is not in configuration)

  # module.simple_bucket.module.encryption_key[0].google_kms_crypto_key_iam_binding.encrypters[0] will be destroyed
  # (because module.simple_bucket.module.encryption_key[0] is not in configuration)

  # module.simple_bucket.module.encryption_key[0].google_kms_key_ring.key_ring will be destroyed
  # (because module.simple_bucket.module.encryption_key[0] is not in configuration)

Plan: 0 to add, 1 to change, 4 to destroy.
```

To preserve the existing KMS Key, add the following section to your configuration

```diff
+  internal_encryption_config = {
+    create_encryption_key = true
+  }
```

Re-running the plan should show that the Simple Bucket resource is no longer showing a diff.

```
No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
```
