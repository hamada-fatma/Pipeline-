variable "remote_state_bucket" {
  description = "Nom du bucket S3 pour le backend"
  type        = string
  default     = ""
}

variable "remote_state_key" {
  description = "Clé S3 pour le fichier de state"
  type        = string
  default     = ""
}



variable "dynamodb_table" {
  description = "Table DynamoDB pour le verrouillage de l'état"
  type        = string
  default     = ""
}
