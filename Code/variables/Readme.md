
## Terraform Variables

### varsdemo.tf
```sh
resource "aws_security_group" "var_demo" {
  name        = "kplabs-variables"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }
}
```
### variables.tf

```sh
variable "vpn_ip" {
  default = "116.50.30.50/32"
}
```

## Approaches for Variable Assignments

### Default File used

```sh
provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro
}
```
### variables.tf
```sh
variable "instancetype" {
  default = "t2.micro"
}
```
### custom.tfvars
```sh
instancetype="t2.large"
```

### terraform.tfvars
```sh
instancetype="t2.large"
```

### CLI Commands

```sh
terraform plan -var="instancetype=t2.small"
terraform plan -var-file="custom.tfvars"
```

### Environment Variables:

### Windows Approach:
```sh
setx TF_VAR_instancetype t2.large
```
### Linux / MAC Approach
```sh
export TF_VAR_instancetype="t2.nano"
echo $TF_VAR
```


## DATA TYPE for variables

### ec2_datatype.tf

```sh
provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

resource "aws_iam_user" "lb" {
  name = var.usernumber
  path = "/system/"
}

```
### elb.tf

Documentation:  https://www.terraform.io/docs/providers/aws/r/elb.html

Final Code:

```sh
provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

resource "aws_elb" "bar" {
  name               = var.elb_name
  availability_zones = var.az

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = var.timeout
  connection_draining         = true
  connection_draining_timeout = var.timeout

  tags = {
    Name = "foobar-terraform-elb"
  }
}
```
### variables.tf

```sh

variable "usernumber" {
  type = number
}

variable "elb_name" {
  type = string
}

variable "az" {
  type = list
}

variable "timeout" {
  type = number
}
```
### terraform.tfvars
```sh
elb_name="myelb"
timeout="400"
az=["us-west-1a","us-west-1b"]
```
