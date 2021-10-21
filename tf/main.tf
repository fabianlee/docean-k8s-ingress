
data "digitalocean_kubernetes_versions" "example" {
  version_prefix = var.k8s_version_prefix
}

resource "digitalocean_kubernetes_cluster" "k8s" {
  name   = var.k8s_cluster_name
  region = var.do_region
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = data.digitalocean_kubernetes_versions.example.latest_version

  # network
  vpc_uuid = digitalocean_vpc.myvpc.id

  node_pool {
    name       = "nodepool"
    size       = "s-4vcpu-8gb"
    node_count = 1

  }
}
