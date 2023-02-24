variable "droplet_tags" {
  type = list(string)
}

variable "rebrain_ssh_key_name" {
  type = string
}

variable "ssh_public_key_path" {
  type = string
}

variable "ssh_public_key_name" {
  type = string
}

variable "do_token" {
  type = string
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

variable "dns_zone_name" {
  type = string
}

variable "ssh_private_key_path" {
  type = string
}

variable "devs" {
  type = list(object({
    prefix     = string
    your_login = string
  }))
}

variable "image_name" {
  type = string
}

variable "region_name" {
  type = string
}

variable "droplet_size" {
  type = string
}
