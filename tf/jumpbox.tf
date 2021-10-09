
resource "digitalocean_vpc" "myvpc" {
  name     = "myvpc-network"
  region   = "nyc3"
  ip_range = "10.10.10.0/24"
}

resource "digitalocean_droplet" "jumpbox1" {
  image = "ubuntu-20-04-x64"
  name = "jumpbox1"
  region = "nyc3"
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
    private_key = file(var.pvt_key)
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt update",
      "sudo apt install -y curl"
    ]
  }
}
