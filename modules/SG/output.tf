output "security_group" {
  description = "ID of the aws_security_group"
  value       = aws_security_group.sg.id
}
