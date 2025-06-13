terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "remote" {
    organization = "your-tfc-org-name"

    workspaces {
      name = "your-workspace-name"
    }
  }
}
