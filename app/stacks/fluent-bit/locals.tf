locals {
  helm_opensearch_credentials = <%= aws_secret("opensearch_credentials") %>
}
