terraform {
  backend = "s3"

  config = {
    bucket = var.db_remote_state_bucket
    key    = var.db_remote_state_key
    region =  var.region
    dynamodb_table = var.dynamodb_table

  }
}

