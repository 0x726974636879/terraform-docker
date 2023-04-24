# Terraform Configuration for Node-RED, InfluxDB, and Graphana Containers

This Terraform project allows for easy deployment of Docker containers for Node-RED, InfluxDB, and Graphana services on an infrastructure.

## Prerequisites

- Terraform 0.14.x or higher installed on your local machine.
- An AWS account with the necessary permissions to create and manage resources.
- Docker 23.x.x or higher installed on your local machine.
- 2 terraform worspace (`dev` & `prod`)
- A `.tfvars` variable file at the root of the project containing the variables needed for your environment.
- `tflint` installed on your local machine if you plan to make modifications to the infrastructure. `tflint` is an optional tool that checks the quality of your Terraform code and reports potential errors, ([documentation here](https://github.com/terraform-linters/tflint)).

## Variables

Before deploying the infrastructure, you must create a `.tfvars` variable file at the root of the project. This file should contain the types for the following variables:

```
int_port = {
  nodered  = 1880
  influxdb = 8086
  graphana = 3000
}

ext_port = {
  nodered = {
    dev  = [1980]
    prod = [1880]
  }
  influxdb = {
    dev  = [8186]
    prod = [8086]
  }
  graphana = {
    dev  = [3100]
    prod = [3000]
  }
}
```
Constraints:
* nodered:
    * internal port must be 1880
    * dev, each external port must be superior or equal to 1980 and inferior to 3100.
    * prod, each external port must be superior or equal to 1880 and inferior to 1980.
* infludb:
    * internal port must be 8086
    * dev - each external port must be superior or equal to 8186 and inferior to 65535.
    * prod - each external port must be superior or equal to 8086 and inferior to 8186.
* graphana:
    * internal port must be 3000
    * dev - each external port must be superior or equal to 3100 and inferior to 8085.
    * prod - each external port must be superior or equal to 3000 and inferior to 3100.

These port configurations are used to deploy Docker containers for the Node-RED, InfluxDB, and Graphana services on an infrastructure. The internal ports are the ports used by the containers themselves, while the external ports are the ports used to access the services from outside the containers.

## Deployment

To deploy the infrastructure, run the following commands:

```
terraform init
terraform apply -var-file=<variable_file_name>.tfvars
```

Make sure to replace `<variable_file_name>` with the name of your `.tfvars` variable file.

## Cleanup

To remove the infrastructure, run the following command:

```
terraform destroy -var-file=<variable_file_name>.tfvars
```

Make sure to replace `<variable_file_name>` with the name of your `.tfvars` variable file.

Also, make sure to verify that all resources have been properly removed after running the `terraform destroy` command.

## Modifying the Infrastructure

When making changes to the Terraform code, it's important to ensure that the code is properly formatted, validated, and of good quality before deploying it to the infrastructure. To do this, we recommend using the following command:

```
terraform fmt -recursive && terraform validate && tflint && terraform plan
```

Here's what each of these commands does:

- `terraform fmt -recursive`: This command formats the Terraform code to be readable and consistent. It's recommended to run this command before validating and planning the infrastructure to avoid syntax errors.
- `terraform validate`: This command checks the syntax and semantics of the Terraform code and reports potential errors. It's recommended to run this command after the `terraform fmt` command.
- `tflint`: This command checks the quality of the Terraform code and reports potential errors. It's recommended to run this command after the `terraform validate` command.
- `terraform plan`: This command simulates the execution of changes on the infrastructure and displays the actions that will be taken. It's recommended to run this command after the `terraform fmt`, `terraform validate`, and `tflint` commands.