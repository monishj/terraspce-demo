package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func Test_vpc(t *testing.T)  {
	var terraformOptionsForVpc = terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "../../vpc",
		Vars: map[string]interface{}{
			"name": "vpc",
			"region":                             "me-central-1",
			"environment":                        "test",
			"owners":                             "terratest-team",
			"create_database_subnet_group":       "false",
			"azs":                                "[\"me-central-1a\", \"me-central-1b\"]",
			"create_database_subnet_route_table": "false",
			"enable_nat_gateway": "false",
		},
	})


	defer terraform.Destroy(t, terraformOptionsForVpc)
	terraform.InitAndApply(t, terraformOptionsForVpc)
	vpc_name_output := terraform.Output(t, terraformOptionsForVpc, "vpc_name")

	assert.Equal(t, "vpc-terratest-team-test", vpc_name_output)

}