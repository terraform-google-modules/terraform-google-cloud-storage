# Upgrading to v9.0

The v9.0 release contains backwards-incompatible changes.

## Replace uses of apphub_service_uri

This release removes apphub_service_uri output. You can replace use of `apphub_service_uri` by forming the desired output as below,

```
{
    service_uri = "//storage.googleapis.com/${module.simple_bucket.name}"
    service_id  = substr(module.simple_bucket.name, 0, 63)
  }
```
