cluster_name                           = "adcb"
environment                            = "dev"
cluster_security_group_name            = "dev-eks-sg"
cloudwatch_log_group_retention_in_days = 14
cluster_endpoint_public_access = true
# cluster_endpoint_private_access = false

eks_managed_ng_ami_type       = "AL2_x86_64"
eks_managed_ng_disk_size      = "50"
eks_managed_ng_instance_types = ["m5.xlarge", "m5.2xlarge"]
eks_managed_ng_min_size       = "1"
eks_managed_ng_max_size       = "4"
eks_managed_ng_desired_size   = "2"

manage_aws_auth_configmap = true
cluster_role_name         = "dev-cluster-role"
cluster_role_binding_name = "dev-cluster-role-binding"
k8s_group                 = "developers"
username                  = "developer"
iam_role                  = "team-eks-reader"
admin_iam_role            = "team-eks-administrator"
enable_irsa               = true
owners                    = "execution-team"
create_storage_class      = true