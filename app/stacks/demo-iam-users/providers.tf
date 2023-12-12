terraform {
  required_version = ">= 1.2.9, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17"
    }
  }
}
provider "aws" {
  region = "me-central-1"
  default_tags {
    tags = {
      owner       = "thoughtworks-execution-team"
      costcenter  = "thoughtworks-adcb"
      environment = "tw-dev"
    }
  }
}
