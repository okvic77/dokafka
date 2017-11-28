
variable "digitalocean_token" {}
variable "ssh_keys" {}
provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

