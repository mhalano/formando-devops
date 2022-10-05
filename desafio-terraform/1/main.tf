terraform {
  backend "s3" {
    # Lembre de trocar o bucket para o seu, não pode ser o mesmo nome
    bucket = "descomplicando-terraform-mhalano"
    key    = "formando-devops-desafio-1.tfstate"
    region = "us-east-1"
  }

  required_providers {
    kind = {
      source  = "kyma-incubator/kind"
      version = "0.0.11"
    }
  }
}

provider "kind" {}
