# Terraform CLI


| Sub | Command |
| ------ | ------ |
| init | terraform init |
| plan | terraform plan |
| apply | terraform apply |
| refresh | terraform refresh |
| destroy | terraform destroy |
| format | terraform format |
| validate | terraform validate |
| show | terraform show |
| import | terraform import |
| force-unlock | terraform force-unlock |
| graph | terraform graph |
| output | terraform output |


## Terraform Init

The `terraform init` command is used to initialize a working directory containing Terraform configuration files.

During init, the configuration is searched for module blocks, and the source code for referenced modules is retrieved from the locations given in their source arguments.
Terraform must initialize the provider before it can be used.

Initialization downloads and installs the provider's plugin so that it can later be executed.

It will not create any sample files like example.tf


## Terraform Plan

The `terraform plan` command is used to create an execution plan.

It will not modify things in infrastructure.

Terraform performs a refresh, unless explicitly disabled, and then determines what actions are necessary to achieve the desired state specified in the configuration files.

This command is a convenient way to check whether the execution plan for a set of changes matches your expectations without making any changes to real resources or to the state.


## Terraform Apply

The `terraform apply` command is used to apply the changes required to reach the desired state of the configuration.


Terraform apply will also write data to the terraform.tfstate file.


Once apply is completed, resources are immediately available.

## Terraform Refresh

The `terraform refresh` command is used to reconcile the state Terraform knows about (via its state file) with the real-world infrastructure.

This does not modify infrastructure but does modify the state file.


## Terraform Destroy


The terraform destroy command is used to destroy the Terraform-managed infrastructure.

`terraform destroy` command is not the only command through which infrastructure can be destroyed.



## Terraform Format

The terraform fmt command is used to rewrite Terraform configuration files to a canonical format and style.

For use-case, where the all configuration written by team members needs to have a proper style of code, `terraform fmt` can be used.


## Terraform Validate

The terraform validate command validates the configuration files in a directory.

Validate runs checks that verify whether a configuration is syntactically valid and thus primarily useful for general verification of reusable modules, including the correctness of attribute names and value types.

It is safe to run this command automatically, for example, as a post-save check in a text editor or as a test step for a reusable module in a CI system. It can run before `terraform plan`.

Validation requires an initialized working directory with any referenced plugins and modules installed


## Terraform Show

When you applied your configuration, Terraform wrote data into a file called terraform.tfstate. This file now contains the IDs and properties of the resources Terraform created.

Inspect the current state using `terraform show`

## Terraform Import

Terraform is able to import existing infrastructure. 

This allows you to take resources that you've created by some other means and bring it under Terraform management.

The current implementation of Terraform import can only import resources into the state. It does not generate configuration.

Because of this, prior to running terraform import, it is necessary to write a resource configuration block manually for the resource, to which the imported object will be mapped.

```sh
terraform import aws_instance.myec2 instance-id
```

## Terraform Lock


If supported by your backend, Terraform will lock your state for all operations that could write state.

Terraform has a force-unlock command to manually unlock the state if unlocking failed.

```sh
terraform force-unlock LOCK_ID [DIR]
```


## Terraform Graph


The `terraform graph` command is used to generate a visual representation of either a configuration or execution plan

The output of terraform graph is in the DOT format, which can easily be converted to an image


## Terraform Output

The `terraform output` command is used to extract the value of an output variable from the state file.


