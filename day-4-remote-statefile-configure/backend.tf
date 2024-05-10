terraform {
  backend "s3" {
    bucket = "state-remote-store"
    key    = "/folder-2/terraform.tfstate"
    region = "ap-south-1"
  }
}
