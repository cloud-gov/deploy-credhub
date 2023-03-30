terraform {
  backend "s3" {
  }
}

provider "credhub" {
  credhub_server = var.credhub_server
  client_id      = var.credhub_client_id
  client_secret  = var.credhub_client_secret
}

resource "credhub_user" "concourse_pages_user" {
  name            = "concourse_pages_user"
  username        = "concourse-pages-user"
}

resource "credhub_permission" "credhub_pages_concourse_permission" {
  path       = "/concourse/pages/*"
  actor      = var.credhub_pages_concourse_client_actor
  operations = ["read", "write", "delete"]
}

resource "credhub_permission" "doomsday_readonly" {
  path       = "/*"
  actor      = var.doomsday_readonly_actor
  operations = ["read"]
}

resource "credhub_permission" "pgp" {
  path       = "/concourse/main/cloud-gov-pgp-keys"
  actor      = var.pgp_credhub_actor
  operations = ["read","write","delete"]
}

resource "credhub_permission" "pages_gpg" {
  path       = "/concourse/pages/cloud-gov-pages-gpg-keys"
  actor      = var.pgp_credhub_actor
  operations = ["read","write","delete"]
}
