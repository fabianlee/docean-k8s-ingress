

data "template_file" "kubeconfig" {
  template = <<EOF
${digitalocean_kubernetes_cluster.k8s.kube_config[0].raw_config}
EOF
}
resource "local_file" "kubeconfig" {
    content = data.template_file.kubeconfig.rendered
    filename = "${path.module}/../kubeconfig"
}

