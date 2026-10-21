### AWS VPC Peering Lab with HCP Terraform

# Overview
This lab provisions AWS infrastructure using Terraform and HCP Terraform remote execution. The infrastructure is organized into separate workspaces to manage networking, VPC peering, security groups, and compute resources independently.


# Workspace Architecture
The following workspaces are used in this lab:
fe-network-ws — Creates the Frontend VPC, subnets, Internet Gateway, route tables, and NAT Gateway.
be-network-ws — Creates the Backend VPC, subnets, Internet Gateway, route tables, and NAT Gateway.
peering-ws — Creates VPC peering between the Frontend and Backend VPCs and configures routes between the private subnets.
fe-security-ws — Creates Frontend security groups and their ingress and egress rules.
be-security-ws — Creates Backend security groups and their ingress and egress rules.
fe-compute-ws — Creates Frontend public instance ,private resources.
be-compute-ws — Creates Backend public instance ,private resources.


### Execution Order
Run the workspaces in the following order:
- fe-network-ws
- be-network-ws
- peering-ws
- fe-security-ws
- be-security-ws
- fe-compute-ws
- be-compute-ws

Important: Each workspace must successfully apply its configuration before dependent workspaces can read its Terraform outputs through terraform_remote_state.

### Terraform CLI Commands
Run these commands from the directory of the workspace you want to manage.

1. Initialize Terraform
terraform init

2. Authenticate with HCP Terraform
terraform login

Run this when authentication is needed. You do not need to repeat it for every command if your CLI is already authenticated.

3. Format the Configuration
terraform fmt -recursive

4. Validate the Configuration
terraform validate

5. Review the Execution Plan
terraform plan


6. Apply the Configuration
terraform apply

### HCP Terraform Configuration
Each workspace uses HCP Terraform remote execution and must be configured with the correct workspace name.
The cloud block in versions.tf should identify the workspace being managed:

terraform {
  cloud {
    organization = "hellocloud-tfc-org02"

    workspaces {
      name = "fe-network-ws"
    }
  }
}

### AWS Credentials

AWS credentials must be configured for the execution environment.

For HCP Terraform remote execution, configure AWS credentials or AWS dynamic provider credentials in HCP Terraform. A local AWS CLI profile is not automatically available to the remote runner.
