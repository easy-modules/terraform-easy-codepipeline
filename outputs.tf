output "codepipeline_arn" {
  description = "The ARN of the CodePipeline."
  value       = aws_codepipeline.app.arn
}

output "codepipeline_name" {
  description = "The name of the CodePipeline."
  value       = aws_codepipeline.app.name
}

output "codepipeline_id" {
  description = "The ID of the CodePipeline."
  value       = aws_codepipeline.app.id
}
