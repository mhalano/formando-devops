terraform {
  backend "s3" {
    # Lembre de trocar o bucket para o seu, não pode ser o mesmo nome
    bucket = "descomplicando-terraform-mhalano"
    key    = "formando-devops-desafio-2.tfstate"
    region = "us-east-1"
  }
}

variable "nome" {
    default = "Marcos"
}

variable "div" {
    default = 7
}

locals {
  resultado = [
    for i in range(1, 100) : i
    if i % var.div == 0
  ]
  resultado_string = join(", ", local.resultado)
}

resource "local_file" "alo_mundo" {
  content = templatefile("alo_mundo.txt.tpl", { div=var.div, nome=var.nome, data=timestamp(), resultado=local.resultado_string})
  filename = "${path.module}/alo_mundo.txt"
}