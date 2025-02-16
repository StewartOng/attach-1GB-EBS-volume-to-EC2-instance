terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0" # Use the latest stable version
    }
  }
  backend "s3" {
    bucket = "sctp-ce9-tfstate"        # This is an existing bucket to store terraform tfstate file
    key    = "stewart-ebs-ecc2.tfstate"      # Replace the value of key to <your suggested name>.tfstate 
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.AWS_REGION
}


