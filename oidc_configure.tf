terraform {
  required_providers {
    cloudsmith = {
      source  = "cloudsmith-io/cloudsmith"
      version = "0.0.68"
    }
  }
}

# Configure the Cloudsmith Provider
provider "cloudsmith" {
  api_key = var.cloudsmith_api_key
}

# 1. Create the Repository
resource "cloudsmith_repository" "github_actions_assessment_repo" {
  name        = "github-actions-assessment-repo"
  description = "This is a test repository created using Terraform for github-actions-assessment"
  namespace   = var.organization
}

# 2. Create the Service Account
resource "cloudsmith_service" "github_actions_service" {
  name         = "github-actions-service"
  description  = "This is a test service account created using Terraform for github-actions-assessment"
  organization = var.organization
}

# This will return a slug for either service or user
data "cloudsmith_user_self" "current" {}

# 3. Add Privileges to the Repository for the Service Account
resource "cloudsmith_repository_privileges" "service_write_access" {
  organization = var.organization
  repository   = cloudsmith_repository.github_actions_assessment_repo.slug

  user {
    privilege = "Admin"
    slug      = data.cloudsmith_user_self.current.slug
  }

  service {
    privilege = "Write"
    slug      = cloudsmith_service.github_actions_service.slug
  }
}

data "cloudsmith_organization" "org" {
  slug = var.organization
}

# 4. Create the OIDC Provider Configuration
resource "cloudsmith_oidc" "example" {
  namespace        = var.organization
  name             = "example-oidc-provider"
  provider_url     = "https://token.actions.githubusercontent.com"
  enabled          = true
  claims           = { "repository_owner" : "neerajmythink" }
  service_accounts = [cloudsmith_service.github_actions_service.slug]
}

