## Task 1: Set Up an Empty Project and Configure OIDC

This section explains how to create a new GitHub project and configure OpenID Connect (OIDC) for secure authentication with Cloudsmith. By using OIDC, GitHub Actions can authenticate with Cloudsmith without long-lived credentials, enabling secure package uploads.

### Steps to Set Up Project and OIDC Authentication

- Fork this repository in your GitHub account and name it (e.g., `cloudsmith-github-actions-assessment`).
- Sign up for Cloudsmith and create a workspace if you don’t have one.
- Note your Cloudsmith workspace name for later reference.
- Generate a personal API key in Cloudsmith and save it in your environment variables (e.g., `CLOUDSMITH_API_KEY`).
- Run the `oidc_configure.sh` script in the repository root. This script will:
  - Create a repository for your packages.
  - Set up a service account for GitHub Actions to use OIDC.
  - Configure an OpenID Connect provider for the service account.
  - Grant the service account permissions to manage the repository.

- Resource creation and OIDC configuration can also be done using Terraform by applying the `oidc_configure.tf` file, which will achieve the same setup as the shell script.
  - First, create a Terraform variable file named `terraform.tfvars` in the repository root to provide the required variables for authenticating with Cloudsmith and provisioning resources. You can generate and populate the `terraform.tfvars` file with your Cloudsmith API key and workspace using the following bash commands:
    ```bash
    touch terraform.tfvars
    echo 'cloudsmith_api_key = "your_actual_api_key"' > terraform.tfvars
    echo 'organization = "your_cloudsmith_workspace"' >> terraform.tfvars
    ```
  - Then, apply the Terraform configuration by running the following commands in your terminal:
    ```bash
    terraform init
    terraform apply -auto-approve
    ```
- In your GitHub repository, add the following secrets under "Settings" > "Secrets and variables" > "Actions" > "Variables":
  - `CLOUDSMITH_NAMESPACE`: Your Cloudsmith namespace (see `oidc_configure.sh`).
  - `CLOUDSMITH_SERVICE_SLUG`: The slug of the service account created (e.g., "github-actions-service-fvwv") while running the `oidc_configure.sh` script.

- Find the `.github/workflows/oidc-auth.yml` file in your repository. This workflow is set up to authenticate with Cloudsmith using OIDC when triggered.
- Make a dummy change to any file in the repository to trigger the workflow.
- Push your changes to the `main` branch to start the workflow and authenticate with Cloudsmith using OIDC.
- Monitor the workflow run in the Actions tab to confirm successful authentication.

## Task 2: Push a Package Using the Cloudsmith GHA Module

This section describes how to use the Cloudsmith GitHub Actions module to upload a already built package to Cloudsmith. This task assumes you have a package ready to be uploaded (e.g., an npm package or a Python wheel) and that OIDC authentication is configured as per Task 1.

### Steps to Push a Package

 - To push a package to Cloudsmith, ensure you have a built package (e.g., `csm-cloudsmith-npm-cli-example-1.0.1.tgz`) in the repository root and that the OIDC authentication is set up as described in Task 1.
 - The workflow defined in `.github/workflows/push-package.yml` is set up to push a package to Cloudsmith when triggered.
 - Make a minor edit to any file in the repository and push your changes to the `main` branch to trigger the workflow. This will start the workflow action and upload the package to Cloudsmith using the OIDC authentication configured in Task 1.
 - Check the Actions tab to verify the workflow ran and the package was pushed successfully in the logs of the workflow run.
 - You can also log in to your Cloudsmith account and navigate to the repository to confirm that the package was uploaded correctly.

## Task 3: Build and Push a Package Using GitHub Actions

This section guides you through creating a package with GitHub Actions and uploading it to Cloudsmith. This task assumes you have a simple package (e.g., a Python package) in your repository and that OIDC authentication is configured as per Task 1.

### Steps to Build and Push a Package

- Ensure you have a simple package (e.g., a Python_package) in your repository. For example, you can have a `pyproject.toml` file and a `src` directory with your sample Python code.
- The workflow defined in `.github/workflows/build-and-push-package.yml` is set up to build the package and push it to Cloudsmith when triggered.
- Make a minor edit to any file in the repository and push your changes to the `main` branch to trigger the workflow. This will start the workflow action, which will build the package (e.g., using `python -m build`) and upload it to Cloudsmith using the OIDC authentication configured in Task 1.
- Check the Actions tab to verify the workflow ran successfully and the package was built and pushed to Cloudsmith. You can also log in to your Cloudsmith account and navigate to the repository to confirm that the package was uploaded correctly.

## Conclusion
By completing these tasks, you have successfully set up a GitHub project with OIDC authentication to securely interact with Cloudsmith. You have also learned how to use GitHub Actions to build and push packages to Cloudsmith, streamlining your CI/CD pipeline for package management.
