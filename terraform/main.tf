terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "frontend" {
  source = "./frontend"
}

module "eks" {
  source = "./eks"
}

module "database" {
  source = "./database"
}



