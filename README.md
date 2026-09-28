# terraform-azure-personal-poc

Terraform Azure personal proof-of-concept project to learn infrastructure automation for:

- Azure cloud resources
- ServiceNow integration workflows
- HCP Terraform automation pipelines

## Goal

Build practical Terraform knowledge with Ansible-oriented explanations so a network engineer can quickly map familiar concepts to Terraform patterns.

## Repository layout

```
main.tf       Azure resources
variables.tf  configuration inputs
providers.tf  Azure provider setup
versions.tf   Terraform, provider, and HCP Terraform settings
outputs.tf    values returned after apply
```

This starts with one root module at the repository root. Resources are declared
directly here; reusable child modules can be introduced later when they are
useful.

## Getting started

Set the HCP Terraform workspace working directory to the repository root. Add
`admin_source_cidr` as a Terraform workspace variable with your public IP in
CIDR form, and `admin_ssh_public_key` with your SSH public key. Set Azure
credentials on the workspace as sensitive environment variables.

HCP Terraform will run a plan when changes are pushed. Review the plan before
approving an apply.
