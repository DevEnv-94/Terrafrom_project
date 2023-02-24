data "digitalocean_ssh_key" "rebrain_ssh_key" {
  name = var.rebrain_ssh_key_name
}

resource "digitalocean_ssh_key" "ssh_key" {
  name       = var.ssh_public_key_name
  public_key = file(var.ssh_public_key_path)
}

resource "random_string" "password" {
  count            = length(var.devs)
  length           = 15
  special          = true
}

resource "digitalocean_droplet" "droplet" {
  count         = length(var.devs)
  image         = var.image_name 
  name          = var.devs[count.index].prefix
  region        = var.region_name 
  size          = var.droplet_size 
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
      "useradd -s /bin/bash -m ${var.devs[count.index].your_login}",
      "usermod -aG sudo ${var.devs[count.index].your_login}",
      "echo '${var.devs[count.index].your_login}:${random_string.password[count.index].result}' | chpasswd",
      "mkdir /home/${var.devs[count.index].your_login}/.ssh",
      "cp /root/.ssh/authorized_keys /home/${var.devs[count.index].your_login}/.ssh/",
      "chown -R ${var.devs[count.index].your_login}:${var.devs[count.index].your_login} /home/${var.devs[count.index].your_login}/.ssh",
      "chmod 700 /home/${var.devs[count.index].your_login}/.ssh",
      "chmod 600 /home/${var.devs[count.index].your_login}/.ssh/authorized_keys",
    ]
  }
}

data "aws_route53_zone" "dns_zone" {
  name = var.dns_zone_name
}

resource "aws_route53_record" "domain" {
  count   = length(var.devs)
  zone_id = data.aws_route53_zone.dns_zone.zone_id
  name    = "${var.devs[count.index].your_login}-${var.devs[count.index].prefix}"
  type    = "A"
  ttl     = 300
  records = [digitalocean_droplet.droplet[count.index].ipv4_address]
}

resource "local_file" "example" {
  content  = local.file_content
  filename = "credentials.txt"
}