
resource "digitalocean_vpc" "myvpc" {
  name     = "myvpc-network"
  region   = var.do_region
  ip_range = var.do_vpc_cidr
}

resource "digitalocean_droplet" "jumpbox1" {
  image = var.do_jumpbox_image
  name = "jumpbox1"
  region = var.do_region
  size = "s-1vcpu-1gb"
  # without definition, will be placed into default VPC
  vpc_uuid = digitalocean_vpc.myvpc.id
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]

  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    # had errors until using agent=false, "Error connecting to SSH_AUTH_SOCK: dial unix"
    agent = false
    private_key = file(var.pvt_key)
    timeout = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt update"
      #"sleep 8",
      #"sudo apt install -y curl"
    ]
  }
}
