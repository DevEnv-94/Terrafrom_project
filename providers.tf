terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.26.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "4.53.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "aws" {
  region     = "eu-central-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}