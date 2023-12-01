provider "aws" {
  region = var.region
  default_tags {
    tags = {
      owner       = "execution-team"
      costcenter  = "thoughtworks-adcb"
      environment = "tw-dev"
    }
  }
}
