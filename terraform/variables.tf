variable "credhub_client_id" {
  description = "The UAA client id used by the credhub"
  type        = string
  sensitive   = true
}

variable "credhub_client_secret" {
  description = "The UAA client secret used by credhub"
  type        = string
  sensitive   = true
}

variable "credhub_server" {
  description = "The credhub server domain"
  type        = string
}
