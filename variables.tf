variable "project" {
  description = "Short project identifier used in resource names and tags."
  type        = string
  default     = "vics"

  validation {
    condition     = can(regex("^[a-z0-9]{2,12}$", var.project))
    error_message = "project must be 2-12 lowercase letters or digits."
  }
}

variable "environment" {
  description = "Environment name used in resource names and tags."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be one of: dev, test, prod."
  }
}

variable "location" {
  description = "Azure region for the resources."
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Additional tags to apply to supported resources."
  type        = map(string)
  default     = {}
}

variable "admin_source_cidr" {
  description = "Public IP CIDR allowed to connect to SSH on port 22."
  type        = string

  validation {
    condition     = can(cidrhost(var.admin_source_cidr, 0))
    error_message = "admin_source_cidr must be a valid IP CIDR."
  }
}
