terraform {
  required_version = ">= 0.14"
  required_providers {
    credhub = {
      version = "0.13.3"
      source  = "local/providers/credhub"
    }
  }
}
