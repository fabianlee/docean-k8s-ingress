#output "jumpbox1_public" {
#  value = digitalocean_droplet.jumpbox1.ipv4_address
#}

output "k8s_kubeconfig" {
  sensitive = true
  value = digitalocean_kubernetes_cluster.k8s.kube_config[0].raw_config
}

