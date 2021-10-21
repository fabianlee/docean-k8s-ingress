
# digitalocean personal token, passed in as env var
variable "do_token" {}

# kubernetes major/minor version
variable k8s_version_prefix { default="1.21." }

# name and region for k8s cluster
variable k8s_cluster_name { default="mycluster1" }
variable do_region { default="nyc3" }
