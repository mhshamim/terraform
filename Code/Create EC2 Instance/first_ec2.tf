provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

resource "aws_instance" "myec2" {
   ami = "ami-0873b46c45c11058d"
   instance_type = "t2.micro"
   tags = {
    Name = "my_aws_instance"
  }
}
