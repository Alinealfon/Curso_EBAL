# Prompt Chatgpt: Crie um script para o R Studio para analisar os dados da planilha 
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

###############################################################
## ANÁLISE DOS DADOS
## Experimento Adv_SO
###############################################################

###############################
# 1. Pacotes
###############################

# Instale apenas uma vez
# install.packages(c("tidyverse","lme4","lmerTest","car",
#                    "performance","emmeans","ggeffects",
#                    "sjPlot","DHARMa","psych","moments"))

library(tidyverse)
library(lme4)
library(lmerTest)
library(car)
library(performance)
library(emmeans)
library(ggeffects)
library(sjPlot)
library(DHARMa)
library(psych)
library(moments)

###############################################################
# 2. Leitura dos dados
###############################################################

dados <- read.csv("dados_adv_SO.csv",
                  header = TRUE,
                  stringsAsFactors = FALSE)

###############################################################
# 3. Inspeção dos dados
###############################################################

str(dados)

summary(dados)

head(dados)

colSums(is.na(dados))

###############################################################
# 4. Transformar caracteres em fatores
###############################################################

dados <- dados %>%
  mutate(across(where(is.character), as.factor))

str(dados)

###############################################################
# 5. Distribuição de TR_Final
###############################################################

###############################
# Boxplot
###############################

ggplot(dados,
       aes(y = TR_Final))+
  geom_boxplot(fill="lightblue")+
  theme_classic()

###############################
# Histograma
###############################

ggplot(dados,
       aes(TR_Final))+
  geom_histogram(bins=30,
                 fill="steelblue",
                 color="black")+
  theme_classic()

###############################
# QQplot
###############################

qqnorm(dados$TR_Final)

qqline(dados$TR_Final)

###############################################################
# Testes de normalidade
###############################################################

shapiro.test(dados$TR_Final)

skewness(dados$TR_Final)

kurtosis(dados$TR_Final)

###############################################################
# 6. Transformação (caso necessário)
###############################################################

dados$logTR <- log(dados$TR_Final)

###############################
# Conferir novamente
###############################

hist(dados$logTR)

qqnorm(dados$logTR)

qqline(dados$logTR)

shapiro.test(dados$logTR)

###############################################################
# 7. Estatísticas descritivas
###############################################################

###############################
# Por Cond
###############################

dados %>%
  group_by(Cond) %>%
  summarise(
    N=n(),
    Média=mean(TR_Final),
    DP=sd(TR_Final),
    Mediana=median(TR_Final),
    Mínimo=min(TR_Final),
    Máximo=max(TR_Final)
  )

###############################
# Por Adv_so
###############################

dados %>%
  group_by(Adv_so) %>%
  summarise(
    N=n(),
    Média=mean(TR_Final),
    DP=sd(TR_Final),
    Mediana=median(TR_Final)
  )

###############################
# Por Verbo
###############################

dados %>%
  group_by(Verbo) %>%
  summarise(
    N=n(),
    Média=mean(TR_Final),
    DP=sd(TR_Final),
    Mediana=median(TR_Final)
  )

###############################################################
# 8. Regressão Linear de Efeitos Mistos
###############################################################

modelo_LMM <-
  lmer(logTR ~ Group +
         Cond +
         Adv_so +
         Verbo +
         (1|Subject)+
         (1|Item),
       data=dados)

summary(modelo_LMM)

anova(modelo_LMM)

###############################################################
# Diagnóstico
###############################################################

check_model(modelo_LMM)

check_collinearity(modelo_LMM)

plot(modelo_LMM)

###############################################################
# Médias marginais
###############################################################

emmeans(modelo_LMM,
        pairwise~Cond)

emmeans(modelo_LMM,
        pairwise~Adv_so)

emmeans(modelo_LMM,
        pairwise~Verbo)

###############################################################
# 9. Regressão Logística Binomial
###############################################################

###############################################################
# Transformar resposta em 0 e 1
###############################################################

dados$Escolha_attach <-
  factor(dados$Escolha_attach)

levels(dados$Escolha_attach)

###############################################################
# Ajuste caso os níveis sejam diferentes
###############################################################

dados$Escolha_bin <-
  ifelse(dados$Escolha_attach==
           levels(dados$Escolha_attach)[2],1,0)

###############################################################

modelo_GLMM <-
  glmer(Escolha_bin~
          Group+
          Cond+
          Adv_so+
          Verbo+
          (1|Subject)+
          (1|Item),
        family=binomial,
        data=dados,
        control=glmerControl(optimizer="bobyqa"))

summary(modelo_GLMM)

Anova(modelo_GLMM)

###############################################################
# Odds Ratios
###############################################################

exp(fixef(modelo_GLMM))

###############################################################
# Diagnóstico
###############################################################

sim <- simulateResiduals(modelo_GLMM)

plot(sim)

###############################################################
# 10. Gráficos dos efeitos
###############################################################

efeito_cond <- ggpredict(modelo_LMM,
                         terms="Cond")

plot(efeito_cond)

efeito_adv <- ggpredict(modelo_LMM,
                        terms="Adv_so")

plot(efeito_adv)

efeito_verbo <- ggpredict(modelo_LMM,
                          terms="Verbo")

plot(efeito_verbo)

###############################################################
# GLMM
###############################################################

efeito_attach <- ggpredict(modelo_GLMM,
                           terms="Cond")

plot(efeito_attach)

###############################################################
# 11. Tabelas para artigo
###############################################################

tab_model(modelo_LMM,
          show.ci=TRUE,
          show.se=TRUE,
          show.re.var=TRUE,
          file="Tabela_LMM.html")

tab_model(modelo_GLMM,
          show.ci=TRUE,
          show.se=TRUE,
          show.re.var=TRUE,
          transform=NULL,
          file="Tabela_GLMM.html")

###############################################################
# Exportar resultados
###############################################################

write.csv(
  dados %>%
    group_by(Cond) %>%
    summarise(
      N=n(),
      Média=mean(TR_Final),
      DP=sd(TR_Final)
    ),
  "Tabela_descritiva.csv",
  row.names=FALSE)

###############################################################
# Fim
###############################################################