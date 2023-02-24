# Developers' Environment with Terraform

The purpose of this project is to gain hands-on experience with Terraform. It contains a Terraform project that automates the creation of infrastructure environments for developers.

### Instructions

1. Start by cloning this repository using `git clone`.

2. Check the variables and define them in the terraform.tfvars.sample file. After the "#" symbol, you will find an example value for each variable. Create your own terraform.tfvars file with your own values.

```bash
do_token             = ""
ssh_public_key_path  = ""
ssh_public_key_name  = ""
rebrain_ssh_key_name = ""
droplet_tags         = ["",""]
aws_access_key       = ""
aws_secret_key       = ""
dns_zone_name        = ""
ssh_private_key_path = ""
image_name           =# "ubuntu-20-04-x64"
region_name          =# "fra1"
droplet_size         =# "s-1vcpu-1gb"
devs                 =# [
    {
      prefix     = "db"
      your_login = "Marty_McFly"
    },
    {
      prefix     = "lb"
      your_login = "Sarah_Connor"
    }
  ]
```

3. Run `terraform init`.

4. Run `terraform apply`.

5. That's it! You have successfully created your development environment. All the credentials you need are stored in the `credentials.txt` file.