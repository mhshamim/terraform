## local-exec Provisioner

local-exec provisioners allow us to invoke local executable after resource is created

One of the most used approaches of local-exec is to run ansible-playbooks on the created server after the resource is created.

#### Example

```sh
resource "aws_instance" "web" {
    # ...

    provisioner "local-exec" {
        command = "echo ${aws_instance.web.private_ip} >> private_ips.txt
    }
}
```

##### local-exec.tf

```sh
resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"

   provisioner "local-exec" {
    command = "echo ${aws_instance.myec2.private_ip} >> private_ips.txt"
  }
}
```


## remote-exec Provisioner

Remote-exec provisioners allow invoking scripts directly on the remote server.

#### Example

```sh
resource "aws_instance" "web" {
  # ...

  provisioner "remote-exec" {
                         .....
  }
}
```

##### remote-exec.tf

```sh
resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
   key_name = "terraform-labs"

   provisioner "remote-exec" {
     inline = [
       "sudo amazon-linux-extras install -y nginx1.12",
       "sudo systemctl start nginx"
     ]

   connection {
     type = "ssh"
     user = "ec2-user"
     private_key = file("./terraform-labs.pem")
     host = self.public_ip
   }
   }
}
```
