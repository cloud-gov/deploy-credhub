# deploy-credhub

Concourse pipeline to bosh deploy credhub

## Setting up local terraform provider

With the update to terraform >v0.13, an update to the `.terraformrc` file will have to specify the local provider filesystem mirror.

Sample `.terraformrc`

```tf
# The example assumes you put all of you local providers in
# the directory at the path of `~/terraform-providers/local/providers/*`

provider_installation {
  filesystem_mirror {
    path    = "~/terraform-providers/"
    include = ["local/providers/*"]
  }
  direct {
    exclude = ["local/providers/*"]
  }
}
```

Next, you will need to add you local provider in the above path by `.../<NAME>/<VERSION>/<PLATFORM>/<PROVIDER_BUILD>`

Example provider path:
`~/terraform-providers/local/providers/credhub/0.13.3/linux_amd64/terraform-provider-credhub`

Finally, remember to source you local provider path for the provider in the `required_providers` block.

ie.
```tf
terraform {
  required_providers {
    credhub = {
      source  = "local/providers/credhub
      version = “0.13.3”
    }
  }
  ...
}
```
