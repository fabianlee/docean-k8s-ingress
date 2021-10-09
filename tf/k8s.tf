
data "digitalocean_kubernetes_versions" "example" {
  version_prefix = "1.21."
}

resource "digitalocean_kubernetes_cluster" "k8s" {
  name   = "mycluster1"
  region = "nyc3"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = data.digitalocean_kubernetes_versions.example.latest_version # 1.21.3-do.0

  # network
  vpc_uuid = digitalocean_vpc.myvpc.id

  node_pool {
    name       = "nodepool"
    size       = "s-4vcpu-8gb"
    node_count = 1

  }
}
