### Script para Instalação do Swirl e do Curso EBAL ###


# Passo 1 - Instalar e abrir o Swirl

install.packages("swirl")

library(swirl)

install_course("R Programming")

# Passo 2 - Instalar o Curso EBAL
## Para Windows
# 1. A linha de comando abaixo vai abrir o "Explorer" do computador. 
# Navegue até a pasta em que você salvou a pasta do curso chamada EBAL.

pasta_baixada <- choose.dir(caption = "Selecione a pasta EBAL baixada")

# 2. A linha de comando abaixo salva a pasta EBAL dentro da pasta de cursos do swirl.
pasta_destino <- system.file("Courses", package = "swirl")
file.copy(pasta_baixada, pasta_destino, recursive = TRUE)

## Para MAC
# 1. Vai abrir o Finder nativo do Mac. 
# ENTRE na pasta EBAL, entre na "Licao 1" e clique duas vezes no arquivo "lesson.yaml"
arquivo_selecionado <- file.choose()

# 2. O R descobre o caminho da pasta mãe "EBAL" automaticamente
pasta_baixada <- dirname(dirname(arquivo_selecionado))

# 3. O R copia a pasta inteira para o coração do Swirl
pasta_destino <- system.file("Courses", package = "swirl")
file.copy(pasta_baixada, pasta_destino, recursive = TRUE)


