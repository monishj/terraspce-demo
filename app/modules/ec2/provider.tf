provider "aws" {
  region = var.region
  default_tags {
    tags = {
      owner       = "thoughtworks-execution-team"
      costcenter  = "thoughtworks-adcb"
      environment = "tw-dev"
    }
  }
}
