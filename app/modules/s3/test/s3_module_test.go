package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func Test_s3(t *testing.T)  {
	var terraformOptionsFors3 = terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		TerraformDir: "../../s3",
		Vars: map[string]interface{}{
			"bucket_name": "pragati-test-bucket-1",
			"acl": "private",
		},
	})


	defer terraform.Destroy(t, terraformOptionsFors3)
	terraform.InitAndApply(t, terraformOptionsFors3)
	s3_id_output := terraform.Output(t, terraformOptionsFors3, "bucket_id")

	assert.Equal(t, "pragati-test-bucket-1", s3_id_output)

}