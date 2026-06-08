terraform {
  required_version = ">= 1.9.0"

  cloud {
    # Replace with your Terraform Cloud organization and workspace names.
    #
    # VCS-driven workflow (recommended):
    #   - Plans trigger automatically on pushes to the configured branch.
    #   - Applies trigger on merge to the main/default branch (or manually in TFC UI).
    #   - Run `terraform login` + `terraform init` locally only for speculative plans
    #     and to ensure the lock file is up to date.
    #   - Never run `terraform apply` locally in VCS-driven mode.
    #
    # See setup steps in the project README or plan doc.
    organization = "<your-tfc-org>"

    workspaces {
      name = "<your-workspace-name>"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.50.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

module "managed_redis" {
  source = "../.."

  name                = var.name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku_name            = var.sku_name
  tags                = var.tags
}
