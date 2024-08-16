output "cluster_role" {
  description = "Name of the cluster role"
  value       = aws_iam_role.demo.arn
}
