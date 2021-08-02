terraform {
    backend "s3" {
        bucket = "super-mario-terraform"
        key    = "terraform.tfstate"
        region = "eu-west-1"
    }
}