# Get Frontend network information
data "terraform_remote_state" "fe_network" {
  backend = "remote"

  config = {
    organization = "hellocloud-tfc-org02"

    workspaces = {
      name = "fe-network-ws"
    }
  }
}

# Get Backend network information
data "terraform_remote_state" "be_network" {
  backend = "remote"

  config = {
    organization = "hellocloud-tfc-org02"

    workspaces = {
      name = "be-network-ws"
    }
  }
}