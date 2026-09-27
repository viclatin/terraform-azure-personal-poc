# Terraform layout

This project starts with one root module at the repository root. Terraform
loads all `.tf` files in that directory together:

- `main.tf` declares the Azure resources.
- `variables.tf` defines configurable inputs.
- `providers.tf` configures the Azure provider.
- `versions.tf` pins Terraform and provider versions and connects HCP Terraform.
- `outputs.tf` exposes useful resource values.

The HCP Terraform workspace uses the repository root as its working directory.
Its state is separate from any other HCP workspace.

## Modules later

A child module is a reusable group of resources with declared inputs and
outputs. The root module can call one when the same resource pattern needs to
be reused or the configuration grows enough to benefit from separation. For a
first project, keeping resources in the root makes data flow and dependencies
easier to follow.
