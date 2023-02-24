locals {
  file_content = templatefile("${path.module}/templates/credentials.tpl", {
    devs      = var.devs,
    ip_addrs  = digitalocean_droplet.droplet,
    domains   = aws_route53_record.domain,
    passwords = random_string.password,
  })
}