locals {
  has_custom_execution_policy_provided = length(var.k8s_custom_execution_policy_document_json) > 0
  count_custom_execution_policy        = local.has_custom_execution_policy_provided ? 1 : 0


  has_s3_datastore_policy          = var.enable_datastore_module && var.create_s3_bucket
  count_attach_s3_datastore_policy = local.has_s3_datastore_policy ? 1 : 0

  has_dynamodb_datastore_policy          = var.enable_datastore_module && var.create_dynamodb_table
  count_attach_dynamodb_datastore_policy = local.has_dynamodb_datastore_policy ? 1 : 0

  requires_execution_role = local.has_s3_datastore_policy || local.has_dynamodb_datastore_policy || local.has_custom_execution_policy_provided
  count_execution_role    = local.requires_execution_role ? 1 : 0

  has_execution_role_name_provided = length(var.k8s_deployment_execution_role_name_override) > 0
  execution_role_name              = local.has_execution_role_name_provided ? var.k8s_deployment_execution_role_name_override : format("k8s-%s-ExecutionRole", var.app_name)
}

data "aws_iam_policy_document" "k8s_deployment_assume_role_statement" {
  statement {
    sid = "k8sAssumeRoleTrustPolicy"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "AWS"
      identifiers = [var.eks_trusted_assume_role_arn]
    }
  }
}

resource "aws_iam_role" "k8s_deployment_execution_role" {
  count = local.count_execution_role
  name = local.execution_role_name

  assume_role_policy = data.aws_iam_policy_document.k8s_deployment_assume_role_statement.json

  tags = merge(
    {
      "Name" = local.execution_role_name,
      "K8s deployment" = var.app_name
    },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "datastore_s3_access_policy" {
  count      = local.count_attach_s3_datastore_policy
  role       = aws_iam_role.k8s_deployment_execution_role[0].name
  policy_arn = module.service_datastore.s3_bucket_policy_arn
}

resource "aws_iam_role_policy_attachment" "datastore_dynamodb_access_policy" {
  count      = local.count_attach_dynamodb_datastore_policy
  role       = aws_iam_role.k8s_deployment_execution_role[0].name
  policy_arn = module.service_datastore.dynamodb_table_policy_arn
}

resource "aws_iam_policy" "k8s_custom_execution_policy" {
  count       = local.count_custom_execution_policy
  name        = "k8s-${replace(var.app_name, "/-| |_/", "")}-CustomExecutionPolicy"
  description = var.k8s_custom_execution_policy_description
  policy      = var.k8s_custom_execution_policy_document_json
}

resource "aws_iam_role_policy_attachment" "k8s_custom_execution" {
  count      = local.count_custom_execution_policy
  role       = aws_iam_role.k8s_deployment_execution_role[0].name
  policy_arn = aws_iam_policy.k8s_custom_execution_policy[0].arn
}