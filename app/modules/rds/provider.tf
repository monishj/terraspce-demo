terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
  required_version = ">= 1.1.7"

}

provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = {
      owner       = "execution-team"
      costcenter  = "thoughtworks-adcb"
      environment = "tw-dev"
    }
  }
}
