provider "digitalocean" {
  token = "${var.digitalocean_token}"
}

resource "template_file" "cloud-config" {
  filename = "cloud-config.yml"
  vars {
    discovery_url = "${var.discovery_url}"
  }
}

resource "digitalocean_droplet" "node" {
  count = 3
  image = "coreos-stable"
  name = "coreos-yourlibrary"
  region = "sgp1"
  size = "1gb"
  ssh_keys = ["${var.ssh_key_id}"]
  private_networking = true
  user_data = "${template_file.cloud-config.rendered}"
}
