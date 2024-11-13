terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  # region     = var.aws_region
  # access_key = var.aws_key
  # secret_key = var.aws_keyvalue
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

provider "okta" {
  org_name  = var.org_name # Your Okta domain (e.g., dev-123456.okta.com)
  base_url  = "okta.com"
  api_token = var.api_token # The API token from Okta
}