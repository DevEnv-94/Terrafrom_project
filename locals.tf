locals {
  droplets_public_ip = digitalocean_droplet.droplet.*.ipv4_address
}