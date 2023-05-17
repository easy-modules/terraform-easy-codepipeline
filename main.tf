data "aws_caller_identity" "current" {}

##############################################################################################################
# S3 BUCKET FOR CODEPIPELINE ARTIFACTS
##############################################################################################################
resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "${var.type_project}-codepipeline-artifacts-${data.aws_caller_identity.current.account_id}"
  tags   = merge(var.tags, { ManagedBy = "Terraform" })
}

resource "aws_s3_bucket_acl" "codepipeline_bucket_acl" {
  bucket = aws_s3_bucket.codepipeline_bucket.id
  acl    = "private"
}

##############################################################################################################
# CODEPIPELINE ROLE
##############################################################################################################
data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "assumed_role" {
  name = join("-", tolist([
    var.stage,
    "codepipeline",
    var.type_project,
    data.aws_caller_identity.current.account_id,
  ]))
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json

  tags = merge(var.tags, { ManagedBy = "Terraform" })
}

data "aws_iam_policy_document" "policies" {
  statement {
    effect = "Allow"
    actions = concat([
      "s3:*",
      "codebuild:*",
      "codepipeline:*",
      "ssm:*",
    ], var.codepipeline_actions_permissions)

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "policies" {
  role = aws_iam_role.assumed_role.id
  name = join("-", tolist([
    var.stage,
    "codepipeline",
    var.type_project,
    data.aws_caller_identity.current.account_id,
  ]))
  policy = data.aws_iam_policy_document.policies.json
}

##############################################################################################################
# CODEPIPELINE
##############################################################################################################
resource "aws_codepipeline" "app" {
  name     = "${var.stage}-${var.type_project}-codepipeline"
  role_arn = aws_iam_role.assumed_role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_bucket.id
  }

  stage {
    name = "Source"
    dynamic "action" {
      for_each = { for k, v in var.codepipeline_source : k => v }
      content {
        name             = action.value.stage_project
        category         = action.value.stage_category
        owner            = action.value.stage_owner
        provider         = action.value.stage_provider
        version          = action.value.stage_version
        output_artifacts = action.value.stage_output_artifacts
        configuration = {
          ConnectionArn = var.app_codestar_connection_arn
          Owner         = var.organization
          #         FullRepositoryId     = "${var.organization}/${action.value.stage_repository}"
          Repo                 = action.value.stage_repository
          BranchName           = action.value.config_BranchName
          OutputArtifactFormat = "CODEBUILD_CLONE_REF"
        }
      }
    }
  }

  stage {
    name = "Build"
    dynamic "action" {
      for_each = { for k, v in var.codepipeline_build : k => v }
      content {
        name             = action.value.build_name
        category         = action.value.build_category
        owner            = action.value.build_owner
        provider         = action.value.build_provider
        input_artifacts  = action.value.build_input_artifacts
        output_artifacts = action.value.build_output_artifacts
        version          = action.value.build_version
        run_order        = action.value.build_order
        configuration = {
          ProjectName = var.codebuild_arn
        }
      }
    }
  }

  tags = merge(var.tags, { ManagedBy = "Terraform" })
}
