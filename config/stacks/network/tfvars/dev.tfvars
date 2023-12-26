# Required variables:
region                             = "me-central-1"
name                               = "adcb-vpc"
cidr                               = "172.16.0.0/16"
azs                                = ["me-central-1a", "me-central-1b"]       # list(string)
public_subnets                     = ["172.16.1.0/24", "172.16.2.0/24"]     # list(string)
private_subnets                    = ["172.16.101.0/24", "172.16.102.0/24"] # list(string)
database_subnets                   = ["172.16.151.0/24", "172.16.152.0/24"] # list(string)
create_database_subnet_group       = false
create_database_subnet_route_table = false
enable_nat_gateway                 = true
single_nat_gateway                 = true
owners                             = "execution-team"
environment                        = "dev"
# Optional variables:
# enable_flow_log                    = false
