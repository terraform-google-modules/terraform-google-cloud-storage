# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
