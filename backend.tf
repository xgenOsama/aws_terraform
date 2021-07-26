terraform {
  backend "s3" {
      access_key = "####3"
      secret_key = "#####/C4gO+ur2kbPbWAP+j6x"
      bucket = "nti-test-remote-state-xgen"
      key = "terraform.tfstate"
      region = "us-east-1"
      encrypt = true
  }
}