## Task 1: Set Up an Empty Project and Configure OIDC

This section explains how to create a new GitHub project and configure OpenID Connect (OIDC) for secure authentication with Cloudsmith. By using OIDC, GitHub Actions can authenticate with Cloudsmith without long-lived credentials, enabling secure package uploads.

### Steps to Set Up Project and OIDC Authentication

- Fork this repository in your GitHub account and name it (e.g., `cloudsmith-github-actions-assessment`).
- Sign up for Cloudsmith and create a workspace if you don’t have one.
- Note your Cloudsmith workspace name for later reference.
- Generate a personal API key in Cloudsmith and save it in your environment variables.
- Run the `oidc_configure.sh` script in the repository root. This script will:
  1. Create a repository for your packages.
  2. Set up a service account for GitHub Actions to use OIDC.
  3. Configure an OpenID Connect provider for the service account.
  4. Grant the service account permissions to manage the repository.
- In your GitHub repository, add the following secrets under "Settings" > "Secrets and variables" > "Actions" > "Variables":
  - `CLOUDSMITH_NAMESPACE`: Your Cloudsmith namespace (see `oidc_configure.sh`).
  - `CLOUDSMITH_SERVICE_SLUG`: The slug of the service account created (e.g., "github-actions-service-fvwv") while running the `oidc_configure.sh` script.
- Find the `.github/workflows/oidc-auth.yml` file in your repository. This workflow is set up to authenticate with Cloudsmith using OIDC when triggered.
- Make a dummy change to any file in the repository to trigger the workflow.
- Push your changes to the `main` branch to start the workflow and authenticate with Cloudsmith using OIDC.
- Monitor the workflow run in the Actions tab to confirm successful authentication.

## Task 2: Push a Package Using the Cloudsmith GHA Module

This section describes how to use the Cloudsmith GitHub Actions module to upload a already built package to Cloudsmith.

### Steps to Push a Package

 - To push a package to Cloudsmith, ensure you have a built package (e.g., `csm-cloudsmith-npm-cli-example-1.0.1.tgz`) in the repository root.
 - In order to make this work, your Cloudsmith account and GitHub repository are already set up with OIDC and permissions as described in Task 1.
 - The workflow defined in `.github/workflows/push-package.yml` is set up to push a package to Cloudsmith when triggered.
 - Make a minor edit to any file in the repository and push your changes to the `main` branch to trigger the workflow. This will start the workflow action and upload the package to Cloudsmith using the OIDC authentication configured in Task 1.
 - Check the Actions tab to verify the workflow ran and the package was pushed successfully.
 - You can also log in to your Cloudsmith account and navigate to the repository to confirm that the package was uploaded correctly.


## Task 3: Build and Push a Package Using GitHub Actions

This section guides you through creating a package with GitHub Actions and uploading it to Cloudsmith.

### Steps to Build and Push a Package

- Create a simple Python package in your repository (e.g., a `python_package` directory with a `pyproject.toml` and a module).
- Add the necessary metadata to `pyproject.toml`.
- Ensure OIDC and permissions are set up as in Task 1.
- Make a small change to the package files to trigger the workflow.
- Push your changes to the `main` branch. This will start the workflow in `build-push-package.yml`, build the package, and upload it to Cloudsmith.
- View the Actions tab to confirm the package was built and pushed successfully.

