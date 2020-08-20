
### Desired and Current State

i) Desired State: EC2 = instance_type = "t2.micro"

ii) Current State: EC2 = "instance_state": "stopped" && "instance_type" = "t2.nano"

Desired State == Current State


### Different Version Parameters
```sh
version    = "2.7"
version    = ">= 2.8"
version    = "<= 2.8"
version    = ">=2.10,<=2.30"
```

#### Base Configuration - provider.versioning.tf

```sh
provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
  version    = ">=2.10,<=2.30"
}

resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
}
```
