#!/bin/bash

# Task 1: Create an empty project and configure OIDC
# Get familiar with how Github actions work, this video should give you the basis and jumping ground to complete this task, you can also find out more by following the quickstart guide from Github. Once comfortable with running Github actions, you should then configure the OIDC connection and authenticate to Cloudsmith.

export NAMESPACE="cloudsmith-org-neeraj" # Replace with your actual namespace
export API_KEY=$CLOUDSMITH_API_KEY # Ensure you have set the CLOUDSMITH_API_KEY environment variable with your API key
export REPO_NAME="github-actions-assessment-repo" # You can change the repository name as needed
export REPO_DESC="This is a test repository created using cloudsmith API for github-actions-assessment"

export SERVICE_NAME="github-actions-service" # Name for the service account to be created
export SERVICE_DESC="This is a test service account created using cloudsmith API for github-actions-assessment"

export OIDC_NAME="github-actions-openid" # Name for the OIDC provider to be created
export OIDC_PROVIDER="https://token.actions.githubusercontent.com" # OIDC provider URL for GitHub Actions, this is a well-known URL that GitHub uses for OIDC tokens
export OIDC_CLAIM='{"repository_owner":"neerajmythink"}' # Replace "neerajmythink" with your actual GitHub username or organization name, this claim will be used to restrict access to the OIDC provider based on the repository owner

# function to create a repository in Cloudsmith
create_repo() {
  curl -sS\
    --request POST \
    --url "https://api.cloudsmith.io/repos/${NAMESPACE}/" \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --header "X-Api-Key: ${API_KEY}" \
    --data '{
    "name": "'"${REPO_NAME}"'",
    "description": "'"${REPO_DESC}"'",
    "repository_type_str": "Private",
    "default_privilege": "Read"
    }' | jq '.slug_perm'
}

# function to add service account to the namespace in Cloudsmith
add_service_account() {
  curl -sS\
    --request POST \
    --url https://api.cloudsmith.io/orgs/${NAMESPACE}/services/ \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    --header "X-Api-Key: ${API_KEY}" \
    --data '
            {
              "name": "'${SERVICE_NAME}'",
              "description": "'"${SERVICE_DESC}"'"
            }
            ' | jq -r '.slug'
}

# function to create an OIDC provider in Cloudsmith
oidc_create() {
  curl -sS\
     --request POST \
     --url https://api.cloudsmith.io/orgs/${NAMESPACE}/openid-connect/ \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --header "X-Api-Key: ${API_KEY}" \
     --data '
            {
            "claims": '"${OIDC_CLAIM}"',
            "enabled": true,
            "name": "'${OIDC_NAME}'",
            "provider_url": "'${OIDC_PROVIDER}'",
            "service_accounts": ["'"${SERVICE_SLUG}"'"]
            }
            ' | jq '.slug_perm'
        } 

REPO_SLUG=$(create_repo)
export REPO_SLUG
echo 1. Repo created with repo name as: "${REPO_NAME}"

SERVICE_SLUG=$(add_service_account)
export SERVICE_SLUG
echo 2. Service account created with service slug as: "${SERVICE_SLUG}"

OPENID_SLUG=$(oidc_create)
export OPENID_SLUG
echo 3. OpenID connect created with slug_perm as: "${OPENID_SLUG}"
