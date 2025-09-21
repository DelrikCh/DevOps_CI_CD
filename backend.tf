terraform {
  backend "s3" {
    bucket         = "chop-west"
    key            = "terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
