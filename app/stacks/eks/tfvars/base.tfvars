vpc_id = <%= output('network.vpc_id', mock: 'vpc-111') %>
private_subnet_ids = <%= output("network.private_subnets", mock: ["subnet-1234", "subnet-3456"]) %>
private_route_table_ids = <%= output("network.private_route_table_ids", mock: ["rtb-1234", "rtb-3456"]) %>
enable_nat_gateway = <%= output('network.enable_nat_gateway', mock: 'false') %>