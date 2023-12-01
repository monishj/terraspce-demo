# Required variables:
region                             = "ap-south-1"
name                               = "adcb-vpc"
cidr                               = "17.16.0.0/16"
azs                                = ["ap-south-1a", "ap-south-1b"]       # list(string)
public_subnets                     = ["17.16.1.0/24", "17.16.2.0/24"]     # list(string)
private_subnets                    = ["17.16.101.0/24", "17.16.102.0/24"] # list(string)
database_subnets                   = ["17.16.151.0/24", "17.16.152.0/24"] # list(string)
create_database_subnet_group       = false
create_database_subnet_route_table = false
enable_nat_gateway                 = true
single_nat_gateway                 = true
owners                             = "execution-team"
environment                        = "dev"
# Optional variables:
# enable_flow_log                    = false
