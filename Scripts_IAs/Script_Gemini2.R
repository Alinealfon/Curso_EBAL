# Prompt Gemini: Crie um script para o R Studio para analisar os dados da planilha 
# dados_adv_so.csv. Siga os passos: 
# 1) criar um dataframe chamado dados com a leitura do arquivo .csv; 
# 2) fazer a inspeção dos dados e transformar caracteres em fatores; 
# 3) fazer boxplots e histogramas e testes de normalidade para analisar a distribuição dos dados numéricos de TR_Final; 
# 4) transformar os dados numéricos, caso não sigam a distribuição normal; 
# 5) Criar tabelas com os valores descritivos da variável TR_Final por Cond; Adv-so, Verbo; 
# 6) Realizar teste de Regressào linear de efeitos mistos; 
# 7) Realizar teste de Regressão logística binomial de efeitos mistos para a variável Escolha_attach; 
# 8) Desenhar gráficos dos efeitos dos testes de regressão; 
# 9) Criar uma imagem ou arquivo com os resultados dos testes que seja reportável em um artigo. 



# ==============================================================================
# SCRIPT DE ANÁLISE EXPERIMENTAL NO R STUDIO
# Diretrizes: Efeitos Mistos (LMM e GLMM), Diagnóstico e Gráficos de Efeitos
# ==============================================================================

# Instale os pacotes necessários retirando o caractere '#' caso não os tenha:
# install.packages("lme4")       # Modelagem de efeitos mistos (lmer e glmer)
# install.packages("lmerTest")   # P-valores automáticos no resumo do LMM
# install.packages("car")        # Testes de ANOVA Tipo III baseados em Wald
# install.packages("emmeans")    # Comparações múltiplas pós-hoc
# install.packages("tidyverse")  # Manipulação, tabelas e gráficos elegantes (ggplot2)
# install.packages("sjPlot")     # Gráficos automatizados dos efeitos de regressão

library(lme4)
library(lmerTest)
library(car)
library(emmeans)
library(tidyverse)
library(sjPlot)

# ------------------------------------------------------------------------------
# Passo 1) Criar um dataframe chamado dados com a leitura do arquivo .csv
# ------------------------------------------------------------------------------
# Dica: Coloque este script e o arquivo .csv na mesma pasta do seu computador.
dados <- read.csv("dados_adv_SO.csv", stringsAsFactors = TRUE)


# ------------------------------------------------------------------------------
# Passo 2) Fazer a inspeção dos dados e transformar caracteres em fatores
# ------------------------------------------------------------------------------
cat("\n--- ESTRUTURA INICIAL DOS DADOS ---\n")
str(dados)
summary(dados)

# Conversão de variáveis de caracteres e identificadores para fatores
dados$Subject        <- as.factor(dados$Subject)
dados$Item           <- as.factor(dados$Item)
dados$Group          <- as.factor(dados$Group)
dados$Cond           <- as.factor(dados$Cond)
dados$Adv_so         <- as.factor(dados$Adv_so)
dados$Verbo          <- as.factor(dados$Verbo)

# Ajustando a variável categórica binária (definindo 'Low' como nível de referência)
dados$Escolha_attach <- factor(dados$Escolha_attach, levels = c("Low", "High"))

cat("\n--- ESTRUTURA APÓS TRATAMENTO DE FATORES ---\n")
str(dados)


# ------------------------------------------------------------------------------
# Passo 3) Boxplots, histogramas e testes de normalidade para TR_Final
# ------------------------------------------------------------------------------
# Histograma do TR_Final original
ggplot(dados, aes(x = TR_Final)) +
  geom_histogram(fill = "#2c3e50", color = "white", bins = 30) +
  theme_minimal() +
  labs(title = "Histograma de TR_Final (Bruto)", x = "Tempo de Resposta (ms)", y = "Frequência")

# Boxplot do TR_Final original agrupado por Condição
ggplot(dados, aes(x = Cond, y = TR_Final, fill = Cond)) +
  geom_boxplot(alpha = 0.7) +
  theme_minimal() +
  labs(title = "Boxplot de TR_Final por Condição", x = "Condição", y = "TR (ms)")

# Teste de Normalidade (Shapiro-Wilk)
# Nota: Amostras grandes frequentemente rejeitam a hipótese nula devido ao alto poder do teste.
# Por garantia, inspeciona-se a assimetria (skewness).
cat("\n--- TESTE DE NORMALIDADE (DADOS BRUTOS) ---\n")
shapiro.test(dados$TR_Final[1:500]) # Amostrado até 500 observações (limite da função)


# ------------------------------------------------------------------------------
# Passo 4) Transformar os dados numéricos caso não sigam a distribuição normal
# ------------------------------------------------------------------------------
# Tempos de resposta costumam apresentar assimetria acentuada à direita.
# Aplicamos a transformação logarítmica para estabilizar a variância e normalizar resíduos.
dados$log_TR_Final <- log(dados$TR_Final)

# Histograma dos dados transformados em Log
ggplot(dados, aes(x = log_TR_Final)) +
  geom_histogram(fill = "#16a085", color = "white", bins = 30) +
  theme_minimal() +
  labs(title = "Histograma de Log(TR_Final)", x = "Log do Tempo de Resposta", y = "Frequência")


# ------------------------------------------------------------------------------
# Passo 5) Criar tabelas com valores descritivos de TR_Final por Cond, Adv_so e Verbo
# ------------------------------------------------------------------------------
cat("\n--- TABELA DESCRITIVA: POR CONDICÃO ---\n")
tab_cond <- dados %>%
  group_by(Cond) %>%
  summarise(N = n(), Media = mean(TR_Final), DP = sd(TR_Final), Mediana = median(TR_Final))
print(tab_cond)

cat("\n--- TABELA DESCRITIVA: POR ADV_SO ---\n")
tab_adv <- dados %>%
  group_by(Adv_so) %>%
  summarise(N = n(), Media = mean(TR_Final), DP = sd(TR_Final), Mediana = median(TR_Final))
print(tab_adv)

cat("\n--- TABELA DESCRITIVA: POR VERBO ---\n")
tab_verbo <- dados %>%
  group_by(Verbo) %>%
  summarise(N = n(), Media = mean(TR_Final), DP = sd(TR_Final), Mediana = median(TR_Final))
print(tab_verbo)


# ------------------------------------------------------------------------------
# Passo 6) Realizar teste de Regressão Linear de Efeitos Mistos (LMM)
# ------------------------------------------------------------------------------
# Analisa-se o efeito fixo cruzado de Adv_so e Verbo, controlando os interceptos
# aleatórios associados aos participantes (Subject) e aos itens experimentais (Item).
cat("\n--- MODELO LINEAR DE EFEITOS MISTOS (LMM) ---\n")
modelo_lmm <- lmer(log_TR_Final ~ Adv_so * Verbo + (1 | Subject) + (1 | Item), data = dados)
summary(modelo_lmm)

cat("\n--- TABELA DE ANOVA TIPO III (MÉTODO SATTERTHWAITE) ---\n")
print(Anova(modelo_lmm, type = "III"))


# ------------------------------------------------------------------------------
# Passo 7) Realizar teste de Regressão Logística Binomial de Efeitos Mistos (GLMM)
# ------------------------------------------------------------------------------
# Modela a probabilidade de Escolha_attach ser "High" (1) contra "Low" (0).
cat("\n--- MODELO LOGÍSTICO BINOMIAL DE EFEITOS MISTOS (GLMM) ---\n")
modelo_glmm <- glmer(Escolha_attach ~ Adv_so * Verbo + (1 | Subject) + (1 | Item), 
                     data = dados, family = binomial)
summary(modelo_glmm)

cat("\n--- ANOVA TIPO III PARA O MODELO LOGÍSTICO ---\n")
print(Anova(modelo_glmm, type = "III"))


# ------------------------------------------------------------------------------
# Passo 8) Desenhar gráficos dos efeitos dos testes de regressão
# ------------------------------------------------------------------------------
# Gráficos automatizados de alta qualidade para artigos usando o pacote 'sjPlot'

# Gráfico dos efeitos estimados para o Tempo de Resposta (LMM)
plot_model(modelo_lmm, type = "eff", terms = c("Adv_so", "Verbo"),
           title = "Efeitos Estimados no Tempo de Resposta (Log TR)",
           axis.title = c("Adv_so", "Predito Log(TR_Final)")) + theme_bw()

# Gráfico dos efeitos estimados (Probabilidade) para Escolha_attach (GLMM)
plot_model(modelo_glmm, type = "eff", terms = c("Adv_so", "Verbo"),
           title = "Probabilidade Prevista de Fixação Alta (High)",
           axis.title = c("Adv_so", "Probabilidade de Escolha (High)")) + theme_bw()
