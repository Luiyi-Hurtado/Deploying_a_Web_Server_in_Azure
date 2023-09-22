# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction

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

### Instructions

#### 1. Login to Azure

* Open your terminal and run the following command to log in to Azure:

    ```bash
    az login
    ```

* Follow the prompts to complete the login process.

#### 2. Create an Azure Policy Definition

* Create an Azure Policy Definition using the following command. Replace ```<policy name>``` with your desired policy name and ```<filename>``` with the path to your policy definition rules file:

    ```bash
    az policy definition create --name <policy name>        --rules <filename>
    ```

#### 3. Build an Image with Packer

* Build a custom image using Packer by running the following command. Replace ```<filename>``` with the path to your Packer configuration file:

     ```bash
     Packer build <filename>
     ```

### 4. Destroy Resources

If you need to remove the resources created by Terraform, use the following command. Replace ```<filename>``` with the path to your execution plan file:

* Navigate to your Terraform configuration directory in the terminal.
* Run the following command to initialize Terraform:

     ```bash
     terraform init
     ```

### 5. Generate Terraform Execution Plan

* Create a Terraform execution plan by running the following command. Replace ```<filename>``` with the desired output file name for the execution plan:

     ```bash
     terraform plan -out <filename>
     ```

### 6. Apply Terraform Configuration

* Apply the Terraform configuration to create the resources in your Azure environment. Use the execution plan file generated in the previous step. Replace ```<filename>``` with the path to your execution plan file:

     ```bash
     terraform apply <filename>
     ```

### 7. View Terraform State

* To view the current state of your resources managed by Terraform, run the following command:

    ```bash
    terraform show
    ```

### 8. Destroy Resources

* If you need to remove the resources created by Terraform, use the following command. Replace ```<filename>``` with the path to your execution plan file:

     ```bash
     terraform destroy <filename>
     ```

### Output

**Your words here**
