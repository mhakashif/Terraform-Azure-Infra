Azure Terraform Project
This project uses Terraform to provision the following Azure resources:

Resource group: "MYTF-RG845" in the "eastus2" location
Virtual network: "mytf-vnet" with address space "10.0.0.0/16"
Subnet: "mytf-subnet" with address prefix "10.0.1.0/24"
Network interface: "mytf-nic" with dynamic private IP allocation
Virtual machine: "mytf-vm" with UbuntuServer 16.04-LTS image and Premium_LRS OS disk
Log Analytics workspace: "mytf-law" with PerGB2018 pricing
Storage account: "mytfstorageacct" with Standard tier and LRS replication
Azure Container Registry: "mytfacr"

Prerequisites
Before you can use Terraform to provision the resources, you will need:

An Azure account
The Azure CLI installed on your machine
Terraform installed on your machine
Usage
To provision the resources, follow these steps:

Clone this repository to your local machine
Open a terminal and navigate to the cloned directory
Run az login to authenticate with your Azure account
Run terraform init to initialize the project
Run terraform plan to preview the changes that will be made
Run terraform apply to apply the changes and provision the resources
Cleanup
To destroy the resources and remove them from your Azure account, run terraform destroy. Note that this will permanently delete all resources created by Terraform for this project.
