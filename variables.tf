variable "remote_state_bucket" {
  description = "Name of the S3 bucket for the backend"
  type        = string
  default     = ""
}

variable "remote_state_key" {
  description = "S3 key for the state file"
  type        = string
  default     = ""
}



variable "dynamodb_table" {
  description = "DynamoDB table for state locking"
  type        = string
  default     = ""
}
