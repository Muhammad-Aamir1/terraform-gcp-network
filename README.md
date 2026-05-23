# Terraform GCP Network

This repository contains a small Terraform configuration for provisioning a Google Cloud VPC network and subnet.

## What this project does

- Creates a Google Cloud VPC network with `google_compute_network`
- Creates a Google Cloud subnet with `google_compute_subnetwork`
- Uses Terraform backend configuration to store state in Google Cloud Storage
- Uses GitHub Actions OIDC authentication for secure deployment without storing service account keys in the repository

## Repository structure

- `main.tf` - network and subnet resources
- `provider.tf` - Terraform provider configuration and backend settings
- `variables.tf` - declared input variables for project, network, subnet, and region
- `.github/workflows/deploy.yml` - CI/CD workflow for plan/apply using GitHub Actions
- `.gitignore` - ignores local Terraform state, credentials, and editor files

## Variables

The Terraform configuration depends on the following variables:

- `project` - GCP project ID
- `network_name` - VPC network name
- `subnet_cidr` - CIDR range for the subnet
- `region` - GCP region for the subnet

## GitHub secrets required

This workflow does not hardcode sensitive deployment values. Set the following repository secrets in GitHub:

- `GCP_PROJECT_ID`
- `GCP_WORKLOAD_IDENTITY_PROVIDER`
- `GCP_SERVICE_ACCOUNT_EMAIL`
- `GCS_STATE_BUCKET`
- `GCS_STATE_PREFIX`
- `GCP_NETWORK_NAME`
- `GCP_SUBNET_CIDR`
- `GCP_REGION`

## Deployment

This repository is designed for GitHub Actions deployment. The workflow uses `google-github-actions/auth@v2` with Workload Identity Federation.

To deploy manually:

1. Authenticate to GCP locally using your preferred method.
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Create a plan:
   ```bash
   terraform plan -input=false
   ```
4. Apply the configuration:
   ```bash
   terraform apply -input=false -auto-approve
   ```

## GitHub Actions

The workflow is configured to run on:

- `push` to `main`
- `pull_request` targeting `main`
- manual `workflow_dispatch`

It performs:

- `terraform init -input=false`
- `terraform plan -input=false` on PRs
- `terraform apply -input=false -auto-approve` on pushes to `main`

## Security notes

- Do not commit `terraform.tfstate`, `.terraform/`, or any local credential files.
- The `.gitignore` file already ignores these sensitive artifacts.
- `terraform.lock.hcl` is safe and recommended to keep in version control.

## Notes

This configuration is intentionally small and focused on GCP network setup. For production use, consider adding:

- remote state locking and encryption
- resource tagging/labels
- module reuse
- separate environments for dev/prod
- more network resources (firewalls, routes, IAM bindings)
