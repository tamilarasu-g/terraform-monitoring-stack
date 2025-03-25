terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }

  backend "s3" {
    bucket = "test-tf-backend-state-bucket"
    key = "terraform.tfstate"
    region = "ap-south-1"

    dynamodb_table = "terraform-state-locks"
    encrypt = true
  }
}

provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  region = "ap-south-1"
  profile = "terraform"
}