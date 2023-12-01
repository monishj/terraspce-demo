vpc_id = <%= output('network.vpc_id', mock: 'vpc-111') %>
subnet_id = <%= output("network.private_subnets",  mock: ["subnet-1234", "subnet-3456"]) %>


