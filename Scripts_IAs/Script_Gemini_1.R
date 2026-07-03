# Prompt no Gemini: Crie um script para o R Studio para analisar os dados da planilha 
# dados_adv_so.csv. Quero realizar um teste de Regressão Linear de efeitos mistos para 
# a variável "TR_Final" e um teste de Regressão logística binomial para a variável 
# "Escolha_attach"



# ==============================================================================
# SCRIPT DE ANÁLISE ESTATÍSTICA NO R STUDIO
# Projeto: Regressão de Efeitos Mistos (TR) e Regressão Logística (Escolha)
# Arquivo: dados_adv_SO.csv
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. INSTALAÇÃO E CARREGAMENTO DE PACOTES
# ------------------------------------------------------------------------------
# Caso não tenha algum dos pacotes instalados, remova o '#' da linha correspondente:
# install.packages("lme4")       # Criação dos modelos de efeitos mistos (lmer e glmer)
# install.packages("lmerTest")   # Adiciona os p-valores ao resumo do modelo linear misto
# install.packages("car")        # Para realizar os testes de ANOVA (Wald Tipo III)
# install.packages("emmeans")    # Para análises pós-hoc (comparações múltiplas)
# install.packages("tidyverse")  # Para manipulação de dados e gráficos

library(lme4)
library(lmerTest)
library(car)
library(emmeans)
library(tidyverse)

# ------------------------------------------------------------------------------
# 2. CARREGAMENTO E PREPARAÇÃO DOS DADOS
# ------------------------------------------------------------------------------
# Certifique-se de que o arquivo "dados_adv_SO.csv" está na mesma pasta do seu projeto 
# ou defina o diretório em: Session -> Set Working Directory -> Choose Directory...

dados <- read.csv("dados_adv_SO.csv", stringsAsFactors = TRUE)

# Visualizar as primeiras linhas e a estrutura dos dados
head(dados)
str(dados)

# Garantir que os identificadores e preditores sejam tratados como fatores (variáveis categóricas)
dados$Subject        <- as.factor(dados$Subject)
dados$Item           <- as.factor(dados$Item)
dados$Group          <- as.factor(dados$Group)
dados$Adv_so         <- as.factor(dados$Adv_so)
dados$Verbo          <- as.factor(dados$Verbo)
dados$Cond           <- as.factor(dados$Cond)

# Definir explicitamente os níveis da variável dependente binomial
# O R define alfabeticamente o primeiro nível como referência (0) e o segundo como sucesso (1).
# Definindo "Low" como referência e "High" como o evento a ser previsto:
dados$Escolha_attach <- factor(dados$Escolha_attach, levels = c("Low", "High"))

# Criar a variável de Tempo de Reação log-transformada (Altamente recomendado para TR)
dados$log_TR_Final   <- log(dados$TR_Final)


# ==============================================================================
# 3. REGRESSÃO LINEAR DE EFEITOS MISTOS (LMM) — VARIÁVEL "TR_Final"
# ==============================================================================
# Analisamos o impacto de Adv_so, Verbo e a interação entre eles (*),
# controlando a variação aleatória individual de cada Participante e de cada Item.

# --- Abordagem 3.1: Modelo com TR Bruto (como solicitado) ---
cat("\n--- MODELO MIXTO: TR BRUTO ---\n")
modelo_lmm_raw <- lmer(TR_Final ~ Adv_so * Verbo + (1 | Subject) + (1 | Item), data = dados)
summary(modelo_lmm_raw)

# Teste de efeitos principais e de interação (Tabela de ANOVA Tipo III)
cat("\n--- ANOVA TIPO III: TR BRUTO ---\n")
Anova(modelo_lmm_raw, type = "III")


# --- Abordagem 3.2: Modelo Recomendado com LOG(TR) ---
# (Apresenta resíduos muito mais ajustados aos pressupostos estatísticos)
cat("\n--- MODELO MIXTO: LOG(TR) [RECOMENDADO] ---\n")
modelo_lmm_log <- lmer(log_TR_Final ~ Adv_so * Verbo + (1 | Subject) + (1 | Item), data = dados)
summary(modelo_lmm_log)

cat("\n--- ANOVA TIPO III: LOG(TR) ---\n")
Anova(modelo_lmm_log, type = "III")

# --- Teste Pós-Hoc (Se houver interação significativa) ---
# Permite ver onde estão as diferenças exatas entre as condições
cat("\n--- COMPARAÇÕES PÓS-HOC (LOG TR) ---\n")
emmeans(modelo_lmm_log, pairwise ~ Adv_so | Verbo) # Compara Adv_so dentro de cada Verbo
emmeans(modelo_lmm_log, pairwise ~ Verbo | Adv_so) # Compara Verbo dentro de cada Adv_so


# ==============================================================================
# 4. REGRESSÃO LOGÍSTICA BINOMIAL — VARIÁVEL "Escolha_attach"
# ==============================================================================

# --- OPÇÃO A: Regressão Logística de Efeitos Mistos (GLMM) [Altamente Recomendado] ---
# É o método correto para dados experimentais repetidos (evita inflação do Erro Tipo I).
cat("\n--- MODELO LOGÍSTICO MISTO (GLMM) ---\n")
modelo_glmm <- glmer(Escolha_attach ~ Adv_so * Verbo + (1 | Subject) + (1 | Item), 
                     data = dados, family = binomial)
summary(modelo_glmm)

cat("\n--- ANOVA TIPO III: GLMM ---\n")
Anova(modelo_glmm, type = "III")

# Cálculo da Razão de Chances (Odds Ratio - OR) para o modelo misto
cat("\n--- RAZÃO DE CHANCES (ODDS RATIO) - GLMM ---\n")
exp(fixef(modelo_glmm))


# --- OPÇÃO B: Regressão Logística Clássica Fixa (GLM) ---
# Use este se você NÃO quiser incluir os efeitos aleatórios de Subject e Item.
cat("\n--- MODELO LOGÍSTICO TRADICIONAL (GLM) ---\n")
modelo_glm <- glm(Escolha_attach ~ Adv_so * Verbo, data = dados, family = binomial)
summary(modelo_glm)

cat("\n--- ANOVA TIPO III: GLM ---\n")
Anova(modelo_glm, type = "III")

# Cálculo da Razão de Chances (Odds Ratio - OR) e intervalos de confiança para o GLM clássico
cat("\n--- RAZÃO DE CHANCES E IC 95% - GLM ---\n")
exp(coef(modelo_glm))
exp(confint(modelo_glm))


# ==============================================================================
# 5. DIAGNÓSTICO E PRESSUPOSTOS (Apenas para o Modelo Linear)
# ==============================================================================
# Use estes gráficos para avaliar se os resíduos do modelo linear são homogêneos e normais.
# Dica: compare o comportamento visual de `modelo_lmm_raw` contra `modelo_lmm_log`.

# Gráfico de Resíduos vs Valores Ajustados (Homocedasticidade)
plot(modelo_lmm_log, main = "Resíduos vs Ajustados (Log TR)")

# Gráfico Q-Q Plot (Normalidade dos Resíduos)
qqnorm(residuals(modelo_lmm_log), main = "Q-Q Plot dos Resíduos (Log TR)")
qqline(residuals(modelo_lmm_log), col = "red")
