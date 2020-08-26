# Terraform Registry

The Terraform Registry is a repository of modules written by the Terraform community. 

The registry can help you get started with Terraform more quickly
 

### Module Location

If we intend to use a module, we need to define the path where the module files are present.

The module files can be stored in multiple locations, some of these include:

●	Local Path
●	GitHub
●	Terraform Registry
●	S3 Bucket
●	HTTP URLs


### Verified Modules in Terraform Registry

Within Terraform Registry, you can find verified modules that are maintained by various third-party vendors.

These modules are available for various resources like AWS VPC, RDS, ELB, and others

Verified modules are reviewed by HashiCorp and actively maintained by contributors to stay up-to-date and compatible with both Terraform and their respective providers.

The blue verification badge appears next to modules that are verified.

Module verification is currently a manual process restricted to a small group of trusted HashiCorp partners.


### Using Registry Modules in Terraform

To use Terraform Registry module within the code, we can make use of the source argument that contains the module path.

Below code references to the EC2 Instance module within terraform registry.

> Copy and paste into your Terraform configuration, insert the variables, and run `terraform init` :

```sh
module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.15.0"
  # insert the 10 required variables here
}
```


### Terraform Registry URL:

https://registry.terraform.io/

### Demo Code:

```sh
provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "my-cluster"
  instance_count         = 1

  ami                    = "ami-0d6621c01e8c2de2c"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-4dbfb206"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```