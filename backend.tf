terraform {
  backend "s3" {
    bucket = "terraform-s3-jayanth"
    key = "state-s3"
    region = "us-east-1"
    dynamodb_table = "table-lock-terraform"
  }
}