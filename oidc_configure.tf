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

# # 4. Create the OIDC Provider Configuration
# resource "cloudsmith_oidc_provider" "github_oidc" {
#   organization = var.organization
#   name         = "github-actions-openid2"
#   provider_url = "https://token.actions.githubusercontent.com"
#   enabled      = true

#   # The claims restriction (JSON format)
#   claims = {
#     repository_owner = "neerajmythink"
#   }

#   # Link the service account created above
#   service_accounts = [cloudsmith_service.github_actions_service.slug]
# }
