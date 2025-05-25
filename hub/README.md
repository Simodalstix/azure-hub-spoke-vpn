# Azure Hub-and-Spoke Network with Terraform

## Project Overview

This project builds an enterprise-grade hub-and-spoke network architecture in Azure using Terraform. It’s designed to reflect real-world patterns like centralized network control, hybrid connectivity, and modular infrastructure — ideal for dev/prod environments or extending to on-prem.

## Key Features

- Hub VNet: Central transit VNet
  - Subnets for Azure Bastion, VPN Gateway, and optionally Azure Firewall
- Spoke VNets: Dev/prod environments
  - Each VNet is isolated and peered to the hub
- Peering: Explicit one-way VNet peering with full bidirectional support
- Modular Terraform:
  - Modules for VNet, peering, VPN gateway, Bastion, etc.
  - Separate configs for `hub/` and `envs/`
- Terraform Outputs: Used to connect isolated configurations across environments

## Directory Structure

azure-hub-spoke-vpn/
|-- modules/ # All reusable Terraform modules
| |-- vnet/
| |-- peering/
| |-- vpn_gateway/
| |-- bastion/ # (optional)
| |-- private_dns/ # (optional)
| `-- route_table/      # (optional)
|-- envs/
|   |-- dev/            # Spoke: Dev environment
|   `-- prod/ # (optional: future use)
|-- hub/ # Hub network deployment
`-- README.md

## Usage

```
# Step 1: Deploy spoke-dev
cd envs/dev
terraform init
terraform apply

# Step 2: Get output for spoke_dev_vnet_id

# Step 3: Deploy hub and wire peering
cd hub
terraform init
# Paste VNet ID from dev into peer_hub_to_dev module
terraform apply
```

## Roadmap

- [ ] Add Azure Bastion for secure jump box access
- [ ] Add Route Tables + Private DNS for internal name resolution
- [ ] Add site-to-site VPN simulation using pfSense or strongSwan
- [ ] Add `envs/prod` using the same reusable module
- [ ] Optional: CI/CD for infra deploy

## Why This Exists

This project is part of a hands-on learning path toward Azure certifications and cloud architecture. It mimics what you'd build in AWS (Transit Gateway, VPC peering, etc.) but using Azure-native tools — to better understand platform differences and real-world IaC workflows.
