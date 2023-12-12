package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the Terraform module in examples/terraform-archive-aws-rds-example using Terratest.
func TestTerraformAwsRds(t *testing.T) {
	t.Parallel()

	// Give this RDS Instance a unique ID for a name tag so we can distinguish it from any other RDS Instance running
	// in your AWS account
	expectedPort := int64(3306)
	expectedDatabaseName := "terratest"
	// Pick a random AWS region to test in. This helps ensure your code works in all regions.
	awsRegion := "me-central-1"
	engineVersion := aws.GetValidEngineVersion(t, awsRegion, "mysql", "5.7")
	// Construct the terraform options with default retryable errors to handle the most common retryable errors in
	// terraform testing.
	var terraformOptionsForVpc = terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "../../vpc",
		Vars: map[string]interface{}{
			"region":                             "me-central-1",
			"environment":                        "test",
			"owners":                             "terratest-team",
			"create_database_subnet_group":       "false",
			"azs":                                "[\"me-central-1a\", \"me-central-1b\"]",
			"create_database_subnet_route_table": "false",
		},
	})
	defer terraform.Destroy(t, terraformOptionsForVpc)
	terraform.InitAndApply(t, terraformOptionsForVpc)

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../",

		// Variables to pass to our Terraform code using -var options
		// "username" and "password" should not be passed from here in a production scenario.
		Vars: map[string]interface{}{
			"DB_NAME": expectedDatabaseName,
			"ENGINE": "mysql",
			"ENGINE_VERSION" : engineVersion,
			"INSTANCE_CLASS" : "db.t3.micro",
			"MULTI_AZ"       : false,
			"PORT"           : expectedPort,
			"ENVIRONMENT"    : "test",
			"OWNERS"         : "terratest-team",
			"DB_PARAM_GROUP_FAMILY" : "mysql5.7",
			"MAJOR_ENGINE_VERSION" : "5.7",
		},
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	dbInstanceID := terraform.Output(t, terraformOptions, "db_instance_id")

	// Look up the endpoint address and port of the RDS instance
	address := aws.GetAddressOfRdsInstance(t, dbInstanceID, awsRegion)
	port := aws.GetPortOfRdsInstance(t, dbInstanceID, awsRegion)
	// Verify that the address is not null
	assert.NotNil(t, dbInstanceID)
	assert.NotNil(t, address)
	// Verify that the DB instance is listening on the port mentioned
	assert.Equal(t, expectedPort, port)

}
