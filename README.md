# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

## Introduction

For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Getting Started

1. Clone this repositorys

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

### Dependencies

1. Create an [Azure Account](https://portal.azure.com)
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

## Instructions

### 1. Login to Azure

* Open your terminal and run the following command to log in to Azure:

    ```bash
    az login
    ```

* Follow the prompts to complete the login process.

### 2. Create an Azure Policy Definition

* Create an Azure Policy Definition using the following command. Replace ```<policy name>``` with your desired policy name and ```<filename>``` with the path to your policy definition rules file:

    ```sh
    az policy definition create --name <policy name> --rules <filename>
    ```

### 3. Build an Image with Packer

* Build a custom image using Packer by running the following command. Replace ```<filename>``` with the path to your Packer configuration file:

     ```sh
     packer build <filename>
     ```

### 4. Initialize Resources

If you need to remove the resources created by Terraform, use the following command. Replace ```<filename>``` with the path to your execution plan file:

* Navigate to your Terraform configuration directory in the terminal.
* Run the following command to initialize Terraform:

     ```sh
     terraform init
     ```

### 5. Changing Variables in vars.tf

#### 1. Locate the vars.tf File

* Navigate to the directory where your Terraform configuration is located.
* Inside this directory, you'll find a file named ``vars.tf``. This is where you can define and modify input variables.

#### 2. Edit the Variable Values

* Open the ``var.tf`` file using a text editor of your choice (e.g., ``VSCode``, ``Notepad``, ``Vim``).
* In this file, you'll find variable definitions using the variable block. Locate the variable(s) you want to change.

#### 3. Modify Variable Values

* Within the ``variable`` block, you'll see the name, type, and default value of the variable.
* To change a variable's value, update the ``default`` attribute with your desired value.
* Save the changes after editing the variable(s).

### 6. Generate Terraform Execution Plan

* Create a Terraform execution plan by running the following command. Replace ```<filename>``` with the desired output file name for the execution plan:

     ```sh
     terraform plan -out <filename>
     ```

### 7. Apply Terraform Configuration

* Apply the Terraform configuration to create the resources in your Azure environment. Use the execution plan file generated in the previous step. Replace ```<filename>``` with the path to your execution plan file:

     ```sh
     terraform apply <filename>
     ```

### 8. View Terraform State

* To view the current state of your resources managed by Terraform, run the following command:

    ```sh
    terraform show
    ```

### 9. Destroy Resources

* If you need to remove the resources created by Terraform, use the following command. Replace ```<filename>``` with the path to your execution plan file:

     ```sh
     terraform destroy <filename>
     ```

## Output

### 1. Create and check an Azure Policy

```powershell
PS C:\Deploying_a_Web_Server_in_Azure> az policy definition create --name taggin-policy --rules .\policy.json
{
  "description": null,
  "displayName": null,
  "id": "/subscriptions/c2974833-f9d6-49e2-b843-74513c83a919/providers/Microsoft.Authorization/policyDefinitions/taggin-policy",
  "metadata": {
    "createdBy": "e7fc96b6-185e-4c4a-9461-ee1be25588da",
    "createdOn": "2023-09-26T03:27:19.215999Z",
    "updatedBy": null,
    "updatedOn": null
  },
  "mode": "Indexed",
  "name": "taggin-policy",
  "parameters": null,
  "policyRule": {
    "if": {
      "exists": "false",
      "field": "tags"
    },
    "then": {
      "effect": "deny"
    }
  },
  "policyType": "Custom",
  "systemData": {
    "createdAt": "2023-09-26T03:27:19.168162+00:00",
    "createdBy": "odl_user_241820@udacityhol.onmicrosoft.com",
    "createdByType": "User",
    "lastModifiedAt": "2023-09-26T03:27:19.168162+00:00",
    "lastModifiedBy": "odl_user_241820@udacityhol.onmicrosoft.com",
    "lastModifiedByType": "User"
  },
  "type": "Microsoft.Authorization/policyDefinitions"
}
```

```powershell
PS C:\Deploying_a_Web_Server_in_Azure> az policy assignment list
[
  {
    "description": "clouddevops674-241820-PolicyDefinition",
    "displayName": "clouddevops674-241820-PolicyDefinition",
    "enforcementMode": "Default",
    "id": "/subscriptions/c2974833-f9d6-49e2-b843-74513c83a919/providers/Microsoft.Authorization/policyAssignments/clouddevops674-241820-PolicyDefinition",
    "identity": null,
    "location": null,
    "metadata": {
      "createdBy": "f797eca9-5d09-44b6-b23f-98732363911c",
      "createdOn": "2023-09-26T03:24:09.6455579Z",
      "updatedBy": null,
      "updatedOn": null
    },
    "name": "clouddevops674-241820-PolicyDefinition",
    "nonComplianceMessages": null,
    "notScopes": null,
    "parameters": null,
    "policyDefinitionId": "/subscriptions/c2974833-f9d6-49e2-b843-74513c83a919/providers/Microsoft.Authorization/policyDefinitions/clouddevops674-241820-PolicyDefinition",
    "scope": "/subscriptions/c2974833-f9d6-49e2-b843-74513c83a919",
    "systemData": {
      "createdAt": "2023-09-26T03:24:09.589345+00:00",
      "createdBy": "0609ced8-c8f7-49fd-91c2-c484ddad694d",
      "createdByType": "Application",
      "lastModifiedAt": "2023-09-26T03:24:09.589345+00:00",
      "lastModifiedBy": "0609ced8-c8f7-49fd-91c2-c484ddad694d",
      "lastModifiedByType": "Application"
    },
    "type": "Microsoft.Authorization/policyAssignments"
  }
]
```

### 2. Build an Image with Packer

```poweshell
PS C:\Deploying a Web Server in Azure> packer build .\server.json
Warning: Bundled plugins used

This template relies on the use of plugins bundled into the Packer binary.
The practice of bundling external plugins into Packer will be removed in an
upcoming version.

To remove this warning and ensure builds keep working you can install these
external plugins with the 'packer plugins install' command

* packer plugins install github.com/hashicorp/azure

Alternatively, if you upgrade your templates to HCL2, you can use 'packer init'
with a 'required_plugins' block to automatically install external plugins.

You can try HCL2 by running 'packer hcl2_upgrade
C:\Users\luiyi\OneDrive\Documents\Projects\Deploying a Web Server in
Azure\server.json'


azure-arm: output will be in this color.

==> azure-arm: Running builder ...
Build 'azure-arm' errored after 5 milliseconds 194 microseconds: error fetching subscriptionID from VM metadata service for Managed Identity authentication: Get "http://169.254.169.254/metadata/instance/compute?api-version=2017-08-01&format=json": dial tcp 169.254.169.254:80: connectex: A socket operation was attempted to an unreachable network.

==> Wait completed after 5 milliseconds 194 microseconds

==> Some builds didn't complete successfully and had errors:
--> azure-arm: error fetching subscriptionID from VM metadata service for Managed Identity authentication: Get "http://169.254.169.254/metadata/instance/compute?api-version=2017-08-01&format=json": dial tcp 169.254.169.254:80: connectex: A socket operation was attempted to an unreachable network.

==> Builds finished but no artifacts were created.
```

### 3. Terraform Plan

```powershell
PS C:\Users\luiyi\OneDrive\Documents\Projects\Deploying a Web Server in Azure> terraform plan -out solution.plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols: 
  + create

Terraform will perform the following actions:

  # azurerm_availability_set.main will be created
  + resource "azurerm_availability_set" "main" {
      + id                           = (known after apply)
      + location                     = "eastus"
      + managed                      = true
      + name                         = "project-set"
      + platform_fault_domain_count  = 3
      + platform_update_domain_count = 5
      + resource_group_name          = "project-resource"
    }

  # azurerm_lb.main will be created
  + resource "azurerm_lb" "main" {
      + id                   = (known after apply)
      + location             = "eastus"
      + name                 = "project-lb"
      + private_ip_address   = (known after apply)
      + private_ip_addresses = (known after apply)
      + resource_group_name  = "project-resource"
      + sku                  = "Basic"
      + sku_tier             = "Regional"

      + frontend_ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + id                                                 = (known after apply)
          + inbound_nat_rules                                  = (known after apply)
          + load_balancer_rules                                = (known after apply)
          + name                                               = "PubliIpAddress"
          + outbound_rules                                     = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = (known after apply)
          + private_ip_address_version                         = (known after apply)
          + public_ip_address_id                               = (known after apply)
          + public_ip_prefix_id                                = (known after apply)
          + subnet_id                                          = (known after apply)
        }
    }

  # azurerm_lb_backend_address_pool.main will be created
  + resource "azurerm_lb_backend_address_pool" "main" {
      + backend_ip_configurations = (known after apply)
      + id                        = (known after apply)
      + inbound_nat_rules         = (known after apply)
      + load_balancing_rules      = (known after apply)
      + loadbalancer_id           = (known after apply)
      + name                      = "BackendAddressPool"
      + outbound_rules            = (known after apply)
    }

  # azurerm_linux_virtual_machine.main[0] will be created
  + resource "azurerm_linux_virtual_machine" "main" {
      + admin_password                                         = (sensitive value)
      + admin_username                                         = "Admin-username"
      + allow_extension_operations                             = true
      + availability_set_id                                    = (known after apply)
      + bypass_platform_safety_checks_on_user_schedule_enabled = false
      + computer_name                                          = (known after apply)
      + disable_password_authentication                        = false
      + extensions_time_budget                                 = "PT1H30M"
      + id                                                     = (known after apply)
      + location                                               = "eastus"
      + max_bid_price                                          = -1
      + name                                                   = "project-vm-1"
      + network_interface_ids                                  = (known after apply)
      + patch_assessment_mode                                  = "ImageDefault"
      + patch_mode                                             = "ImageDefault"
      + platform_fault_domain                                  = -1
      + priority                                               = "Regular"
      + private_ip_address                                     = (known after apply)
      + private_ip_addresses                                   = (known after apply)
      + provision_vm_agent                                     = true
      + public_ip_address                                      = (known after apply)
      + public_ip_addresses                                    = (known after apply)
      + resource_group_name                                    = "project-resource"
      + size                                                   = "Standard_D2s_v3"
      + tags                                                   = {
          + "Enviroment"  = "production"
          + "ProjectName" = "project"
        }
      + virtual_machine_id                                     = (known after apply)

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + name                      = (known after apply)
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "UbuntuServer"
          + publisher = "Canonical"
          + sku       = "18.04-LTS"
          + version   = "latest"
        }
    }

  # azurerm_linux_virtual_machine.main[1] will be created
  + resource "azurerm_linux_virtual_machine" "main" {
      + admin_password                                         = (sensitive value)
      + admin_username                                         = "Admin-username"
      + allow_extension_operations                             = true
      + availability_set_id                                    = (known after apply)
      + bypass_platform_safety_checks_on_user_schedule_enabled = false
      + computer_name                                          = (known after apply)
      + disable_password_authentication                        = false
      + extensions_time_budget                                 = "PT1H30M"
      + id                                                     = (known after apply)
      + location                                               = "eastus"
      + max_bid_price                                          = -1
      + name                                                   = "project-vm-2"
      + network_interface_ids                                  = (known after apply)
      + patch_assessment_mode                                  = "ImageDefault"
      + patch_mode                                             = "ImageDefault"
      + platform_fault_domain                                  = -1
      + priority                                               = "Regular"
      + private_ip_address                                     = (known after apply)
      + private_ip_addresses                                   = (known after apply)
      + provision_vm_agent                                     = true
      + public_ip_address                                      = (known after apply)
      + public_ip_addresses                                    = (known after apply)
      + resource_group_name                                    = "project-resource"
      + size                                                   = "Standard_D2s_v3"
      + tags                                                   = {
          + "Enviroment"  = "production"
          + "ProjectName" = "project"
        }
      + virtual_machine_id                                     = (known after apply)

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + name                      = (known after apply)
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "UbuntuServer"
          + publisher = "Canonical"
          + sku       = "18.04-LTS"
          + version   = "latest"
        }
    }

[...]

Plan: 13 to add, 0 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

Saved the plan to: solution.plan

To perform exactly these actions, run the following command to apply:
    terraform apply "solution.plan"
```

### 4. Terraform Apply

```sh
~/Deploying_a_Web_Server_in_Azure$ terraform apply solution.plan 
azurerm_resource_group.main: Creating...
╷
│ Error: creating Resource Group "project-resource": resources.GroupsClient#CreateOrUpdate: Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: Service returned an error. Status=403 Code="AuthorizationFailed" Message="The client 'odl_user_241797@udacityhol.onmicrosoft.com' with object id 'abc803fd-4e46-49c1-af9e-95196208552b' does not have authorization to perform action 'Microsoft.Resources/subscriptions/resourcegroups/write' over scope '/subscriptions/fe543d6c-d65a-4f94-99e0-886fb95f57dd/resourcegroups/project-resource' or the scope is invalid. If access was recently granted, please refresh your credentials."
│ 
│   with azurerm_resource_group.main,
│   on main.tf line 8, in resource "azurerm_resource_group" "main":
│    8: resource "azurerm_resource_group" "main" {
  ```

## Conclusion

Thank you for exploring this project! We hope you find it valuable for your infrastructure management needs. If you have any questions, encounter issues, or wish to contribute, please don't hesitate to reach out. Happy deploying! 🚀
