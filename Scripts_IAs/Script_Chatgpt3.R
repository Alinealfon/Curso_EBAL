# Prompt Chatgpt: Chat, no script anterior, faltou o passo de avaliar e excluir outliers de TR_Final, 
# inclua esse passo depois do passo 3.


###############################################################
# 4. Avaliação e exclusão de outliers
###############################################################

###############################
# Boxplot por condição
###############################

ggplot(dados,
       aes(x = Cond,
           y = TR_Final)) +
  geom_boxplot(fill = "lightblue") +
  theme_classic()

###############################
# Identificação pelo critério 1,5 x IQR
###############################

Q1 <- quantile(dados$TR_Final, 0.25, na.rm = TRUE)

Q3 <- quantile(dados$TR_Final, 0.75, na.rm = TRUE)

IQR_TR <- IQR(dados$TR_Final, na.rm = TRUE)

limite_inferior <- Q1 - 1.5 * IQR_TR

limite_superior <- Q3 + 1.5 * IQR_TR

limite_inferior

limite_superior

###############################
# Observações consideradas outliers
###############################

outliers <- dados %>%
  filter(TR_Final < limite_inferior |
           TR_Final > limite_superior)

outliers

nrow(outliers)

###############################
# Remover outliers
###############################

dados_sem_outliers <- dados %>%
  filter(TR_Final >= limite_inferior &
           TR_Final <= limite_superior)

###############################
# Comparação
###############################

nrow(dados)

nrow(dados_sem_outliers)

###############################################################
# Substituir o banco original (opcional)
###############################################################

dados <- dados_sem_outliers