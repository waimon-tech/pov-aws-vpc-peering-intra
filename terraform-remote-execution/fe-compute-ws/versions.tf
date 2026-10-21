terraform {
  required_version = ">= 1.16"

  cloud {
    organization = "hellocloud-tfc-org02"

    workspaces {
      name = "fe-compute-ws"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.6.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.9.1"
    }
  }
}


