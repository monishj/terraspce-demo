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
