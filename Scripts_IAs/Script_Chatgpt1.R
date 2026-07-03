# Prompt Chatgpt: Crie um script para o R Studio para analisar os dados da planilha 
# dados_adv_so.csv. Quero realizar um teste de Regressão Linear de efeitos mistos para 
# a variável "TR_Final" e um teste de Regressão logística binomial para a variável 
# "Escolha_attach"

############################################################
## ANÁLISE DOS DADOS
############################################################

# Pacotes
library(tidyverse)
library(lme4)
library(lmerTest)
library(car)
library(emmeans)
library(performance)

############################################################
# Importação dos dados
############################################################

dados <- read.csv("dados_adv_SO.csv")

############################################################
# Preparação das variáveis
############################################################

dados$Subject <- factor(dados$Subject)
dados$Item <- factor(dados$Item)

dados$Group <- factor(dados$Group)
dados$Cond <- factor(dados$Cond)
dados$Adv_so <- factor(dados$Adv_so)
dados$Verbo <- factor(dados$Verbo)

# Variável binária para regressão logística
dados$Escolha_attach_bin <- ifelse(dados$Escolha_attach == "High", 1, 0)

############################################################
# REGRESSÃO LINEAR DE EFEITOS MISTOS
# Variável dependente: TR_Final
############################################################

modelo_TR <- lmer(
  TR_Final ~ Group * Cond * Adv_so * Verbo +
    (1 | Subject) +
    (1 | Item),
  data = dados
)

summary(modelo_TR)

anova(modelo_TR, type = 3)

check_model(modelo_TR)

############################################################
# Médias estimadas
############################################################

emmeans(modelo_TR, pairwise ~ Cond)
emmeans(modelo_TR, pairwise ~ Adv_so)
emmeans(modelo_TR, pairwise ~ Verbo)

############################################################
# REGRESSÃO LOGÍSTICA BINOMIAL
############################################################

modelo_attach <- glmer(
  Escolha_attach_bin ~ Group * Cond * Adv_so * Verbo +
    (1 | Subject) +
    (1 | Item),
  family = binomial,
  data = dados,
  control = glmerControl(optimizer = "bobyqa")
)

summary(modelo_attach)

Anova(modelo_attach, type = 3)

############################################################
# Odds ratios
############################################################

exp(fixef(modelo_attach))

############################################################
# Probabilidades previstas
############################################################

emmeans(
  modelo_attach,
  pairwise ~ Cond,
  type = "response"
)

emmeans(
  modelo_attach,
  pairwise ~ Adv_so,
  type = "response"
)

emmeans(
  modelo_attach,
  pairwise ~ Verbo,
  type = "response"
)

############################################################
# Diagnóstico
############################################################

check_model(modelo_attach)