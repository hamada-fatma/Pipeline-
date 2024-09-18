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
  profile = "sandbox"
  region  = "us-east-1"
  
}




 resource "aws_ecr_repository" "my_app_repo" {
   name = "projet1/node-app"
 }


