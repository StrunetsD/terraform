resource "aws_iam_group" "Dev"{
    name = var.DevGroupName 
}

resource "aws_iam_group" "DevOps"{
    name = var.DevOpsGroupName 
}

