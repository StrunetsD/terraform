variable "DevGroupName" {
    default = "DevGroup"  
}

variable "DevOpsGroupName" {
    default = "DevOpsGroup"
}

variable "dev_group_policies" {
  type    = list(string)
  default = []
}

variable "devops_group_policies" {
  type    = list(string)
  default = []
}

variable "dev_group_users" {
    type    = list(string)
    default = [] 
}

variable "devops_group_users" {
    type    = list(string)
    default = [] 
}