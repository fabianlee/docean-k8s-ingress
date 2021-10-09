terraform {
  required_version = ">= 0.14"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


# instance of the provider using personal token for access
provider "digitalocean" {
  token = var.do_token
}

# name of ssh key for cluster/droplets
data "digitalocean_ssh_key" "terraform" {
  name = "id_rsa"
}
