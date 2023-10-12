terraform {
  backend "s3" {
    bucket = "tfstate-harry-101"
    key    = "backend/12weekawsworkshopschalenge-demo.tfstate"
    region = "us-east-1"
    dynamodb_table = "remote-backend"
  }
}