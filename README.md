## Task 1: Setting Up an Empty Project and Configuring OIDC

This guide walks you through creating a new project, configuring OpenID Connect (OIDC) authentication, and integrating Cloudsmith with GitHub Actions.

### Prerequisites

- Basic familiarity with GitHub Actions. If you're new, watch this [introductory video](https://youtu.be/47zYGHwXPmE) or review the [GitHub Actions quickstart guide](https://docs.github.com/en/actions/quickstart).

---

## Step-by-Step Instructions

### 1. Cloudsmith Identity & Access Management

#### a. Create a Service Account
- In your Cloudsmith Namespace, create a dedicated service account. This account will act as a bot for automated tasks.

#### b. Assign Permissions
- Grant **Write** or **Admin** access to the service account for your target repository. This ensures the bot has only the permissions it needs.

#### c. Configure OIDC
- Set up OpenID Connect (OIDC) with restricted claims in Cloudsmith. This allows GitHub Actions to securely authenticate using dynamic JWT tokens, eliminating the need for static secrets.

#### d. Bind OIDC to Service Account
- Link your OIDC configuration to the service account. This ensures only authorized workflows can assume the account's permissions.

---

### 2. GitHub Actions Setup

#### a. Initialize Repository
- Create a new GitHub repository for your automation workflows. This keeps your CI/CD logic separate from your application code.

#### b. Configure Environment Secrets
- In your repository settings, add required secrets such as:
    - `CLOUDSMITH_NAMESPACE`
    - `CLOUDSMITH_SERVICE_SLUG`
- These secrets protect sensitive information and make your workflows reusable.

#### c. Deploy Workflow Configuration
- Add a workflow file (e.g., `.github/workflows/oidc-auth.yml`) to your repository.
- Commit the file to the `main` branch to activate the workflow.

---

### 3. Validation

#### a. Monitor Execution
- Go to the **Actions** tab in your GitHub repository.
- Review workflow logs to confirm successful authentication and Cloudsmith operations.

---

## Additional Resources

- [Cloudsmith Documentation](https://help.cloudsmith.io/docs)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

---

By following these steps, you'll securely connect GitHub Actions to Cloudsmith using OIDC, enabling automated and secret-less workflows.