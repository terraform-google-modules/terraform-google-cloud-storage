# Contributing

This document provides guidelines for contributing to the module.

## Generating Documentation for Inputs and Outputs

The Inputs and Outputs tables in the READMEs of the root module,
submodules, and example modules are automatically generated based on
the `variables` and `outputs` of the respective modules. These tables
must be refreshed if the module interfaces are changed.

### Dependencies

The following dependencies must be installed on the development system:

- [make]
- [terraform-docs] v0.6.0

### Execution

Run `make generate_docs` to generate new Inputs and Outputs tables.

## Integration Testing

Integration tests are used to verify the behaviour of the root module,
submodules, and example modules. Additions, changes, and fixes should
be accompanied with tests.

The integration tests are run using [Kitchen][kitchen],
[Kitchen-Terraform][kitchen-terraform], and [InSpec][inspec]. These
tools are packaged within a Docker image for convenience.

The general strategy for these tests is to verify the behaviour of the
[example modules](./examples), thus ensuring that the root module,
submodules, and example modules are all functionally correct.

### Dependencies

The following dependencies must be installed on the development system:

- [Docker Engine][docker-engine]
- [Google Cloud SDK][google-cloud-sdk]
- [make]

### Inputs

Test instances are defined in the
[Kitchen configuration file](./kitchen.yml). The inputs of each Kitchen
instance may be configured with the `driver.variables` key in a
local Kitchen configuration file located at `./kitchen.local.yml` or in
a Terraform variables file located at
`./test/fixtures/<instance>/variables.tfvars`.

### Credentials

Download the key of a Service Account with the
[required roles][required-roles] to `./credentials.json`.

### Interactive Execution

1. Run `make docker_run` to start the testing Docker container in
   interactive mode.

1. Run `kitchen create <EXAMPLE_NAME>` to initialize the working
   directory for an example module.

1. Run `kitchen converge <EXAMPLE_NAME>` to apply the example module.

1. Run `kitchen verify <EXAMPLE_NAME>` to test the example module.

1. Run `kitchen destroy <EXAMPLE_NAME>` to destroy the example module
   state.

### Noninteractive Execution

Run `make test_integration_docker` to test all of the example modules
noninteractively.

## Linting and Formatting

Many of the files in the repository can be linted or formatted to
maintain a standard of quality.

### Dependencies

The following dependencies must be installed on the development system:

- [flake8]
- [gofmt]
- [hadolint]
- [make]
- [shellcheck]
- [Terraform][terraform] v0.11

### Execution

Run `make check`.

[docker-engine]: https://www.docker.com/products/docker-engine
[flake8]: http://flake8.pycqa.org/en/latest/
[gofmt]: https://golang.org/cmd/gofmt/
[google-cloud-sdk]: https://cloud.google.com/sdk/install
[hadolint]: https://github.com/hadolint/hadolint
[inspec]: https://inspec.io/
[kitchen-terraform]: https://github.com/newcontext-oss/kitchen-terraform
[kitchen]: https://kitchen.ci/
[make]: https://en.wikipedia.org/wiki/Make_(software)
[shellcheck]: https://www.shellcheck.net/
[terraform-docs]: https://github.com/segmentio/terraform-docs
[terraform]: https://terraform.io/
