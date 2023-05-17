# Terraform easy modules

Terraform module to deploy Codepipeline

## Usage

```hcl
module "argo_cd" {
  source = "easy-modules/codepipeline/easy"
  
  app_codestar_connection_arn = "<CODESTAR CONNECTION ARN>"
  codebuild_arn = "<CODEBUILD ARN>"
  git_organization = "easy-modules"
  stage = "dev"
  type_project = "demo"
  codepipeline_actions_permissions = []
  
  codepipeline_source = [{
    stage_project          = "Ecomm"
    stage_repository       = "terraform-easy-codepipeline"
    stage_type             = "Source"
    stage_category         = "Source"
    stage_owner            = "AWS"
    stage_provider         = "CodeStarSourceConnection"
    stage_version          = "1"
    stage_output_artifacts = ["codepipeline_source"]
    config_BranchName      = "main"
  }]
  codepipeline_build = [{
    build_name             = "string"
    build_category         = "Build"
    build_owner            = "AWS"
    build_provider         = "CodeBuild"
    build_input_artifacts  = ["codepipeline_source"]
    build_output_artifacts = ["build_output-configuration-service"]
    build_version          = "1"
    build_order            = 1
  }]
  
  tags = {}
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
# rr
# rr
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
