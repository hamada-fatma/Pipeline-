 terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# AWS Provider configuration
provider "aws" {
  #profile = "sandbox"
  region  = "us-east-1"
  
}






