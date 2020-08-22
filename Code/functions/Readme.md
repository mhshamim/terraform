
### functions.tf

```sh
provider "aws" {
  region     = var.region
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

locals {
  time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

variable "region" {
  default = "ap-south-1"
}

variable "tags" {
  type = list
  default = ["firstec2","secondec2"]
}

variable "ami" {
  type = map
  default = {
    "us-east-1" = "ami-0323c3dd2da7fb37d"
    "us-west-2" = "ami-0d6621c01e8c2de2c"
    "ap-south-1" = "ami-0470e33cd681b2476"
  }
}

resource "aws_key_pair" "loginkey" {
  key_name   = "login-key"
  public_key = file("${path.module}/id_rsa.pub")
}

resource "aws_instance" "app-dev" {
   ami = lookup(var.ami,var.region)
   instance_type = "t2.micro"
   key_name = aws_key_pair.loginkey.key_name
   count = 2

   tags = {
     Name = element(var.tags,count.index)
   }
}


output "timestamp" {
  value = local.time
}
```

### The id_rsa.pub file
```sh
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8qO8KcNnKUm04ZC7H5s0WyJwpo/bxG/kJovGUqSz6ViEAhVxC9Tq/piJ9Kk9IUEOkfAjY8Yr5zn9ThRbOVJ4AEHTjSwIie7YMMLjN+OdTn8+cqnfh9RNN3633ixGVP9CpbiDiB7gMsZ78Q2ps/gcxQuuW1XSt8Y0jcgHL0KJQsjU0eS7vhGCjRQ9snrgJxYg+UYM8dOWINhbiVTQbydHGjcYUMZv6cWxZDQPyejObcFsmDY7UcD4ZnuzG/1VaSh+fXjNzqK6TjoY7ajH3F6WVW1Nbh6F/4hJipmT4Q5TxK51s28PCYveWZypc66PTw2D1WHerCXQbuSnMlqpwip/f root@46400bafe371
```
