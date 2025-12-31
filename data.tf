data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = ["${var.namespace}-${var.environment}-vpc"]
  }
}

data "aws_route_tables" "gateway" {
  count  = length(var.gateway_endpoint_route_table_filter) > 0 ? 1 : 0
  vpc_id = local.vpc_id

  filter {
    name   = "tag:Name"
    values = var.gateway_endpoint_route_table_filter
  }

}

data "aws_iam_policy_document" "dynamodb" {
  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = ["*"]
  }
}

