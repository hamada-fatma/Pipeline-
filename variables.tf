variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the DB remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "The path for the DB remote state in S3"
  type        = string
}


variable "region" {
  type = string
}

variable "dynamodb_table" {
  type = string
}
