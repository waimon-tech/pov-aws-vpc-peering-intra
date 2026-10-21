
# Frontend Network
data "terraform_remote_state" "fe_network" {
  backend = "remote"

  config = {
    organization = "hellocloud-tfc-org02"

    workspaces = {
      name = "fe-network-ws"
    }
  }
}

# backend Network
data "terraform_remote_state" "be_network" {
  backend = "remote"

  config = {
    organization = "hellocloud-tfc-org02"

    workspaces = {
      name = "fe-network-ws"
    }
  }
}
