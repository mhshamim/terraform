# Terraform Workspace

Terraform allows us to have multiple workspaces, with each of the workspaces we can have a different set of environment variables associated

Terraform starts with a single workspace named "default".

This workspace is special both because it is the default and also because it cannot ever be deleted.

If you've never explicitly used workspaces, then you've only ever worked on the "default" workspace.

Workspaces are managed with the terraform workspace set of commands. 

To create a new workspace and switch to it, you can use `terraform workspace new`; to switch workspaces you can use `terraform workspace select`; etc.


### Terraform Workspace commands:
```sh
terraform workspace -h
terraform workspace show
terraform workspace new dev
terraform workspace new prd
terraform workspace list
terraform workspace select dev
```

### Terraform Based Configuration File
```sh
provider "aws" {
  region     = "ap-south-1"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
}
```

### Terraform Final Modified Configuration File
```sh
provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = lookup(var.instance_type,terraform.workspace)
}

variable "instance_type" {
  type = "map"

  default = {
    default = "t2.nano"
    dev     = "t2.micro"
    prd     = "t2.large"
  }
}
```
### Terraform tfstate files

Default workspace tfstate file will always be in the main folder. 

Whereas any other Workspace tfstate file will be created inside the `terraform.tfstate.d/<workspace name>` folder.


## Documentation Referred:

### Terraform Function - Lookup

https://www.terraform.io/docs/configuration/functions/lookup.html

