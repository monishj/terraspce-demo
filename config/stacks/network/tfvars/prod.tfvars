# Required variables:
region                               = "me-central-1"
name                                 = "PRODTEAMVPC"
cidr                                 = "17.16.0.0/16"
azs                                  = ["me-central-1a","me-central-1b"] # list(string)
public_subnets                       = [17.16.10.0/24,17.16.20.0/24] # list(string)
private_subnets                      = [17.16.111.0/24,17.16.112.0/24] # list(string)
database_subnets                     = [17.16.161.0/24,17.16.162.0/24] # list(string)
create_database_subnet_group         = false
create_database_subnet_route_table   = false
enable_nat_gateway                   = true
single_nat_gateway                   = true
owners              = "thoughtworks-execution-team"
environment         = "prod"

# Optional variables:
# enable_flow_log                    = false
