# Terraform easy modules

Terraform module to deploy Codepipeline

## Usage

```hcl
module "codepipeline" {
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
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codepipeline.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_iam_role.assumed_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_s3_bucket.codepipeline_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.codepipeline_bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.instance_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_codestar_connection_arn"></a> [app\_codestar\_connection\_arn](#input\_app\_codestar\_connection\_arn) | value of the connection arn | `string` | n/a | yes |
| <a name="input_codebuild_arn"></a> [codebuild\_arn](#input\_codebuild\_arn) | value of the codebuild arn | `string` | n/a | yes |
| <a name="input_codepipeline_actions_permissions"></a> [codepipeline\_actions\_permissions](#input\_codepipeline\_actions\_permissions) | value of the codepipeline actions permissions | `list(string)` | `[]` | no |
| <a name="input_codepipeline_build"></a> [codepipeline\_build](#input\_codepipeline\_build) | build stage of the codepipeline | <pre>list(object({<br>    build_name             = string<br>    build_category         = string<br>    build_owner            = string<br>    build_provider         = string<br>    build_input_artifacts  = list(string)<br>    build_output_artifacts = list(string)<br>    build_version          = string<br>    build_order            = number<br>  }))</pre> | n/a | yes |
| <a name="input_codepipeline_source"></a> [codepipeline\_source](#input\_codepipeline\_source) | source stage of the codepipeline | <pre>list(object({<br>    stage_project          = string<br>    stage_repository       = string<br>    stage_category         = string<br>    stage_owner            = string<br>    stage_provider         = string<br>    stage_version          = string<br>    stage_output_artifacts = list(string)<br>    config_BranchName      = string<br>  }))</pre> | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | value of the organization | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | dev, prod, qa or stage | `string` | `"dev"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags of the project | `map(string)` | <pre>{<br>  "PROJECT": "default"<br>}</pre> | no |
| <a name="input_type_project"></a> [type\_project](#input\_type\_project) | value of the project | `string` | `"demo"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codepipeline_arn"></a> [codepipeline\_arn](#output\_codepipeline\_arn) | The ARN of the CodePipeline. |
| <a name="output_codepipeline_id"></a> [codepipeline\_id](#output\_codepipeline\_id) | The ID of the CodePipeline. |
| <a name="output_codepipeline_name"></a> [codepipeline\_name](#output\_codepipeline\_name) | The name of the CodePipeline. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
