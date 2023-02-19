data "digitalocean_ssh_key" "rebrain_ssh_key" {
  name = var.rebrain_ssh_key_name
}

resource "digitalocean_ssh_key" "ssh_key" {
  name       = var.ssh_key_name
  public_key = file(var.ssh_key_path)
}

resource "digitalocean_droplet" "droplet" {
  count         = var.droplets_count
  image         = "ubuntu-20-04-x64"
  name          = "node-${count.index+1}"
  region        = "fra1"
  size          = "s-1vcpu-1gb"
  ssh_keys      = [digitalocean_ssh_key.ssh_key.fingerprint,data.digitalocean_ssh_key.rebrain_ssh_key.fingerprint]
  tags          = var.droplet_tags

  connection {
    type = "ssh"
    user = "root"
    private_key = "${file(var.ssh_private_key_path)}"
    host = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'root:Password123' | chpasswd",
    ]
  }
}

data "aws_route53_zone" "dns_zone" {
  name = var.dns_zone_name
}

resource "aws_route53_record" "domain" {
  count   = var.domain_count
  zone_id = data.aws_route53_zone.dns_zone.zone_id
  name    = "${var.sub_domain}-${count.index+1}"
  type    = "A"
  ttl     = 300
  records = [local.droplets_public_ip[count.index]]
}
