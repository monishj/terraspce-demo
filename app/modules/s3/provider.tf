provider "aws" {
  region = "me-central-1"
  default_tags {
    tags = {
      owner       = "thoughtworks-execution-team"
      costcenter  = "thoughtworks-adcb"
    }
  }
}
