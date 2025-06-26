resource "aws_iam_group" "dev"{
    name = var.DevGroupName 
}

resource "aws_iam_group" "devops"{
    name = var.DevOpsGroupName 
}

resource "aws_iam_group_policy_attachment" "dev" {
    for_each = toset(var.dev_group_policies)
    group = aws_iam_group.dev.name
    policy_arn = each.value
}

resource "aws_iam_group_policy_attachment" "devops" {
    for_each = toset(var.devops_group_policies)
    group = aws_iam_group.devops.name
    policy_arn = each.value
}

resource "aws_iam_user_group_membership" "dev_user" {
    for_each = toset(var.dev_group_users)
    user = aws_iam_user.all_users[each.value].name
    groups = [aws_iam_group.dev.name]   
}

resource "aws_iam_user_group_membership" "devops_user" {
    for_each = toset(var.devops_group_users)
    user = aws_iam_user.all_users[each.value].name
    groups = [aws_iam_group.devops.name]  
}

locals {
  all_users = distinct(concat(var.dev_group_users, var.devops_group_users))
}

resource "aws_iam_user" "all_users" {
  for_each = toset(local.all_users)
  name     = each.value
}