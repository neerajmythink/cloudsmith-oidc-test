## Task 1: Create an empty project and configure OIDC
This guide demonstrates how to create an empty project in GitHub and configure OpenID Connect (OIDC) for secure authentication with Cloudsmith. This setup allows GitHub Actions to authenticate with Cloudsmith using OIDC, enabling secure interactions without the need for long-lived credentials. Using this we can securely push packages to Cloudsmith from GitHub Actions workflows.

### Steps to Create a Project and Configure OIDC
- Fork this repository in GitHub in your GitHub account and name it something like `cloudsmith-github-actions-assessment`.
- Create a Cloudsmith account if you don't have one followed by a creation of a workspace if not already created.
- Note down the workspace name and create a personal API key for authentication. You will need these values to set up the necessary secrets in your GitHub repository. The secrets you need to add are `CLOUDSMITH_NAMESPACE` and `CLOUDSMITH_API_KEY`.
- Run the `oidc_configure.sh` script in the root of the repository to set up OIDC authentication for Cloudsmith. This script will create in Cloudsmith:
  - 1. a repository in Cloudsmith to store your packages.
  - 2. a service account in Cloudsmith for GitHub Actions to authenticate with OIDC.
  - 3. an OpenID Connect provider configuration in Cloudsmith for the service account.
  - 4. assign the necessary permissions for the service account to interact with the repository.

- Go to the created GitHub repository and add the necessary secrets to your GitHub repository. Go to the repository settings, navigate to the "Secrets and variables/Actions/Variables" section, and add the following secrets with name and value as mentioned below:
  - 1. `CLOUDSMITH_NAMESPACE`= "my_namespace" | Your Cloudsmith namespace created in the Cloudsmith account.
  - 2. `CLOUDSMITH_SERVICE_SLUG`= "github-actions-service-fvwv" | The slug of the service account created by the `oidc_configure.sh` script.

- In the repository the file named `.github/workflows/oidc-auth.yml`. This file will contain the GitHub Actions workflow for OIDC authentication.
- do some dummy edits to the file to trigger the workflow.
- This workflow is configured to run on pushes to the `main` branch. Make sure to push your changes to this branch, this will trigger the workflow and execute the steps to authenticate with Cloudsmith using OIDC as configured in `oidc-auth.yml`.
- Check the Actions tab in your GitHub repository to see the workflow execution and verify that the authentication with Cloudsmith using OIDC is successful.

## Task 2: Use Cloudsmith GHA module to push a package
This guide demonstrates how to use the Cloudsmith GitHub Actions (GHA) module to push an already built package to Cloudsmith.

### Steps to Push a Package to Cloudsmith
- All the necessory components of cloudsmith is already set up from Task 1, so you can directly move to pushing a package.
- Put a built package in the root of the repository. For example, you can create a simple `package.txt` file with some content to simulate a package.
- Ensure you have the necessary permissions and OIDC configuration set up as described in Task 1.
- perform some dummy edits to the package file to trigger the workflow.
- This workflow is configured to run on pushes to the `main` branch. Make sure to push your changes to this branch, this will trigger the workflow and execute the steps to push the package to Cloudsmith as configured in `push-package.yml`.
- Check the Actions tab in your GitHub repository to see the workflow execution and verify that the package is successfully pushed to Cloudsmith.

## Task 3: Use GHA to create a package
This guide demonstrates how to use GitHub Actions to create a package and then push it to Cloudsmith.

### Steps to Create and Push a Package to Cloudsmith
- Create a simple Python package in your repository. For example, you can create a `python_package` directory with a `pyproject.toml` file and a simple module.
- The `pyproject.toml` file should contain the necessary metadata for your package.
- Ensure you have the necessary permissions and OIDC configuration set up as described in Task 1.
- Perform some dummy edits to the package files to trigger the workflow.
- This workflow is configured to run on pushes to the `main` branch. Make sure to push your changes to this branch, this will trigger the workflow and execute the steps to build the package and push it to Cloudsmith as configured in `build-push-package.yml`.
- Check the Actions tab in your GitHub repository to see the workflow execution and verify that the package is successfully built and pushed to Cloudsmith.

