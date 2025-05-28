# Self-Hosted Setup Configuration

This repository contains the configuration for my self-hosted services, primarily running on an Intel NUC located at home.

## Hosted Services

The following services are currently operational:

*   **Nextcloud:** Used for Google Drive replacement. Managing Files and Photos.
*   **Vaultwarden (Bitwarden_rs):** A self-hosted password manager.
*   **Big-AGI:** An interface for interacting with various AI models.
*   **Paperless-ngx:** For managing and archiving digital documents.

Additional technical services supporting the infrastructure:

*   **Pangolin:** Reverse proxy for exposing services to the internet.
*   **Newt:** Automaticly creates and keeps a wiregurad tunnel alive.
*   **Ofelia:** A job scheduler for automated tasks.

## Architecture Overview

The setup consists of two main components:

1.  **Home Server:**
    *   An Intel NUC (8GB RAM, 500GB SSD + 2TB HDD) serves as the primary host.
    *   Most services run in Docker containers on this machine, where all data is stored.
    *   The base operating system is [OpenMediaVault (OMV)](https://www.openmediavault.org/).
    *   Data is regularly backed up to [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html).

2.  **Cloud VPS (Gateway):**
    *   A Virtual Private Server (VPS) with a static public IP address is used because a static IP is not available for the home server.
    *   This VPS runs **Pangolin**, which securely forwards incoming internet traffic to the appropriate services on the home server.



## Setup Instructions

This environment is managed using **Ansible** for configuration and **Terraform** for cloud infrastructure provisioning.

### 1. Cloud Server (VPS) Setup

This server acts as the public-facing entry point.

#### 1.1. Infrastructure Provisioning (Terraform - Optional)

If you intend to automatically provision the VPS infrastructure (e.g., on Azure):

*   **Note:** Azure services can be expensive without promotional credits. Consider alternative providers like Hetzner, DigitalOcean, or Linode for cost-effectiveness.
*   Terraform scripts are located in `cloud_server/terraform/azure`.

To use the Terraform scripts:
1.  Install the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
2.  Authenticate with Azure: `az login`
3.  Navigate to the `cloud_server/terraform/azure` directory.
4.  Initialize Terraform: `terraform init`
5.  (Optional) Preview changes: `terraform plan`
6.  Apply the configuration: `terraform apply`

Successful execution should create an Azure VM and generate an `inventory.ini` file in `cloud_server/ansible/inventory.ini`.

#### 1.2. Server Configuration (Ansible)

Follow these steps regardless of whether Terraform was used or the VPS was set up manually:

1.  **Inventory File:**
    *   If Terraform was not used, manually create or update `cloud_server/ansible/inventory.ini` with the VPS IP address and SSH user.
2.  **Secret Management:**
    *   Copy `cloud_server/ansible/group_vars/all/vault.yml.sample` to `cloud_server/ansible/group_vars/all/vault.yml`.
    *   Edit `vault.yml` to include your specific secret values (e.g., domain names, API keys).
3.  **Execute Ansible Playbook:**
    *   Navigate to the `cloud_server/ansible` directory.
    *   Run the playbook: `ansible-playbook playbook.yml`

    This playbook performs the following actions:
    *   Applies basic server hardening.
    *   Installs required packages, including Docker.
    *   Configures Pangolin as a reverse proxy.
    *   Sets up automated backups for essential server configuration files.
    *   May prompt for restoration from backup if a previous setup is detected.

### 2. Home Server (NUC) Setup

This is where the primary services are hosted.

1.  **Prerequisites:**
    *   The home server is expected to be running OpenMediaVault with Docker already installed. These components must be set up manually if not already present.
2.  **Inventory File:**
    *   Update `home_server/ansible/inventory.ini` with your home server's IP address and SSH user.
3.  **Secret Management:**
    *   Review `home_server/ansible/group_vars/all/vault.yml.sample` and create/update your `home_server/ansible/group_vars/all/vault.yml`.
    *   Certain Docker services may have their own `vault.yml` or specific configuration files within their respective `roles` subdirectories (e.g., `home_server/roles/nextcloud/vars/vault.yml`). Ensure these are also configured.
4.  **Execute Ansible Playbook:**
    *   Navigate to the `home_server` directory.
    *   Run the playbook, specifying which services (tags) to deploy:
        ```bash
        # Example: Deploy Nextcloud and Vaultwarden
        ansible-playbook playbook.yml --tags "nextcloud,vaultwarden"

        # Example: Deploy all services defined in the playbook
        ansible-playbook playbook.yml
        ```
    *   Available tags correspond to the role names in `home_server/roles/` or can be identified within the `playbook.yml` file.