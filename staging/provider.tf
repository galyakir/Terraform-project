terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
//    bucket = "web-app-bucket-gal"
//    key = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  profile = "default"
  region = var.region
}