package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func Test_eks(t *testing.T)  {
	var terraformOptionsForVpc = terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "../../vpc",
		Vars: map[string]interface{}{
			"region":                             "ap-south-1",
			"environment":                        "test",
			"owners":                             "terratest-team",
			"create_database_subnet_group":       "false",
			"azs":                                "[\"ap-south-1a\", \"ap-south-1b\"]",
			"create_database_subnet_route_table": "false",
			//   "vpc_name" : "adcb-vpc-dev",
			//   "vpc_cidr_block" : "10.0.0.0/16",
			//   "vpc_availability_zones" : []string{"a","b"},
			//   "vpc_public_subnets" : []string{"10.0.1.0/24","10.0.2.0/24"},
			// 		"vpc_private_subnets" : []string{"10.0.11.0/24","10.0.12.0/24"},
			// 		"vpc_enable_nat_gateway" : true,
			// 		"transit_gateway_id": "",
			// "private_inbound_acl_rules" : []map[string]string{
			//     {
			//       "cidr_block": "0.0.0.0/0",
			//       "from_port": "0",
			//       "protocol": "tcp",
			//       "rule_action": "allow",
			//       "rule_number": "100",
			//       "to_port": "0",
			//     },
			//   },
			// "public_inbound_acl_rules" : []map[string]string{
			//    {
			//       "cidr_block": "0.0.0.0/0",
			//       "from_port": "0",
			//       "protocol": "tcp",
			//       "rule_action": "allow",
			//       "rule_number": "100",
			//       "to_port": "0",
			//      },
			//   },
			//   "private_outbound_acl_rules" : []map[string]string{
			//      {
			//        "cidr_block": "0.0.0.0/0",
			//        "from_port": "0",
			//        "protocol": "tcp",
			//        "rule_action": "allow",
			//        "rule_number": "100",
			//        "to_port": "0",
			//      },
			//    },
			//    "public_outbound_acl_rules" : []map[string]string{
			//    	  {
			//    	    "cidr_block": "0.0.0.0/0",
			//    	    "from_port": "0",
			//    	    "protocol": "tcp",
			//    	    "rule_action": "allow",
			//    	    "rule_number": "100",
			//    	    "to_port": "0",
			//    	  },
			//    },
		},
	})
	defer terraform.Destroy(t, terraformOptionsForVpc)
	terraform.InitAndApply(t, terraformOptionsForVpc)
	
    terraformOptionsForEks := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "../../eks",
		Vars: map[string]interface{}{
			"cluster_name": "test_adcb_cluster",
			"environment" : "test",
			"cluster_security_group_name" : "test-eks-sg",
			"owners": "terratest-team",
		},
	})

	defer terraform.Destroy(t, terraformOptionsForEks)
	terraform.InitAndApply(t, terraformOptionsForEks)
	
	cluster_status_output := terraform.Output(t, terraformOptionsForEks, "cluster_status")
    eks_managed_node_groups_output := terraform.Output(t, terraformOptionsForEks, "eks_managed_node_groups")
    cluster_certificate_authority_data_output := terraform.Output(t, terraformOptionsForEks, "cluster_certificate_authority_data")
    cluster_endpoint_output := terraform.Output(t, terraformOptionsForEks, "cluster_endpoint")
    
	assert.Equal(t, "ACTIVE", cluster_status_output)
	assert.NotNil(t, eks_managed_node_groups_output)
	assert.NotNil(t, cluster_certificate_authority_data_output)
	assert.NotNil(t, cluster_endpoint_output)

}