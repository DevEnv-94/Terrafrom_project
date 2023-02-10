data "digitalocean_ssh_key" "rebrain_ssh_key" {
  name = var.rebrain_ssh_key_name
}

resource "digitalocean_ssh_key" "ssh_key" {
  name       = var.ssh_key_name
  public_key = file(var.ssh_key_path)
}

resource "digitalocean_droplet" "droplet" {
  image         = "ubuntu-20-04-x64"
  name          = "node"
  region        = "fra1"
  size          = "s-1vcpu-1gb"
  ssh_keys      = [digitalocean_ssh_key.ssh_key.fingerprint,data.digitalocean_ssh_key.rebrain_ssh_key.fingerprint]
  tags          = var.droplet_tags
}

data "aws_route53_zone" "dns_zone" {
  name = var.dns_zone_name
}

resource "aws_route53_record" "domain" {
  zone_id = data.aws_route53_zone.dns_zone.zone_id
  name    = "${var.sub_domain}.${data.aws_route53_zone.dns_zone.name}"
  type    = "A"
  ttl     = 300
  records = [digitalocean_droplet.droplet.ipv4_address]
}