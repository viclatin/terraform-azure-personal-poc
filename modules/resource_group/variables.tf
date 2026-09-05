# Ansible mapping: these are a role's defaults/main.yml plus argument_specs --
# the contract a caller has to satisfy. Inputs without a default are required.

variable "name" {
  description = "Name of the resource group to create."
  type        = string
}

variable "location" {
  description = "Azure region the resource group lives in."
  type        = string
}

variable "tags" {
  description = "Tags applied to the resource group."
  type        = map(string)
  default     = {}
}
