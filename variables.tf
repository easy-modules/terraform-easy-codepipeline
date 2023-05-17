variable "app_codestar_connection_arn" {
  type        = string
  description = "value of the connection arn"
}

variable "codebuild_arn" {
  type        = string
  description = "value of the codebuild arn"
}

variable "organization" {
  type        = string
  description = "value of the organization"
}

variable "type_project" {
  type        = string
  description = "value of the project"
  default     = "demo"
}

variable "stage" {
  type        = string
  description = "dev, prod, qa or stage"
  default     = "dev"
}

variable "codepipeline_actions_permissions" {
  type        = list(string)
  description = "value of the codepipeline actions permissions"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "tags of the project"
  default = {
    PROJECT = "default"
  }
}

variable "codepipeline_source" {
  type = list(object({
    stage_project          = string
    stage_repository       = string
    stage_category         = string
    stage_owner            = string
    stage_provider         = string
    stage_version          = string
    stage_output_artifacts = list(string)
    config_BranchName      = string
  }))
  description = "source stage of the codepipeline"
}

variable "codepipeline_build" {
  type = list(object({
    build_name             = string
    build_category         = string
    build_owner            = string
    build_provider         = string
    build_input_artifacts  = list(string)
    build_output_artifacts = list(string)
    build_version          = string
    build_order            = number
  }))
  description = "build stage of the codepipeline"
}
