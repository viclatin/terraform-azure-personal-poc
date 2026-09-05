# Ansible mapping: this is the playbook body -- the desired state itself.
# Terraform works out the ordering from the references between resources,
# so there is no explicit task list to sequence by hand.

locals {
  name_prefix = "${var.project}-${var.environment}"

  common_tags = merge(
    {
      project     = var.project
      environment = var.environment
      managed_by  = "terraform"
      workspace   = terraform.workspace
    },
    var.tags,
  )
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${local.name_prefix}"
  location = var.location
  tags     = local.common_tags
}
