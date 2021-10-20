
# digitalocean personal token, passed in as env var
variable "do_token" {}
# ssh login key for jumpbox
variable "pvt_key" { default="./id_rsa" }
variable do_jumpbox_image { default="ubuntu-20-04-x64" }

variable do_vpc_cidr { default="10.10.10.0/24" }
variable k8s_version_prefix { default="1.21." }
variable k8s_cluster_name { default="mycluster1" }
variable do_region { default="nyc3" }
