# Terraform Setup for GKE and Cloud SQL

## Project Description
##### Overview
This project uses Terraform to automate the setup of a Google Kubernetes Engine (GKE) cluster and PostgreSQL database instance on Google Cloud Platform (GCP). The Terraform scripts provided in this repository are designed to simplify the process of infrastructure provisioning for both development environments and can be used for other environments as well. This setup includes creating and configuring the GKE cluster, deploying the PostgreSQL database, and ensuring secure access and management through IAM roles and Kubernetes secrets.

#### Goals
- Provision a GKE Cluster: Automate the creation of a GKE cluster with appropriate settings for development and production environments.
Deploy
- PostgreSQL: Set up a PostgreSQL database instance on GCP and configure it for use with applications running on the GKE cluster.
- Ensure Security: Manage authentication and authorization through IAM roles and Kubernetes secrets to maintain secure access to the GKE cluster and database.
- Facilitate Automation: Use Terraform to handle infrastructure as code, allowing for reproducible and consistent setups across different environments.

## Tool Decisions
#### Terraform
- Reason for Choice: Terraform is used for Infrastructure as Code (IaC) to automate the provisioning and management of cloud resources. It allows for declarative configuration and version control of infrastructure, ensuring consistency across different environments.
- Advantages:
  - Declarative syntax for defining infrastructure.
  - Support for a wide range of cloud providers.
  - Strong community support and extensive documentation.
    
#### Google Kubernetes Engine (GKE)
- Reason for Choice: GKE provides a fully managed Kubernetes environment, simplifying cluster management, scaling, and operations. It integrates seamlessly with other GCP services.
- Advantages:
   - Managed Kubernetes infrastructure with automated updates and scaling.
   - Integration with GCP’s security, monitoring, and logging services.
   - High availability and reliability.

#### Cloud SQL (PostgreSQL)
- Reason for Choice: Cloud SQL offers a managed PostgreSQL service with automatic backups, replication, and patch management, reducing administrative overhead.
- Advantages:
   - Managed service with built-in high availability and automated backups.
   - Seamless integration with GKE for database connectivity.
   - Security features such as encryption and IAM-based access control.

## Setup Instructions

1. **Create a Google Cloud Platform (GCP) Account**

   Begin by creating a Google Cloud account using the [Google Cloud Free Tier](https://cloud.google.com/free/docs/gcp-free-tier).

2. **Create a GKE Cluster**

   For best practices, create separate clusters for non-production and production environments.

   ![GKE Cluster](https://github.com/user-attachments/assets/e06288b6-ee5e-4b58-a9c8-9bb02b418d83)

3. **Update Configuration Files**

   Update the project name in `main.tf` and `main-variables.tf` to reflect your specific project details.

   ![Update Project Name](https://github.com/user-attachments/assets/36f940b1-d564-4314-8f5f-0c24788a741f)

4. **Repository Structure**

   This repository includes the following components:

   - **`main.tf`**
     - Configures the Google provider for setup.
     - Contains subfolders `database` and `gkecluster`, which include necessary Google modules and resources for deploying the GKE cluster and PostgreSQL database.

   - **`main-variables.tf`**
     - Defines global variables, which can be overridden in the specific module's `variables.tf` file.

   - **`modules/`**
     - **`gkecluster/`**
       - Sets up GKE infrastructure, including authentication, network, and cluster configuration.
       - **GCP Modules:**
         - `network`: Facilitates VPC network setup, including subnets, secondary ranges, routes, and firewall rules.
         - `auth`: Configures authentication for GKE clusters.
         - `private_clusters`: Manages private GKE cluster creation and configuration, including node pools and network policies.
       - **GCP Resources:**
         - `google_container_node_pool`: Manages node pools in a GKE cluster, ensuring a maximum of 6 nodes to avoid exceeding node limits.
       - **`variables.tf`**
         - Allows overriding of global variables defined in `main-variables.tf`.

     - **`database/`**
       - Sets up Cloud SQL PostgreSQL databases and related configurations.
       - **Resources:**
         - `google_sql_database_instance`: Creates a new Google SQL database instance.
         - `google_sql_database`: Represents a SQL database within the Cloud SQL instance.
         - `google_sql_user`: Creates a new SQL user for the Cloud SQL instance.
         - `google_secret_manager_secret_version`: Manages secret versions.
       - **`variables.tf`**
         - Allows overriding of global variables defined in `main-variables.tf`.

5. **Install and Configure `gcloud`**

   Install the Google Cloud SDK by following the [installation guide](https://cloud.google.com/sdk/docs/install-sdk).

6. **Authenticate with Google Cloud**

   Authenticate using the command:
   ```bash
   gcloud auth login
   ```
   <img width="776" alt="image" src="https://github.com/user-attachments/assets/5402d8ea-b62a-438d-a5f7-6525921fb1ca">
   
7. ## Setup Permissions
   - Enable Service Usage API access - https://console.cloud.google.com/apis/api/serviceusage.googleapis.com/
   - Enable Cloud Resource Manager API access - https://console.cloud.google.com/apis/library/cloudresourcemanager.googleapis.com
   - Enable Secrets Manager API access - https://console.cloud.google.com/marketplace/product/google/secretmanager.googleapis.com
   - Setup DB secrets in Secrets Manager. Specify the username and password in the secrets section https://console.cloud.google.com/security/secret-manager
   - For Postgres DB Instance creation, enable Cloud SQL Admin API - https://console.cloud.google.com/apis/api/sqladmin.googleapis.com/
   
     <img width="624" alt="image" src="https://github.com/user-attachments/assets/4588e9cf-447c-4943-8985-1662950b86c7">
     
8. **Execute the terraform commands**
      ```
      terraform init
      terraform plan
      terraform apply
      ```
      
9. **Verify the Setup**
After applying the Terraform configurations, verify that:
- The dev-gke-cluster appears in the Kubernetes console.
  <img width="771" alt="image" src="https://github.com/user-attachments/assets/55b03e0a-7772-43e6-89e8-d613b6274d89">
  <img width="913" alt="image" src="https://github.com/user-attachments/assets/39b217fa-a60a-4e31-887c-923d77317bf9">

- The PostgreSQL instance is created in Google Cloud.
  <img width="633" alt="image" src="https://github.com/user-attachments/assets/da4e6b4a-e46a-4130-9a6e-ac0ae43420f0">

10. **Cleanup Resources**
- When you have finished and want to destroy the clusters to save costs, run: `terraform destroy`


## Lessons Learned
- Automation Benefits: Automation with Terraform significantly reduced manual effort and errors in provisioning infrastructure.
- Security Practices: Proper management of IAM roles and Kubernetes secrets is crucial for maintaining security.
- Integration Challenges: Ensured smooth integration between GKE and Cloud SQL, addressing any connectivity and configuration issues
