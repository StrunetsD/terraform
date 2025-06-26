
output "arn" {
  value = {for user in aws_iam_user.all_users : user.name => user.arn}
}