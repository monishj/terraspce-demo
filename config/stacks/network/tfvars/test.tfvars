# Required variables:
region                             = "me-central-1"
name                               = "adcb-vpc"
cidr                               = "172.17.0.0/16"
azs                                = ["me-central-1a", "me-central-1b"]       # list(string)
public_subnets                     = ["172.17.1.0/24", "172.17.2.0/24"]     # list(string)
private_subnets                    = ["172.17.101.0/24", "172.17.102.0/24"] # list(string)
database_subnets                   = ["172.17.151.0/24", "172.17.152.0/24"] # list(string)
create_database_subnet_group       = false
create_database_subnet_route_table = false
enable_nat_gateway                 = false
single_nat_gateway                 = false
owners                             = "execution-team"
environment                        = "test"
# Optional variables:
# enable_flow_log                    = false
