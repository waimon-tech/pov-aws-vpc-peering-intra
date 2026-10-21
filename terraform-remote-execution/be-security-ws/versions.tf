terraform {
  required_version = ">= 1.16"

  cloud {
    organization = "hellocloud-tfc-org02"

    workspaces {
      name = "be-security-ws"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.6.0"
    }
  }
}


