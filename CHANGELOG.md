# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [10.0.2](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v10.0.1...v10.0.2) (2025-05-19)


### Bug Fixes

* Making retention_policy is_locked as optional field ([#394](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/394)) ([e823780](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/e823780aac5d8c7268f7e930f59d76798485c6e0))

## [10.0.1](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v10.0.0...v10.0.1) (2025-03-18)


### Bug Fixes

* Update apphub service_uri to be available after apply ([#390](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/390)) ([66e472b](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/66e472b56cd21b45a3939883a66ccfcf5ec1b9ed))

## [10.0.0](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v9.1.0...v10.0.0) (2025-03-14)


### ⚠ BREAKING CHANGES

* **deps:** Update Terraform terraform-google-modules/kms/google to v4 ([#384](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/384))
* add concrete variable types ([#387](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/387))
* added concrete types for simple sa variables ([#386](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/386))

### Bug Fixes

* add concrete variable types ([#387](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/387)) ([1fa5c70](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/1fa5c7017201fa645c630a53a58bed4925e42c6b))
* added concrete types for simple sa variables ([#386](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/386)) ([534a547](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/534a547ead0308d39c12d023f19dc541ae1470c7))
* **deps:** Update Terraform terraform-google-modules/kms/google to v4 ([#384](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/384)) ([d9ca2c4](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/d9ca2c4433cda865b090bbbd5f3a1ae3f5514c41))

## [9.1.0](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v9.0.2...v9.1.0) (2025-02-13)


### Features

* add output required for apphub registration for simple_bucket module ([#383](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/383)) ([fbc43db](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/fbc43db125c5096f741acfc300f4d9a774d6e3bf))

## [9.0.2](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v9.0.1...v9.0.2) (2025-01-29)


### Bug Fixes

* update description for encryption input variable of simple-bucket ([#380](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/380)) ([31dd911](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/31dd911ccb7b590af834166195c61690653037ac))

## [9.0.1](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v9.0.0...v9.0.1) (2025-01-16)


### Bug Fixes

* update display metadata ([#377](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/377)) ([684b909](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/684b90921cc2261c8181557cd7c3c324c94ba04c))

## [9.0.0](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v8.0.3...v9.0.0) (2024-12-13)


### ⚠ BREAKING CHANGES

* remove apphub_service_uri from output of simple_bucket ([#372](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/372))

### Bug Fixes

* remove apphub_service_uri from output of simple_bucket ([#372](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/372)) ([7459e41](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/7459e41091602c41c486681e148b8ca7c4dc15c0))

## [8.0.3](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v8.0.2...v8.0.3) (2024-12-01)


### Bug Fixes

* add output type for internal_kms_configuration ([#370](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/370)) ([ddc3ab0](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/ddc3ab0822d4c42de8041ba29d200d55964e0c26))

## [8.0.2](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v8.0.1...v8.0.2) (2024-11-27)


### Bug Fixes

* Update variable's order in variables.tf and update display metad… ([#368](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/368)) ([29eb7e2](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/29eb7e2cd361076f17c9c565be74cb8ebd2fd6df))

## [8.0.1](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v8.0.0...v8.0.1) (2024-10-28)


### Bug Fixes

* Fix apphub uri and id representation ([#360](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/360)) ([2782340](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/2782340b070823f8cc684bb81184f3cb9d4c97c3))

## [8.0.0](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v7.0.0...v8.0.0) (2024-10-17)


### ⚠ BREAKING CHANGES

* fix count invalid argument on simple bucket ([#355](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/355))

### Features

* Add Apphub URI output to cloud storage ([#358](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/358)) ([209d5e3](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/209d5e3ec29580fd6c0f3eecab5f5b020159605a))


### Bug Fixes

* fix count invalid argument on simple bucket ([#355](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/355)) ([8fe9a7e](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/8fe9a7e1ce9dc8d068b4bc1f36c53281e18090b8))

## [7.0.0](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v6.1.0...v7.0.0) (2024-10-14)


### ⚠ BREAKING CHANGES

* **deps:** Update Terraform terraform-google-modules/kms/google to v3 ([#343](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/343))
* **TPG>=5.43:** replacing "no_age" -> "send_age_if_zero" ([#340](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/340))

### Bug Fixes

* **deps:** Update Terraform terraform-google-modules/kms/google to v3 ([#343](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/343)) ([e8bb6eb](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/e8bb6eb49fdaf5f6f300d1b6dc46f097173dc488))
* **TPG>=5.43:** replacing "no_age" -&gt; "send_age_if_zero" ([#340](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/340)) ([f40bf31](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/f40bf318a55aa12d467cebac8706f774481958ac))
* use null as default for lookup ([#332](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/332)) ([6c14d5e](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/6c14d5e50e2f29f21af870785eb89a862724d067))

## [6.1.0](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v6.0.1...v6.1.0) (2024-08-29)


### Features

* **deps:** Update Terraform google to v6 ([#336](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/336)) ([2fa380d](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/2fa380d0a15f7daf776bb80019a11594aed5a5bf))
* Encrypt bucket with CMEK ([#325](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/325)) ([07e3a4e](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/07e3a4e2b34dc4c7a2a99ae5e6893a3670251870))

## [6.0.1](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v6.0.0...v6.0.1) (2024-07-03)


### Bug Fixes

* adding "no_age" param in simple bucket ([#319](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/319)) ([87e66bb](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/87e66bb7af2f88e29db6a9fe1eda9bf53fe119bb))
* lookup default value for soft delete policy  ([#318](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/318)) ([aa7c57e](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/aa7c57e92e691a22433092bceea9de879f66d7ab))

## [6.0.0](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v5.0.0...v6.0.0) (2024-05-03)


### ⚠ BREAKING CHANGES

* soft-delete configuration ([#309](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/309))

### Features

* soft-delete configuration ([#309](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/309)) ([1be844a](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/1be844a778afe5a060ba1a686ab1187396e8e267))

## [5.0.0](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v4.0.1...v5.0.0) (2023-10-17)


### ⚠ BREAKING CHANGES

* **TPG >= 4.46:** adds support to autoclass ([#265](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/265))

### Features

* **TPG >= 4.46:** adds support to autoclass ([#265](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/265)) ([52eaa5a](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/52eaa5ae08e419340933b9b8c78e0d249d9e72bd))


### Bug Fixes

* upgraded versions.tf to include minor bumps from tpg v5 ([#276](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/276)) ([b94c2f9](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/b94c2f9fa00f21e6a329ce221a1282ce4455c1b8))

## [4.0.1](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v4.0.0...v4.0.1) (2023-08-03)


### Bug Fixes

* create random suffix resource on demand ([#185](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/185)) ([5050c91](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/5050c91efee42e94bac886f0d86ee7a76cc42058))
* lifecycle_rule optional condition is_live failing when missing ([#246](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/246)) ([c8111a4](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/c8111a4fc877d1af2785820c31c8c02a22a43206))

## [4.0.0](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v3.4.1...v4.0.0) (2023-04-06)


### ⚠ BREAKING CHANGES

* add support for custom_placement_config ([#231](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/231))
* **TPG >= 4.42:** add support for public_access_prevention ([#218](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/218))
* location inverse control in bucket name prefix ([#186](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/186))
* Add matches_prefix and matches_suffix conditions ([#202](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/202))

### Features

* Add matches_prefix and matches_suffix conditions ([#202](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/202)) ([8db2eb3](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/8db2eb352c3998b4981553e2bdeb72c2c7c34f5b))
* add support for custom_placement_config ([#231](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/231)) ([a0bbdbd](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/a0bbdbdbafa4732c8b3aa1a7760216fd48df43f3))
* Hmac access ([#181](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/181)) ([e5e4909](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/e5e49094165ce876479f6a852889b17726807caa))
* location inverse control in bucket name prefix ([#186](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/186)) ([dbd3c35](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/dbd3c3528332fc84bc599348279eaf501826a0f0))
* **TPG >= 4.42:** add support for public_access_prevention ([#218](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/218)) ([4469954](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/4469954690e29f8145d185ecb7ec345cd9f9abab))

## [3.4.1](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v3.4.0...v3.4.1) (2023-01-04)


### Bug Fixes

* fixes lint issues and generates metadata ([#207](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/207)) ([f038511](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/f038511fc58371f51255cc8921d31b0da82094f5))
* relax random provider version ([#212](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/212)) ([2d7da45](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/2d7da4521ea639977d177f6fd5f4f51444a09543))

## [3.4.0](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v3.3.0...v3.4.0) (2022-09-12)


### Features

* Add var to define different lifecycle rules for each bucket ([#169](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/169)) ([4793dd2](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/4793dd22f0fa75ff5f27221971ee2af7317d805e))

## [3.3.0](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v3.2.0...v3.3.0) (2022-07-15)


### Features

* add name and url outputs on simple_bucket module ([#175](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/175)) ([d76ffa3](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/d76ffa3f2f147042527d98333397355a387d6701))
* Add option to enable default_event_based_hold argument ([#178](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/178)) ([2ab4888](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/2ab4888d135014b4c74c296da7e2e381aa58f766))

## [3.2.0](https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v3.1.0...v3.2.0) (2022-03-04)


### Features

* add support for website configuration to simple_bucket submodule ([#150](https://github.com/terraform-google-modules/terraform-google-cloud-storage/issues/150)) ([839a18c](https://github.com/terraform-google-modules/terraform-google-cloud-storage/commit/839a18c4de5d7c00c74a54dfde51280862f4e8b5))

## [3.1.0](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v3.0.0...v3.1.0) (2021-11-18)


### Features

* Add missing lifecycle rules conditions simple_bucket ([#145](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/145)) ([bbb681d](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/bbb681d2335462c8e5a1234910d509782a06732b)), closes [#144](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/144)
* update TPG version constraints to allow 4.0 ([#143](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/143)) ([2e4c375](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/2e4c375bd2ea05ef9a4ff8fc44055ccf4bb1420a))

## [3.0.0](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v2.2.0...v3.0.0) (2021-09-27)


### ⚠ BREAKING CHANGES

* The default storage class has been changed from `MULTI_REGIONAL` to `STANDARD`. This new default is [recommended](https://cloud.google.com/storage/docs/storage-classes#standard) and can be used for multi-regional storage.

### Features

* add additional lifecycle conditions: custom_time_before, days_since_noncurrent_time, noncurrent_time_before ([#135](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/135)) ([bd1d1e7](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/bd1d1e7bae83e9cc1d64019f06d2ca1b9d50a67f))


### Bug Fixes

* Change default storage class to `STANDARD` ([#137](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/137)) ([af10280](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/af10280a5055dcf8823a4fe09052e94a97eb0688))

## [2.2.0](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v2.1.0...v2.2.0) (2021-09-17)


### Features

* Add ability to append a randomized suffix to all bucket names ([#130](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/130)) ([93ff75f](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/93ff75fb291c998c7d495c55342aea3b461fcc1a))
* Add support for retention policy ([#127](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/127)) ([a0982c9](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/a0982c94f92df37d903af0a85e7ee5fe1e655d1e))
* Support for CORS in simple bucket ([#128](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/128)) ([e6559e9](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/e6559e9f4721d5b67eec1644ebbefac852cf55e8))


### Bug Fixes

* Correct behavior of website and cors variables. ([#132](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/132)) ([3e6e7f4](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/3e6e7f405dc4d3698f1dabfd23440d67908f2e2f))

## [2.1.0](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v2.0.0...v2.1.0) (2021-06-15)


### Features

* add support for days_since_custom_time ([#120](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/120)) ([0247454](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/02474541f50146ae8dff3aa146ff6f8f278e041c))
* Add support for log bucket configuration ([#117](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/117)) ([eca9c57](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/eca9c57551e48e4fff635df8c59d2797b78c6652))

## [2.0.0](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v1.7.1...v2.0.0) (2021-05-17)


### ⚠ BREAKING CHANGES

* Added Terraform 0.13 constraint and module attribution (#105)
* The resource state locations have changed to use for_each, please see the [upgrade guide](https://github.com/terraform-google-modules/terraform-google-cloud-storage/blob/master/docs/upgrading_to_v2.0.md) for details.

### Features

* add Terraform 0.13 constraint and module attribution ([#105](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/105)) ([b33d674](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/b33d67417d2e4309e9774811e0e14c612c300f6c))
* Allow setting storage.admin and storage.hmacKeyAdmin roles ([#95](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/95)) ([9f6085e](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/9f6085e671eea558585f4c5027bd94f1bcdd4a11))
* Use for_each instead of count to create resource ([#86](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/86)) ([af73533](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/af735332c091c6fe5de082562c8d59f979421611))


### Bug Fixes

* Fix deprecation of is_live lifecycle rule ([#91](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/91)) ([f73041b](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/f73041b904d8f5c7020efb84737d54869e394738))
* Remove deprecated list() function usage ([#107](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/107)) ([1fe315a](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/1fe315a8ab722d7f91b60e1c209bf938724eb371))
* Use correct IAM view role in example ([#115](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/115)) ([4a9931d](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/4a9931dc339216fc5edb815c681168fd7063424c))

### [1.7.2](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v1.7.1...v1.7.2) (2020-09-30)

### Bug Fixes

* Fix deprecation of is_live lifecycle rule ([#91](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/91)) ([f73041b](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/f73041b904d8f5c7020efb84737d54869e394738))

### [1.7.1](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v1.7.0...v1.7.1) (2020-09-21)


### Bug Fixes

* Constrain minimum Google provider version to 3.38 ([#84](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/84)) ([ebc1916](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/ebc19161e2b9c24ef41c2c5898b2d65eae81ee1e))

## [1.7.0](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v1.6.0...v1.7.0) (2020-09-16)

### ⚠ BREAKING CHANGES

* Minimum Google provider version increased to [3.38.0](https://github.com/hashicorp/terraform-provider-google/blob/master/CHANGELOG.md#3380-september-08-2020)


### Features

* Add is_live field to simple_bucket lifecycle ([#76](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/76)) ([a16305d](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/a16305dfad12ef06881a73a6c2a33fe7fe569bfb))


### Bug Fixes

* Use uniform_bucket_level_access flag instead due to deprecation ([#80](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/80)) ([f287581](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/f287581701bdcb0af996a26a8b922788cf686f57))



## [1.6.0](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v1.5.0...v1.6.0) (2020-05-26)


### Features

* Add support for cors and website config in variables ([#63](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/63)) ([69dafb3](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/69dafb3b3c532013919f4da416fa72aa009621a3))
* Add support for creating folders in buckets with folders variable ([#59](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/59)) ([0fa0689](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/0fa068980e4d01b66f5f0f2d923f6fae730b1151))


### Bug Fixes

* convert lifecycle action object to map ([#52](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/52)) ([f2e6ea3](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/f2e6ea3e1954c8311ff326d7c512756db1dd5ae9))

## [1.5.0](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v1.4.0...v1.5.0) (2020-04-22)


### Features

* add support for lifecycle rules in simple bucket ([#49](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/49)) ([b39e2cd](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/b39e2cdf0848b59d00dd7fe65c917a5bf4a1176a))

## [1.4.0](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v1.3.0...v1.4.0) (2020-03-04)


### Features

* add outputs for simple bucket module ([#38](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/38)) ([f93bf5d](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/f93bf5d88842018f8421be61af5a0f4afd947487))


### Bug Fixes

* Adding type constraints to variables ([#43](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/43)) ([45d42a1](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/45d42a1d7f73f8c4ad77d1455de77ce88ab0e8ad))

## [1.3.0](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v1.2.0...v1.3.0) (2020-02-13)


### Features

* Add simple bucket submodule ([#35](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/35)) ([e75114a](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/e75114a5770d8aab65764d4c04a36c52bde4f073))
* Add support for customer encryption keys ([#34](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/34)) ([32eff9b](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/32eff9b9330e6c9bb683cfd75d0baf9d9798b7eb))
* replace dot on a dash in label value ([#31](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/issues/31)) ([8875ebb](https://www.github.com/terraform-google-modules/terraform-google-cloud-storage/commit/8875ebbc645e1a6196c61a9f4d0cfaf3fa0f6569))

## [Unreleased]

## [1.2.0] - 2019-12-06

### Added

- Added support for setting lifecycle rules [#19](https://github.com/terraform-google-modules/terraform-google-cloud-storage/pull/19)

## [1.1.0] - 2019-11-20

### Added

- Include name of bucket as label for cost analysis [#20]

### Fixed

- Error from the `names` and `urls` outputs caused by removing elements from the `names` variable. [#23]

## [1.0.0] - 2019-08-14

### Changed

- Upgraded for usage with terraform-0.12.x [#9]
- Added support for `force_destroy` attribute [#9]

## [0.1.0] - 2019-05-22

### Added

- Initial release

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v1.2.0...HEAD
[1.2.0]: https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/terraform-google-modules/terraform-google-cloud-storage/compare/v0.1.0...v1.0.0
[0.1.0]: https://github.com/terraform-google-modules/terraform-google-cloud-storage/releases/tag/v0.1.0

[#23]: https://github.com/terraform-google-modules/terraform-google-cloud-storage/pull/23
[#20]: https://github.com/terraform-google-modules/terraform-google-cloud-storage/pull/20
[#9]: https://github.com/terraform-google-modules/terraform-google-cloud-storage/pull/9
