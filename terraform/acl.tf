provider "credhub" {
}

resource "credhub_permission" "testuser_acl" {
  path       = "/a/path/*"
  actor      = "uaa-user:dc912b22-test-4780-blah-aa5843f81868"
  operations = ["read", "write", "delete"]
}
