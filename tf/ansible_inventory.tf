

data "template_file" "ansible_inventory" {
  template = <<EOF
[jumpbox]
jumpbox1 ansible_host=${digitalocean_droplet.jumpbox1.ipv4_address}

[all:vars]
ansible_user = root
ansible_ssh_private_key_file = tf/id_rsa
EOF
}
resource "local_file" "ansible_inventory" {
    content = data.template_file.ansible_inventory.rendered
    filename = "${path.module}/../ansible_inventory"
}



data "template_file" "kubeconfig" {
  template = <<EOF
${digitalocean_kubernetes_cluster.k8s.kube_config[0].raw_config}
EOF
}
resource "local_file" "kubeconfig" {
    content = data.template_file.kubeconfig.rendered
    filename = "${path.module}/../kubeconfig"
}

