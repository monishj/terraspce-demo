
resource "aws_security_group" "ec2-sg" {
  name = "ec2-sg"
  # change to allow from only private subnet after testing
  description = "Default security group for ec2"
  vpc_id      = var.vpc_id

}