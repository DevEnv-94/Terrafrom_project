output "public_ip" {
  value = digitalocean_droplet.droplet.ipv4_address
}

output "my_domain_name" {
  value = aws_route53_record.domain.fqdn
}