terraform {
  backend "s3" {
  }
}

provider "credhub" {
  credhub_server = var.credhub_server
  client_id      = var.credhub_client_id
  client_secret  = var.credhub_client_secret
}

resource "credhub_permission" "testuser_acl" {
  path       = "/a/path/*"
  actor      = "uaa-user:dc912b22-test-4780-blah-aa5843f81868"
  operations = ["read", "write", "delete"]
}
