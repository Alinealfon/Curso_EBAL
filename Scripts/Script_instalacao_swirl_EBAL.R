### Script para Instalação do Swirl e do Curso EBAL ###


# Passo 1 - Instalar e abrir o Swirl

install.packages("swirl")

library(swirl)

install_course("R Programming")

# Passo 2 - Instalar o Curso EBAL

# A linha de comando abaixo vai abrir o "Explorer" do computador. 
# Navegue até a pasta em que você salvou a pasta do curso chamada EBAL.
pasta_baixada <- choose.dir(caption = "Selecione a pasta EBAL baixada")

# A linha de comando abaixo salva a pasta EBAL dentro da pasta de cursos do swirl.
pasta_destino <- system.file("Courses", package = "swirl")
file.copy(pasta_baixada, pasta_destino, recursive = TRUE)
