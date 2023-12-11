provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = {
      owner       = "thoughtworks-execution-team"
      costcenter  = "thoughtworks-adcb"
    }
  }
}
