terraform {
  backend "s3" {
  }
}

provider "credhub" {
}

resource "credhub_user" "concourse_pages_user" {
  name            = "concourse_pages_user"
  username        = "concourse-pages-user"
}

resource "credhub_permission" "concourse_pages_permission" {
  path       = "/concourse/pages/*"
  actor      = "uaa-user:dc912b22-test-4780-blah-aa5843f81868"
  operations = ["read", "write", "delete"]
}
