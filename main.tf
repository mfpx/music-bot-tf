terraform {
  required_version = ">= 1.5"

  backend "remote" {
    organization = "plebnet"  # Organisation

    workspaces {
      name = "music-bot"  # Workspace
    }
  }

  required_providers {
    aws = {
      source  = "aws"
      version = "~> 2"
    }
  }
}

provider "aws" {
  region = var.aws_region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

resource "aws_instance" "container_info" {
  ami           = "ami-0eb260c4d5475b901"  # Ubuntu
  instance_type = "t2.micro" # Tiny, but we don't need anything bigger

  tags = {
    Name = var.container_name
  }

  # Gives us a public IP
  associate_public_ip_address = true

    user_data = <<-EOF
      #!/bin/bash

      # Install required packages or run any desired commands
      sudo apt-get update
      sudo apt-get install -y git

      # We're in fs root, so go to home
      cd /home/ubuntu

      # Clone the GitHub repository
      git clone https://github.com/mfpx/music-bot.git
      cd music-bot

      # Append public keys
      cat public_keys | tee -a /home/ubuntu/.ssh/authorized_keys > /dev/null

      # Make the setup script executable
      chmod +x setup_env.sh

      # Setup the variables
      export BOT_TOKEN=${var.token}
      export PERMISSIONS=${var.permissions}
      export APP_ID=${var.application_id}
      export CLIENT_ID=${var.client_id}

      # Run the setup script
      sudo ./setup_env.sh -i true

      # Run the bot
      .venv/bin/python bot.py
    EOF
}