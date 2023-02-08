output "droplet_public_ip" {
  value = digitalocean_droplet.droplet.ipv4_address
}