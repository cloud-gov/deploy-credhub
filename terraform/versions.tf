terraform {
  required_version = ">= 0.14"
  required_providers {
    credhub = {
      source  = "orange-cloudfoundry/credhub"
      version = "0.14.0"
    }
  }
}
