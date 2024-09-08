terraform {
  backend "s3" {
    bucket         = "terraform-prod-bucket"
    key            = "prod/terraform.tfstate"
    dynamodb_table = "terraform-lock-prod"
    region = "us-east-1"
  }
}

