terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.5"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.4"
    }
  }
  backend "s3" {
    encrypt        = true
    bucket         = "tfstate-backend-aym-2025"
    region         = "us-east-1"
    key            = "terraform.tfstate"
    use_lockfile   = true

  
}
required_version = "~> 1.3"
}

