- Class: meta
Course: EBAL
Lesson: Licao_7
Author: Aline Alves Fonseca
Type: Standard
Organization: Universidade Federal de Juiz de Fora
Version: 2.4.5

- Class: text
#Output: "Nesta lição vamos estudar a regressão linear multivariada de efeitos mistos. 
# O nome 'efeitos mistos' (mixed effects) vem do fato de utilizarmos variáveis fixas, 
# como as condições experimentais controladas que iremos analisar e variáveis aleatórias 
# que não são exatamente controladas pelo pesquisador, mas são fruto das seleções feitas 
# por ele, como a amostra de indivíduos que participou da tarefa experimental e a 
# escolha/construção dos itens que fazem parte do conjunto experimental."

- Class: text
#Output: "Na Linguística experimental, principalmente em áreas como a psicolinguística, 
# a sociolinguística e a linguística cognitiva, aplicamos testes experimentais com grupos 
# de indivíduos que são falantes da língua em estudo, mas queremos que os resultados dos 
# nossos testes sejam válidos para toda a população de indivíduos com aquelas mesmas 
# características, e não apenas para o grupo testado. Da mesma forma com relação aos itens
# experimentais, quando criamos/selecionamos um conjunto de itens para uma atividade 
# experimental, queremos que aqueles itens sejam uma amostra válida para todo e qualquer 
# item da língua que possua as mesmas características e que os resultados encontrados com
# aquela seleção de itens sejam válidos para todas as possíveis construções da língua e 
# não apenas para o conjunto testado." 

- Class: text
#Output: "Para que possamos ter certeza de que as diferenças encontradas nos testes 
# estatísticos de regressão que aplicamos são fruto das variáveis independentes que 
# controlamos e não fruto de variações entre indivíduos da amostra ou itens do conjunto 
# experimental, devemos 'acrescentar' a variabilidade dos participantes e dos itens 
# experimentais em nossa análise de dados. Fazemos isso adicionando o que a estatística 
# chama de variáveis de 'efeitos aleatórios' (random effects) à fórmula para o cálculo do
# modelo de regressão." 

- Class: text
# Output: "As variáveis aleatórias podem ser acrescentadas tanto nos modelos de regressão
# linear (para variáveis resposta numéricas), como nos modelos de regressão logística 
# (para variáveis resposta nominais ou categóricas). Na lição 6, aplicamos um teste de 
# regressão linear nos dados de uma pesquisa de leitura com rastreamento ocular. Vamos 
# retomar esse teste para relembrarmos?" 

- Class: text
#Output: "Silva (2020) analisou um conjunto de 16 sentenças ambíguas com elipses do tipo 
# gapping, em 4 condições experimentais que se davam pelo cruzamento de duas variáveis 
# independentes (Estrutura e Nome_tipo), com dois níveis em cada: Estrutura Gapping e 
# Nongapping; e Nome_tipo Nome próprio e Nome Comum. Vejamos dois exemplos: sentença 
# Gapping:NComum (GNC) 'A tia assou os biscoitos e /a prima/N1 /o bolo/N2 /para a família/N3' 
# e sentença NonGapping:NComum (NGNC) 'A tia assou os biscoitos e /o bolo/N1 /de nozes/N2 
# /para a família/N3'. Nos testes de leitura com rastreamento ocular, analisamos áreas de 
# interesse da frase com diferentes métricas. Neste estudo, Silva analisou o tempo total 
# de fixações (TFD - Total fixation duration) na área de interesse N2, que corresponde ao 
# DP 'o bolo' na sentença da condição GNC e ao DP 'de nozes' na sentença da condição NGNC."

- Class: cmd_question
# Output: 'Na lição 6, filtramos a planilha de dados original do experimento de Silva (2020) 
# para ficarmos apenas com os dados de TFD da região N2 e em seguida, normalizamos os tempos
# de leitura com transformação logarítmica. Vamos recuperar aqui a planilha de dados já com
# essas alterações. Digite: dados_N2 <- read.csv("dados_N2.csv", header = T, sep = ",")'
dados_N2 <- read.csv("dados_N2.csv", header = T, sep = ",")

- Class: cmd_question
# Output: 'Agora vamos inspecionar nosso dataframe com o comando str(). 
# Digite: str(dados_N2)'
str(dados_N2)

- Class: cmd_question
#Output: "Nosso dataframe tem 381 observações e 8 variáveis. Temos as variáveis previsoras 
# fixas 'Estrutura', 'Nome_tipo' e 'Condition' (que é o cruzamento das duas variáveis fixas), 
# as variáveis aleatórias 'Participant' e 'Item' e as variáveis resposta 'TFD' 
# (valores absolutos em ms) e 'LogTFD' com os valores de TFD normalizados por log. 
# Precisamos agora transformar os caracteres do nosso dataframe em fatores. Para isso, vamos 
# aplicar os comandos 'sapply' e 'mutate_if'. 
# Digite: dados_N2 <- dados_N2 %>% mutate_if(sapply(dados_N2, is.character), as.factor)"
dados_N2 <- dados_N2 %>% mutate_if(sapply(dados_N2, is.character), as.factor)

- Class: figure
# Output: " Para relembrarmos as métricas desse teste, criamos no 'Enviroment' uma tabela
# com os valores de média, variância e desvio padrão do TFD por condição."
Figure: tab1_licao7.R

- Class: cmd_question
# Output: "Vamos inspecionar nossa tabela? Digite: tab_VI"
tab_VI

- Class: video
# Output: "Acrescentamos na tabela os valores de variância e desvio padrão para termos 
# uma noção da variabilidade dos dados agrupados pelas condições do experimento. 
# Vamos relembrar o que significa a variância e o desvio padrão? 
# Responda 'Yes' para visitar a página da internet todamateria.com.br com uma explicação 
# sobre essas métricas. (Obs. Você também pode refazer a lição 1 desse curso para relembrar 
# como calcular a variância e o dp de uma amostra!)"
VideoLink: https://www.todamateria.com.br/variancia-e-desvio-padrao/
  
  - Class: text
#Output: " As medidas de variância e desvio padrão nos indicam o quanto as observações da 
# nossa amostra variam a partir da média. Valores altos de desvio padrão indicam maior 
# variação da amostra, valores baixos indicam menor variação." 

- Class: text
# Output: "As previsões para esse estudo são de que a leitura das sentenças nas condições
#'Gapping' e 'Nome Comum' seria mais lenta do que a leitura das sentenças 'NonGapping' e 
#'Nome Próprio', porque a estrutura 'Gapping' é mais complexa e o 'Nome Próprio' funcionaria 
# como um facilitador para reconhecer a estrutura de S(V)O da parte final da sentença, 
# iniciada pelo conectivo 'e'. Analisando os valores de média por condição, podemos supor que 
# nossa previsão para a condição 'Gapping' se confirma, uma vez que as médias de TFD dessa condição 
# são maiores. No entanto, nossa previsão para a condição 'Nome Comum' parece não se confirmar, 
# uma vez que não há grande diferença de tempo de leitura associado com a variação da condição 
#'Nome_tipo'."   

- Class: cmd_question
# Output: "Agora que já revimos os dados e relembramos as previsões do experimento, 
#vamos refazer o teste de regressão linear 'simples'. 
#Vamos refazer o teste com os dados não transformados por log, para fins didáticos. 
# Assim será possível analisar mais facilmente os valores que aparecem no teste. Vamos lá! 
# Digite: mod1_lm <- lm(TFD ~ Estrutura*Nome_tipo, data = dados_N2)"
mod1_lm <- lm(TFD ~ Estrutura*Nome_tipo, data = dados_N2)


- Class: cmd_question
# Output: " Ok. Realizamos o teste de regressão linear e guardamos em um objeto chamado 
#'mod1_lm'. Para visualizar os resultados do teste, usamos o comando 'summary()'. 
#'Digite: summary(mod1_lm)"
summary(mod1_lm)


- Class: text
#Output: "Vimos na lição passada que o intercept está relacionado ao nível de referência
# das variáveis previsoras, neste caso Gapping:Nome Comum (GNC). Vimos também que o valor 
# do Estimate para o intercept é o coeficiente linear que corresponde a média em ms da
# variável resposta (TFD) na condição GNC. Os demais valores em 'Estimate' são os chamados 
# coeficientes angulares e correspondem a diferença entre as médias de TFD nos níveis 
# indicados das variáveis e o nível de referência do intercept, calculada em uma função de 1o grau.
# Um valor de p<0.05 indica que a diferença entre as médias é diferente de zero, e o sinal 
# indica a direção da correlação entre as variáveis, se crescente ou decrescente."

- Class: text
# Output: "No teste em questão, o valor de p, calculado para o coeficiente angular de
# -404.4 da variável NonGapping:Nome Comum, foi menor que 0.05, indicando que a diferença
# entre as médias de TFD nas condições Gapping e Nongapping é diferente de zero. Já o sinal
# negativo do coeficiente angular indica que a correlação entre a variável Nongapping e o
# tempo de leitura é decrescente, ou seja, o tempo de leitura decai nessa condição." 

- Class: cmd_question
# Output: "Agora vamos aplicar o teste de regressão linear de efeitos mistos a essa mesma 
# planilha de dados. Há dois pacotes básicos para os testes de regressão linear de efeitos 
# mistos, os pacotes 'lme4' e 'lmerTest'. Você precisa ter estes pacotes instalados no seu 
# RStudio e abertos com o comando library() para rodar o teste. o comando para o teste é lmer() 
# e a fórmula é semelhante à fórmula do teste de regressão simples: VD ~ VI + ou * VI(s). 
# A diferença é que agora, além das VIs, vamos adicionar as variáveis aleatórias. 
# A sintaxe para as variáveis aleatórias é (1|Nomedavariável). Após determinar a fórmula 
# para o teste, você deve acrescentar a fonte dos dados com o argumento 'data='. 
# Para o nosso teste, a linha de comando fica assim: 
# mod2_lmer <- lmer(TFD ~ Estrutura*Nome_tipo + (1|Participant) + (1|Item), data = dados_N2). 
# Copie e cole a linha de comando no prompt."
mod2_lmer <- lmer(TFD ~ Estrutura*Nome_tipo + (1|Participant) + (1|Item), data = dados_N2)


- Class: cmd_question
# Output: "Observe que guardamos o resultado do teste em um objeto chamado 'mod2_lmer'. 
# Para visualizar o resultado, usamos o comando summary(). Digite: summary(mod2_lmer)"
summary(mod2_lmer)


- Class: text
# Output: "A primeira informação que temos no sumário do modelo de regressão gerado é o 
# tipo de técnica de estimativa dos dados que foi usada. Nesse caso, foi usada a técnica 
# REML (restricted or residual maximum likelihood) que pode ser traduzido por 
# 'Verossimilhança Máxima Restrita ou Residual'. Na sequência, temos a fórmula do modelo, 
# com as variáveis e o dataframe que inserimos e um valor de convergencia do processo de REML."   

- Class: text
# Output: "A segunda informação que temos são os valores da estatística descritiva dos 
# resíduos. Esta informação também está presente nos modelos de regressão simples e nos 
# indica o quão próximo da distribuição normal nossos dados estão."

- Class: text
# Output: "Em seguida, temos uma tabela com os valores de variância e desvio padrão das 
# variáveis aleatórias 'Participant', 'Item' e 'Residual'. Além disso, temos os valores 
# de N dos grupos das variáveis aleatórias. Mas o que significa esses valores nos modelos 
# mistos de regressão? "   

- Class: text
# Output: "Vimos na lição 6 que os modelos de regressão geram uma reta de correlação 
# entre as variáveis previsoras e a varíavel resposta que é regida por uma função de 
# 1o grau. Nessa função do 1o grau, temos o valor do coeficiente linear ou intercept = a 
# média dos valores das observações da variável resposta no nível da variável previsora 
# tomada como referência; e os valores dos coeficientes angulares ou 'slopes'= a diferença 
# entre as médias das observações da variável resposta no nível da variável previsora que 
# está sendo comparado com o nível de referência. Quando acrescentamos variáveis aleatórias, 
# estamos 'dizendo' ao modelo que as observações da variável resposta em função das variáveis 
# fixas não são completamente independentes, uma vez que essas observações estão agrupadas 
# por participantes e itens da amostra experimental. Isso quer dizer, na análise matemática do 
# modelo, que estamos acrescentando outros valores de intercept, ou seja, outros valores de 
# referência que devem ser levados em conta na análise." 

- Class: cmd_question
# Output: "A título de ilustração, vamos gerar uma lista de coeficientes lineares 
# (ou intercepts) das variáveis aleatórias do nosso modelo mod2_lmer. 
# Digite: random_Lmer <- coef(mod2_lmer)"
random_Lmer <- coef(mod2_lmer)

- Class: cmd_question
# Output: "Criamos no Enviroment um objeto com a lista dos 'intercepts' das variáveis 
# aleatórias. Vamos inspecionar essa lista? Digite: random_Lmer"
random_Lmer

- Class: text
# Output: "Observem que temos um valor de intercept para cada item e para cada participante 
# da nossa planilha de dados. Vejamos alguns exemplos: o valor de 1165.479 no intercept do item 110, 
# significa a média dos valores de TFD das observações do item 110. Já o valor de 1424.34 
# significa a média dos valores de TFD das observaçòes do participante S1P1." 

- Class: text
# Output: "Os valores de variância e desvio padrão apresentados no sumário do modelo de 
# regressão referem-se, então, à variância e ao desvio padrão dos intercepts das variáveis 
# aleatórias, no nosso caso, dos participantes e dos itens. Quanto maior for o valor do 
# desvio padrão, mais variabilidade aquela variável aleatória acrescenta ao modelo."  

- Class: text
# Output: "Analisando os valores, vemos que a variância e o desvio padrão dos participantes 
# e dos itens são menores do que a variância e o desvio padrão associados às variáveis 
# fixas (rever a tab_VI). Isso nos dá um indício de que a variabilidade da nossa variável 
# resposta (TFD) deve estar relacionada à variação das VIs e não das variáveis aleatórias."  

- Class: text
# Output: "Na sequência do sumário do nosso modelo de regressão mod2_lmer, temos a tabela dos
# coeficientes das variáveis fixas. Se retomarmos o modelo de regressão simples que aplicamos 
# (mod1_lm), poderemos observar que os valores dos slopes são ligeiramente diferentes dos 
# apresentados no modelo misto. Isso acontece porque agora a função de 1o grau calculada no 
# modelo leva em consideração outros valores de intercept, ou seja, os efeitos das variáveis 
# aleatórias participantes e itens. No entanto, essa pequena diferença dos valores não gerou 
# diferença no resultado final do teste. Observando os valores de t (relembre a estatística t 
# na lição 4!), continuamos tendo uma diferença significativa entre os níveis Gapping e Nongapping 
# da variável Estrutura e não encontramos diferença significativa entre os níveis da variável 
# Nome_tipo."   

- Class: text
#Output: "A última informação que temos no sumário do nosso modelo misto de regressão são os valores 
# de correlação entre as variáveis fixas. Esses valores são usados para calcular os intervalos de
# confiança dos coeficientes que é um dado extremamente importante para a análise dos resultados. 
# No entanto, há comandos que fazem o cálculo dos intervalos de confiança automaticamente, 
# então não precisamos nos preocupar com esses valores." 

- Class: cmd_question
# Output: "Quando aplicamos modelos mistos de regressão, devemos ter em mente que o modelo ideal
# é sempre o modelo menos complexo, o mais simples em relação ao número de variáveis. 
# Quando temos modelos com muitas variáveis fixas (de 3 em diante), devemos aplicar testes que 
# vão mensurar a relevância das variáveis fixas para o modelo. Com relação às variáveis
# aleatórias, também é importante checar se todas as variáveis incluídas no modelo são ou não 
# relevantes para a análise. Podemos fazer isso a partir de um teste de anova entre modelos. 
# Para exemplificar, vamos primeiro criar um terceiro modelo de regressão, agora apenas com os 
# Participantes como variável aleatória. 
# Digite: mod3_lmer <- lmer(TFD ~ Estrutura*Nome_tipo + (1|Participant), data = dados_N2)" 
mod3_lmer <- lmer(TFD ~ Estrutura*Nome_tipo + (1|Participant), data = dados_N2) 

- Class: cmd_question
#Output: "Agora vamos inspecionar nosso novo modelo com o comando summary()."  
summary(mod3_lmer)

- Class: cmd_question
#Output: "Podemos observar que os valores dos coeficientes das variáveis fixas são ligeiramente 
# diferentes no modelo 3 em comparação ao modelo 2. Agora vamos aplicar um teste de anova entre 
# os modelos para verificar se há diferença significativa entre eles. 
# Digite: anova(mod2_lmer, mod3_lmer, refit= FALSE)"
anova(mod2_lmer, mod3_lmer, refit= FALSE)


- Class: text
# Output: "O valor de p da comparação dos modelos no teste de anova foi p= 0.001214,
# ou seja menor que 0.05, o que indica que há diferença significativa entre os modelos. 
# Neste caso, devemos manter o modelo mais complexo, pois o teste de anova entre os modelos 
# indica que o acréscimo da variável aleatória 'Item' é relevante para a análise."

- Class: cmd_question
# Output: "Por fim nos resta saber qual é a melhor maneira de reportar os resultados de um 
# teste de regressão linear de efeitos mistos. A melhor maneira é apresentando os coeficientes 
# das variáveis fixas, os valores de erro padrão ou os intervalos de confiança, os valores da 
# estatística do teste (t ou F) e os valores de p, além das informações sobre os efeitos aleatórios 
# fornecidas no modelo. Felizmente, o R tem um comando que compila todas essas informações em 
# uma tabela que pode ser salva em formato .pdf, é o comando tab_model. Esse comando é do pacote 
#'sjPlot'. Caso você não tenha aberto esse pacote no início da lição, faça isso agora e depois 
# digite: tab_model(mod2_lmer)"
tab_model(mod2_lmer)


- Class: cmd_question
# Output: "Outra maneira muito eficiente de apresentar os resultados de um teste estatístico 
# é através de um gráfico de efeitos. Vamos fazer um gráfico de efeitos para o nosso modelo? 
# O comando que vamos usar para criar nosso gráfico é do pacote 'effects', caso você não 
# tenha aberto esse pacote no início da lição, faça isso agora e depois 
# digite: plot(allEffects(mod2_lmer))"
plot(allEffects(mod2_lmer))


- Class: text
# Output: "Relembramos aqui que o teste de regressão linear de efeitos mistos que aplicamos 
# com os dados brutos da variável TFD (não normalizados por log) foi para efeitos didáticos, 
# uma vez que é mais fácil avaliar os números na unidade de medida da variável coletada 
# (no caso, milissegundos) do que avaliar os números transformados por log. No entanto, 
# em uma pesquisa real, os testes devem ser aplicados aos dados normalizados se estes 
# não apresentarem distribuição normal por natureza." 

- Class: text
# Output: "Para saber mais sobre modelos de regressão de efeitos mistos, recomendo a 
# leitura do cap. 7 do livro 'Analyzing Linguistic Data: A practical Introduction to 
# Statistics using R' de R. H. Baayen (2008)."
