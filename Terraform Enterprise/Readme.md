# Terraform Cloud & Enterprise Capabilities


## Overview of Terraform Cloud

Terraform Cloud manages Terraform runs in a consistent and reliable environment with various features like access controls, private registry for sharing modules, policy controls, and others.

Terraform Cloud is available as a hosted service at `https://app.terraform.io`

## Overview of Sentinel

Sentinel is an embedded policy-as-code framework integrated with the HashiCorp Enterprise products. 

It enables fine-grained, logic-based policy decisions, and can be extended to use information from external sources.

Note: Sentinel policies are paid feature 

**EXAMPLE:** Input validation depending on the name of the key.

**`sentinel-policy.tf`**

```sh
import "tfplan"

main = rule {
  all tfplan.resources.aws_instance as _, instances {
    all instances as _, r {
      (length(r.applied.tags) else 0) > 0
    }
  }
}
```


## Remote Backends

Terraform supports various types of remote backends which can be used to store state data.

As of now, we were storing state data in local and GIT repository.

Depending on remote backends that are being used,  there can be various features.

*	Standard BackEnd Type:  State Storage and Locking
*	Enhanced BackEnd Type:  All features of Standard + Remote Management

When using full remote operations, operations like terraform plan or terraform apply can be executed in Terraform Cloud's run environment, with log output streaming to the local terminal. 

Remote plans and applies use variable values from the associated Terraform Cloud workspace.

Terraform Cloud can also be used with local operations, in which case only state is stored in the Terraform Cloud backend.


> **[Remote Backend Code][df1]**

[df1]: <remote-backend.md>