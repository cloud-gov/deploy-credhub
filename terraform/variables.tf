# Variables
variable "credhub_pages_concourse_client_actor" {
  description = "The credhub client actor name. ie(uaa-client:my_client_name)"
  type        = string
}

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

variable "doomsday_readonly_actor" {
  description = "The credhub client actor name. ie(uaa-client:my_client_name)"
  type        = string
}

variable "pgp_credhub_actor" {
  description = "The credhub client actor name. ie(uaa-client:my_client_name)"
  type        = string
}

variable "opensearch_proxy_ci_credhub_actor" {
  description = "The credhub client actor name. ie(uaa-client:my_client_name)"
  type        = string
}

variable "pages_user_agent" {
  description = "The credhub client actor name. ie(uaa-client:my_client_name)"
  type        = string
}
variable "opensearch_ci_credhub_actor" {
  description = "The credhub client actor name. ie(uaa-client:my_client_name)"
  type        = string
}
