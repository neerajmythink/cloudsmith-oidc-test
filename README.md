## Task 1: Create an empty project and configure OIDC
This guide demonstrates how to create an empty project in GitHub and configure OpenID Connect (OIDC) for secure authentication with Cloudsmith.
### Steps to Create a Project and Configure OIDC
- Create a Cloudsmith account if you don't have one already and get neccessary details like `CLOUDSMITH_NAMESPACE` and  `CLOUDSMITH_API_KEY`.
- Run the `oidc_configure.sh` script to set up OIDC authentication with Cloudsmith. This script will create 1. a repository in Cloudsmith, 2. a service account, 3. an OpenID Connect provider, and 4. assign the necessary permissions for the service account to interact with the repository.
- Create a new repository in GitHub. You can name it something like `cloudsmith-oidc-test`.
- Add the necessary secrets to your GitHub repository. Go to the repository settings, navigate to the "Secrets and variables" section, and add the following secrets:
  - `CLOUDSMITH_NAMESPACE`: Your Cloudsmith namespace.
  - `CLOUDSMITH_REPO_NAME`: The name of the Cloudsmith repository created by the `oidc_configure.sh` script.
  - `CLOUDSMITH_SERVICE_SLUG`: The slug of the service account created by the `oidc_configure.sh` script.
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

