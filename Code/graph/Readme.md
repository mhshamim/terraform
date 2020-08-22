### GraphiViz Documentation Referred in Course:

https://graphviz.gitlab.io/download/

### graph.tf
```sh
provider "aws" {
  region     = "us-west-2"
  access_key = "YOUR-ACCESS-KEY"
  secret_key = "YOUR-SECRET-KEY"
}

resource "aws_instance" "myec2" {
   ami = "ami-082b5a644766e0e6f"
   instance_type = "t2.micro"
}

resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  vpc      = true
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.lb.private_ip}/32"]

  }
}
```



### Commands Used:
```sh
terraform graph > graph.dot
yum install graphviz
cat graph.dot | dot -Tsvg > graph.svg
```


### Graph Initialize (Windows)

```sh
C:\>cd "\Program Files\Graphviz 2.44.1\bin"

C:\Program Files\Graphviz 2.44.1\bin>.\dot -c

C:\Program Files\Graphviz 2.44.1\bin>.\dot -v
dot - graphviz version 2.44.1 (20200629.0846)
libdir = "C:\Program Files\Graphviz 2.44.1\bin"
Activated plugin library: gvplugin_dot_layout.dll
Using layout: dot:dot_layout
Activated plugin library: gvplugin_core.dll
Using render: dot:core
Using device: dot:dot:core
The plugin configuration file:
        C:\Program Files\Graphviz 2.44.1\bin\config6
                was successfully loaded.
    render      :  cairo dot dot_json fig gdiplus json json0 map mp pic ps svg tk vml xdot xdot_json
    layout      :  circo dot fdp neato nop nop1 nop2 osage patchwork sfdp twopi
    textlayout  :  textlayout
    device      :  bmp canon cmap cmapx cmapx_np dot dot_json emf emfplus eps fig gif gv imap imap_np ismap jpe jpeg jpg json json0 metafile mp pdf pic plain plain-ext png ps ps2 svg tif tiff tk vml xdot xdot1.2 xdot1.4 xdot_json
    loadimage   :  (lib) bmp eps gif jpe jpeg jpg png ps svg

```

### Graph Command (Windows)

```sh
PS C:\> Get-Content -Path graph.dot
digraph {
        compound = "true"
        newrank = "true"
        subgraph "root" {
                "[root] aws_eip.lb (expand)" [label = "aws_eip.lb", shape = "box"]
                "[root] aws_instance.myec2 (expand)" [label = "aws_instance.myec2", shape = "box"]
                "[root] aws_security_group.allow_tls (expand)" [label = "aws_security_group.allow_tls", shape = "box"]
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" [label = "provider[\"registry.terraform.io/hashicorp/aws\"]", shape = "diamond"]
                "[root] aws_eip.lb (expand)" -> "[root] aws_instance.myec2 (expand)"
                "[root] aws_instance.myec2 (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
                "[root] aws_security_group.allow_tls (expand)" -> "[root] aws_eip.lb (expand)"
                "[root] meta.count-boundary (EachMode fixup)" -> "[root] aws_security_group.allow_tls (expand)"
                "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_security_group.allow_tls (expand)"
                "[root] root" -> "[root] meta.count-boundary (EachMode fixup)"
                "[root] root" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)"
        }
}

PS C:\> Get-Content -Path graph.dot | .\dot.exe -Tsvg > graph.svg

```
