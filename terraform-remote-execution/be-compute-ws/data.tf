# Frontend Network
data "terraform_remote_state" "be_network" {
  backend = "remote"

  config = {
    organization = "hellocloud-tfc-org02"

    workspaces = {
      name = "be-network-ws"
    }
  }
}

# Frontend Security Groups
data "terraform_remote_state" "be_security" {
  backend = "remote"

  config = {
    organization = "hellocloud-tfc-org02"

    workspaces = {
      name = "be-security-ws"
    }
  }
}