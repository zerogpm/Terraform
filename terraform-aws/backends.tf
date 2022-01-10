terraform {
  cloud {
    organization = "binary-unicorn-terraform"

    workspaces {
      name = "bu-dev"
    }
  }
}