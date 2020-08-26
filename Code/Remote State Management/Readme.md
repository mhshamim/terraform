# Remote State Management 

Terraform supports various types of remote backends which can be used to store state data.

As of now, we were storing state data in local and GIT repository.

Depending on remote backends that are being used,  there can be various features.

* Standard BackEnd Type:  State Storage and Locking
* Enhanced BackEnd Type:  All features of Standard + Remote Management

In the ideal scenario, your terraform configuration code should be part of the centralized Git repositories and state file should be part of the remote backends.

During our demo, we had made use of S3 Backend to store our state file. Following is the sample configuration file for the S3 backend:

#### state-management.tf

```sh
terraform {
  backend "s3" {
    bucket = "labs-remote-backends"
    key    = "demo.tfstate"
    region = "us-east-1"
    access_key = "YOUR-ACCESS-KEY"
    secret_key = "YOUR-SECRET-KEY"
  }
}
```

## State File Locking

Whenever you are performing a write operation, terraform would lock the state file.

This is very important as otherwise during your ongoing terraform apply operations, if others also try for the same, it would corrupt your state file.

Example:

●	Person A is terminating the RDS resource which has associated rds.tfstate file
●	Person B has now tried resizing the same RDS resource at the same time.


As currently the few remote-backend does not support state file locking by default, therefore choose the remote-backend which support state file locking and configure the same in the code.

For the S3 backend, you can make use of the DynamoDB for state file locking functionality.


#### backend.tf

```sh
terraform {
  backend "s3" {
    bucket = "kplabs-remote-backend"
    key    = "remotedemo.tfstate"
    region = "us-west-1"
    access_key = "YOUR-ACCESS-KEY"
    secret_key = "YOUR-SECRET-KEY"
    dynamodb_table = "s3-state-lock"
  }
}
```

## Terraform State Management

As your Terraform usage becomes more advanced, there are some cases where you may need to modify the Terraform state.

It is important to never modify the state file directly. Instead, make use of terraform state command.

There are multiple sub-commands that can be used with terraform state, these include:

#### `terraform state`

| State Sub Command | Description |
| ------ | ------ |
| list | List resources within terraform state file |
| mv | Moves item with terraform state |
| pull | Manually download and output the state from remote state |
| push | Manually upload a local state file to remote state |
| rm | Temove items from the Terraform state |
| show | Show the attributes of a single resource in the state |


### Sub Command - List

The terraform state list command is used to list resources within a Terraform state.

```sh
terraform state list
``` 

### Sub Command - Move

The terraform state mv command is used to move items in a Terraform state.

This command is used in many cases in which you want to rename an existing resource without destroying and recreating it.

Due to the destructive nature of this command, this command will output a backup copy of the state prior to saving any changes

```sh
terraform state mv [options] SOURCE DESTINATION
```

### Sub Command - Pull

The terraform state pull command is used to manually download and output the state from a remote state.

This is useful for reading values out of state (potentially pairing this command with something like jq).



### Sub Command - Push

The terraform state push command is used to manually upload a local state file to remote state.

This command should rarely be used.


### Sub Command - Remove

The terraform state rm command is used to remove items from the Terraform state.

Items removed from the Terraform state are not physically destroyed. 

Items removed from the Terraform state are only no longer managed by Terraform

For example, if you remove an AWS instance from the state, the AWS instance will continue running, but terraform plan will no longer see that instance.


### Sub Command - Show

The terraform state show command is used to show the attributes of a single resource in the Terraform state.


## Importing Existing Resources

It might happen that there is a resource that is already created manually.

In such a case, any change you want to make to that resource must be done manually.

Terraform is able to import existing infrastructure. This allows you to take resources you've created by some other means and bring it under Terraform management.

The current implementation of Terraform import can only import resources into the state. It does not generate configuration. A future version of Terraform will also generate configuration.

Because of this, prior to running terraform import it is necessary to write manually a resource configuration block for the resource, to which the imported object will be mapped.



#### ec2.tf
```sh
resource "aws_instance" "myec2" {
  ami = "ami-bf5540df"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-6ae7d613", "sg-53370035"]
  key_name = "remotepractical"
  subnet_id = "subnet-9e3cfbc5"

  tags {
    Name = "manual"
  }
}
```
#### providers.tf
```sh
provider "aws" {
  region = "us-west-1"
}

```

#### Command To Import Resource

```sh
terraform import aws_instance.myec2 i-041886ebb7e9bd20
```
