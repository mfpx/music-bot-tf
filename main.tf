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

      # Clone the GitHub repository
      git clone https://github.com/your-username/your-repo.git
      cd your-repo

      # Install Python dependencies
      pip3 install -r requirements.txt

      # Run the Python application
      python3 app.py
    EOF
}

# Define the secret environment variables
variable "secret_variable_1" {
  description = "Secret environment variable 1"
  type        = string
}

variable "secret_variable_2" {
  description = "Secret environment variable 2"
  type        = string
}