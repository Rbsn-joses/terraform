terraform {
  backend "local" {
    # Define um caminho personalizado para salvar o arquivo de estado.
    # O padrão é salvar na mesma pasta com o nome "terraform.tfstate"
    path = "terraform.tfstate"
  }
}