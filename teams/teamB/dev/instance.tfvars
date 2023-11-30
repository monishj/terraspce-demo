vpc_id = <%= output('network.vpc_id', mock: 'vpc-111') %>
private_subnet_id = <%= output("network.private_subnets",  mock: ["subnet-1234", "subnet-3456"]) %>
instance_type       = "t3.micro"
ami                 = "ami-02a2af70a66af6dfb"