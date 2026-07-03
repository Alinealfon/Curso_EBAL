# Prompt Gemini: Gemini, no script anterior, faltou o passo de avaliar e excluir outliers de TR_Final, 
# inclua esse passo depois do passo 3.

# ==============================================================================
# SCRIPT DE ANÁLISE EXPERIMENTAL NO R STUDIO (VERSÃO ATUALIZADA)
# Diretrizes: Efeitos Mistos, Tratamento de Outliers e Gráficos de Efeitos
# ==============================================================================

# Instale os pacotes necessários retirando o caractere '#' caso não os tenha:
# install.packages("lme4")       # Modelagem de efeitos mistos (lmer e glmer)
# install.packages("lmerTest")   # P-valores automáticos no resumo do LMM
# install.packages("car")        # Testes de ANOVA Tipo III baseados em Wald
# install.packages("emmeans")    # Comparações múltiplas pós-hoc
# install.packages("tidyverse")  # Manipulação, tabelas e gráficos elegantes (ggplot2)
# install.packages("sjPlot")     # Gráficos automatizados dos efeitos de regressão (opcional)

library(lme4)
library(lmerTest)
library(car)
library(emmeans)
library(tidyverse)

# ------------------------------------------------------------------------------
# Passo 1) Criar um dataframe chamado dados com a leitura do arquivo .csv
# ------------------------------------------------------------------------------
dados <- read.csv("dados_adv_SO.csv", stringsAsFactors = FALSE)


# ------------------------------------------------------------------------------
# Passo 2) Fazer a inspeção dos dados e transformar caracteres em fatores
# ------------------------------------------------------------------------------
cat("\n--- INSPECÇÃO INICIAL DOS DADOS ---\n")
str(dados)

# Conversão de variáveis categóricas para fatores
dados$Subject        <- as.factor(dados$Subject)
dados$Item           <- as.factor(dados$Item)
dados$Group          <- as.factor(dados$Group)
dados$Cond           <- as.factor(dados$Cond)
dados$Adv_so         <- as.factor(dados$Adv_so)
dados$Verbo          <- as.factor(dados$Verbo)
dados$Escolha_attach <- factor(dados$Escolha_attach, levels = c("Low", "High"))


# ------------------------------------------------------------------------------
# Passo 3) Boxplots, histogramas e testes de normalidade para TR_Final
# ------------------------------------------------------------------------------
# Histograma inicial do TR_Final bruto
ggplot(dados, aes(x = TR_Final)) +
  geom_histogram(fill = "#2c3e50", color = "white", bins = 30) +
  theme_minimal() +
  labs(title = "Histograma de TR_Final (Antes do Tratamento)", x = "Tempo de Resposta (ms)", y = "Frequência")

# Boxplot inicial para visualizar os outliers presentes
ggplot(dados, aes(x = Cond, y = TR_Final, fill = Cond)) +
  geom_boxplot(alpha = 0.7) +
  theme_minimal() +
  labs(title = "Boxplot de TR_Final por Condição (Com Outliers)", x = "Condição", y = "TR (ms)")

# Teste de Normalidade de Shapiro-Wilk (Executado em uma subamostra de 500 devido ao limite do teste)
cat("\n--- TESTE DE NORMALIDADE (DADOS BRUTOS) ---\n")
shapiro.test(dados$TR_Final[1:500])


# ------------------------------------------------------------------------------
# NOVO PASSO: Avaliar e Excluir Outliers de TR_Final
# ------------------------------------------------------------------------------
# Utilizaremos o método estatístico clássico do Intervalo Interquartil (IQR).
# Qualquer dado além de [Q1 - 1.5 * IQR] ou [Q2 + 1.5 * IQR] será considerado outlier.

Q1  <- quartile_1 <- quantile(dados$TR_Final, 0.25)
Q3  <- quartile_3 <- quantile(dados$TR_Final, 0.75)
IQR_val <- Q3 - Q1

limite_inferior <- Q1 - 1.5 * IQR_val
limite_superior <- Q3 + 1.5 * IQR_val

# Filtrando os dados (Removendo os Outliers)
dados_limpos <- dados %>% 
  filter(TR_Final >= limite_inferior & TR_Final <= limite_superior)

# Relatório de remoção no console
n_removidos <- nrow(dados) - nrow(dados_limpos)
cat("\n--- RELATÓRIO DE TRATAMENTO DE OUTLIERS ---\n")
cat("Total de observações originais:", nrow(dados), "\n")
cat("Total de outliers removidos:", n_removidos, "\n")
cat("Percentual de dados removidos:", round((n_removidos / nrow(dados)) * 100, 2), "%\n")

# Novo boxplot sem os outliers extremos para comparação
ggplot(dados_limpos, aes(x = Cond, y = TR_Final, fill = Cond)) +
  geom_boxplot(alpha = 0.7) +
  theme_minimal() +
  labs(title = "Boxplot de TR_Final por Condição (Sem Outliers Extremos)", x = "Condição", y = "TR (ms)")


# ------------------------------------------------------------------------------
# Passo 4) Transformar os dados numéricos caso não sigam a distribuição normal
# ------------------------------------------------------------------------------
# Mesmo sem outliers, dados de TR costumam ser assimétricos à direita.
# Aplicamos a transformação em logaritmo nos dados limpos.
dados_limpos$log_TR_Final <- log(dados_limpos$TR_Final)

# Histograma dos dados limpos transformados em Log
ggplot(dados_limpos, aes(x = log_TR_Final)) +
  geom_histogram(fill = "#16a085", color = "white", bins = 30) +
  theme_minimal() +
  labs(title = "Histograma de Log(TR_Final) [Dados Filtrados]", x = "Log do Tempo de Resposta", y = "Frequência")


# ------------------------------------------------------------------------------
# Passo 5) Criar tabelas com valores descritivos de TR_Final (Dados Filtrados)
# ------------------------------------------------------------------------------
cat("\n--- TABELA DESCRITIVA: POR CONDICÃO (SEM OUTLIERS) ---\n")
tab_cond <- dados_limpos %>%
  group_by(Cond) %>%
  summarise(N = n(), Media = mean(TR_Final), DP = sd(TR_Final), Mediana = median(TR_Final))
print(tab_cond)

cat("\n--- TABELA DESCRITIVA: POR ADV_SO (SEM OUTLIERS) ---\n")
tab_adv <- dados_limpos %>%
  group_by(Adv_so) %>%
  summarise(N = n(), Media = mean(TR_Final), DP = sd(TR_Final), Mediana = median(TR_Final))
print(tab_adv)

cat("\n--- TABELA DESCRITIVA: POR VERBO (SEM OUTLIERS) ---\n")
tab_verbo <- dados_limpos %>%
  group_by(Verbo) %>%
  summarise(N = n(), Media = mean(TR_Final), DP = sd(TR_Final), Mediana = median(TR_Final))
print(tab_verbo)


# ------------------------------------------------------------------------------
# Passo 6) Realizar teste de Regressão Linear de Efeitos Mistos (LMM)
# ------------------------------------------------------------------------------
# Rodando o modelo nos dados_limpos e corrigidos
cat("\n--- MODELO LINEAR DE EFEITOS MISTOS (LMM) ---\n")
modelo_lmm <- lmer(log_TR_Final ~ Adv_so * Verbo + (1 | Subject) + (1 | Item), data = dados_limpos)
summary(modelo_lmm)

cat("\n--- TABELA DE ANOVA TIPO III (MÉTODO SATTERTHWAITE) ---\n")
print(Anova(modelo_lmm, type = "III"))


# ------------------------------------------------------------------------------
# Passo 7) Realizar teste de Regressão Logística Binomial de Efeitos Mistos (GLMM)
# ------------------------------------------------------------------------------
# Nota: A remoção de outliers de tempo de reação não obriga a remoção na variável Escolha.
# No entanto, para parear estritamente as análises do artigo, usa-se o mesmo 'dados_limpos'.
cat("\n--- MODELO LOGÍSTICO BINOMIAL DE EFEITOS MISTOS (GLMM) ---\n")
modelo_glmm <- glmer(Escolha_attach ~ Adv_so * Verbo + (1 | Subject) + (1 | Item), 
                     data = dados_limpos, family = binomial)
summary(modelo_glmm)

cat("\n--- ANOVA TIPO III PARA O MODELO LOGÍSTICO ---\n")
print(Anova(modelo_glmm, type = "III"))


# ------------------------------------------------------------------------------
# Passo 8) Desenhar gráficos dos efeitos dos testes de regressão
# ------------------------------------------------------------------------------
# GERANDO OS GRÁFICOS DIRETAMENTE VIA GGPLOT2 + EMMEANS (Evita o erro do sjPlot)

# Gráfico para o Modelo Linear (Tempo de Resposta em Log)
ef_lmm <- as.data.frame(emmeans(modelo_lmm, ~ Adv_so * Verbo))
ggplot(ef_lmm, aes(x = Adv_so, y = emmean, group = Verbo, color = Verbo)) +
  geom_line(size = 1) +
  geom_point(size = 3) +
  geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width = 0.1) +
  theme_bw() +
  labs(title = "Efeitos Estimados no Tempo de Resposta (Log TR)",
       x = "Adv_so", y = "Média Estimada Log(TR_Final) e IC 95%")

# Gráfico para o Modelo Logístico Binomial (Probabilidade de Escolha "High")
# O argumento type = "response" converte o log-odds de volta em probabilidade (0 a 1)
ef_glmm <- as.data.frame(emmeans(modelo_glmm, ~ Adv_so * Verbo, type = "response"))
ggplot(ef_glmm, aes(x = Adv_so, y = prob, group = Verbo, color = Verbo)) +
  geom_line(size = 1) +
  geom_point(size = 3) +
  geom_errorbar(aes(ymin = asymp.LCL, ymax = asymp.UCL), width = 0.1) +
  theme_bw() +
  labs(title = "Probabilidade Prevista de Fixação Alta (High)",
       x = "Adv_so", y = "Probabilidade Esperada e IC 95%")

