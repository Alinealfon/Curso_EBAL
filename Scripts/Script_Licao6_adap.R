- Class: meta
Course: EBAL
Lesson: Licao_6
Author: Aline Alves Fonseca
Type: Standard
Organization: Universidade Federal de Juiz de Fora
Version: 2.4.5

- Class: text
# Output: "Nesta lição, vamos aprender a aplicar um dos mais robustos testes estatísticos inferenciais para dados numéricos, 
# o teste de Regressão Linear."

- Class: text
# Output: "A Regressão Linear é um método de análise estatística que nos permite avaliar a relação entre uma variável dependente 
# numérica e uma ou mais variáveis independentes numéricas ou categóricas. Quando aplicamos um teste de regressão, criamos um modelo 
# estatístico de correlação entre a variável dependente e a ou as variáveis independentes. A correlação entre as variáveis em um 
# teste de regressão linear pode ser expressa por uma função de 1o grau do tipo f(x) = ax + b." 

- Class: figure
# Output: "Observe o gráfico de uma função de 1o grau que abrimos na aba Plots. O valor da função f(x) está relacionado ao valor de b 
# (ponto em que a reta corta o eixo y), também conhecido como coeficiente linear; e o valor de a (valor que determina a inclinação da 
# reta em relação ao eixo x), também conhecido como coeficiente angular."   

- Class: text
# Output: "Quando aplicamos um teste de regressão linear em uma amostra de dados, buscamos encontrar a relação entre a variável dependente 
# (ou variável resposta), que é representada pelo eixo y, e a variável independente (ou variável previsora), que é representada pelo eixo x 
# em um plano cartesiano. Pensando na fórmula da função de 1o grau, podemos substituir os símbolos de f(x) = ax + b, por: f(x) = VD, x = VI, 
# a = coeficiente angular (ou slope), e b = coeficiente linear (ou intercept)." 

- Class: cmd_question
# Output: 'Vamos investigar um pouco mais essa relação com um exemplo? Carregue a planilha "nomes_proprios.csv" em um dataframe chamado "nomes". 
# Digite: nomes <- read.csv("nomes_proprios.csv", header = T, sep = ",")' 
nomes <- read.csv("nomes_proprios.csv", header = T, sep = ",")

- Class: cmd_question
# Output: "Temos um dataframe com 100 observações e 4 variáveis. Vamos visualizar nossa planilha com o comando View(). Digite: View(nomes)"
View(nomes)

- Class: cmd_question
# Output: 'Esta planilha foi confeccionada a partir de um levantamento dos 100 nomes de bebês (brasileiros) mais populares do ano de 2018 
# de acordo com o site da revista exame (https://exame.com/brasil/os-100-nomes-de-bebes-brasileiros-mais-populares-em-2018/). Os nomes 
# próprios estão listados na coluna "Nome". Na coluna "Sexo", temos a divisão dos 100 nomes próprios em "Feminino" e "Masculino" de acordo 
# com o sexo do bebê a que os nomes são geralmente atribuídos; na coluna "n_silabas" temos o tamanho dos nomes próprios expresso em número 
# de sílabas, e na coluna "tipo" temos o tipo do nome próprio, se "simples" ou "composto". Queremos investigar se existe uma relação entre 
# o tamanho do nome próprio (n_sílabas = VD) e o sexo do bebê a que estes nomes são geralmente atribuídos (Sexo = VI). Antes de prosseguirmos 
# na análise, precisamos transformar as variáveis categóricas do tipo "chr" em variáveis do tipo "factor". Rode a linha de comando a seguir 
# para realizar essa transformação. Digite: nomes <- nomes %>% mutate_if(sapply(nomes, is.character), as.factor)'
nomes <- nomes %>% mutate_if(sapply(nomes, is.character), as.factor)

- Class: cmd_question
# Output: "Agora vamos inspecionar nosso dataframe com o comando str() para verificar se o R leu nossa planilha corretamente. Digite: str(nomes)"
str(nomes)

- Class: cmd_question
# Output: "Nossa pergunta de pesquisa é: Os nomes próprios femininos possuem tamanho, em número de sílabas, diferente dos nomes próprios masculinos? 
# Para tentar responder nossa pergunta, podemos começar analisando o tamanho médio, em número de sílabas, dos nomes próprios separados por sexo. 
# Vamos, então, criar uma tabela com o comando aggregate e a função mean. Digite: tab_nomes_S <- aggregate(n_silabas ~ Sexo, data = nomes, mean)" 
tab_nomes_S <- aggregate(n_silabas ~ Sexo, data = nomes, mean)

- Class: cmd_question
# Output: "Agora vamos inspecionar nossa tabela. Digite: tab_nomes_S"
tab_nomes_S

- Class: figure
#Output: "A média do número de sílabas nos nomes próprios femininos é de 3.58 e a média do número de sílabas de nomes próprios masculinos é de 2.84. 
# Na aba Plots, abrimos um gráfico de linha em que representamos as médias de n. de sílabas por sexo em um plano cartesiano. No eixo y, temos o número 
# de sílabas (VD) e no eixo x, temos o sexo (VI)." 


- Class: figure
# Output: "Neste novo gráfico, desenhamos os eixos x e y, atribuindo os valores de 0 e 1 para os níveis Feminino e Masculino no eixo x. Agora podemos 
# aplicar a fórmula da função de 1o grau aos valores da nossa amostra. Vejamos f(M) = F + a.M, onde f(M) é o valor da média do número de sílabas dos 
# nomes próprios masculinos (f(M) = 2.84), F = o valor da média dos nomes próprios femininos (F = 3.58), M = 1 e a = coeficiente angular, ou o valor 
# da diferença entre as médias. O valor calculado para a=-0.74."   

- Class: cmd_question
# Output: "Agora vamos aplicar o teste regressão linear aos nossos dados. O comando para o teste é lm(), que é a abreviação de 'linear model', uma vez 
# que o teste de regressão linear estima, estatisticamente, um modelo de correlação linear entre variáveis. Os argumentos do comando lm() são: a fórmula 
# VD ~ VI, data = nomedodataframe. Vamos guardar o resultado do nosso teste em um objeto chamado 'mod_nomes_1'. 
# Digite: mod_nomes_1 <- lm(n_silabas ~ Sexo, data = nomes)"  
mod_nomes_1 <- lm(n_silabas ~ Sexo, data = nomes)

- Class: cmd_question
# Output: "Para visualizar o resultado do teste de regressão linear, usamos o comando summary(). Digite: summary(mod_nomes_1)" 
summary(mod_nomes_1)

- Class: text
# Output: "A saída do teste de regressão traz muitas informações. Na primeira linha, temos a fórmula usada no teste e a fonte 
# dos dados. A segunda informação são as métricas de mínimo, máximo, 1o e 3o quartis e mediana dos resíduos. Os resíduos, de 
# uma maneira simplificada, estão relacionados com a diferença entre as médias estimadas da VD menos as observações da VD. 
# Uma das premissas para a aplicação de testes de regressão é que os resíduos sigam a distribuição normal. Podemos avaliar 
# se os resíduos seguem a distribuição normal pela simetria dos valores de mínimo e máximo (quando o valor absoluto é o mesmo, 
# diferindo apenas pelo sinal de negativo e positivo) e pela proximidade da mediana de zero. No caso do nosso teste, os valores 
# de mínimo e máximo são: -2.58 e 3.42 e a mediana = 0.16. Os valores absolutos de mínimo e máximo não são tão próximos, 
# mas a mediana está próxima de zero, podemos inferir que a distribuição dos dados se aproxima da normal. A premissa da normalidade 
# dos resíduos pode ser violada se a amostra for grande, ou seja, se tivermos um alto número de observações."    

- Class: mult_question
# Output: 'A terceira informação é o resultado do teste, apresentado em um quadro chamado "Coefficients". Na primeira linha do quadro, 
# temos os valores de "Estimate", "Std. Error","t value" e "Pr(>|t|)" para o "(Intercept)". Mas o que é o Intercept e o que significa 
# esses valores? O Intercept é o nível da variável que é tomado como referência. O valor de estimate para o intercept corresponde ao 
# ponto em que a nossa reta, produzida pela função de 1o grau, corta o eixo y. Lembra-se do nosso gráfico das médias de número de sílabas 
# por sexo? Qual foi o nível da variável sexo que ganhou o valor de zero no eixo x? Isso mesmo, o nível feminino. O valor no Estimate 
# do Intercept do nosso teste é exatamente a média do número de sílabas dos nomes próprios femininos = 3.58. A definição do nível da 
# variável que será tomado como referência é feita pela ordem alfabética dos níveis. Na função de 1o grau, qual é o nome que damos para 
# a incógnita que representa o ponto em que a reta corta o  eixo y se o valor de x = 0?' 
AnswerChoices: coeficiente linear; 
               coeficiente angular ; 
               slope
CorrectAnswer: coeficiente linear

- Class: text
# Output: "A medida seguinte apresentada é o erro padrão (Std. Error). O erro padrão é calculado a partir da divisão do desvio padrão da 
# amostra pela raiz quadrada do tamanho da amostra (SE = SD / sqrt(N)). Com o erro padrão, podemos calcular o intervalo de confiança da 
# média e podemos estimar a confiabilidade da média calculada. Podemos dizer de uma maneira simplificada que quanto menor for o erro padrão, 
# maior será a confiabilidade da média. A estatística seguinte é o valor de t (t value). Já vimos essa estatística na lição 4, em que trabalhamos 
# o teste T. O valor de t é o resultado do teste estatístico aplicado que está associado com os graus de liberdade da amostra e com o nível 
# de significância.  Se tivermos o valor de T e os graus de liberdade da amostra, podemos estimar o nível de significância, consultando a tabela 
# de distribuição T. E por último, temos o valor de p (Pr(>|t|). Para o intercept, o valor de p não nos diz muita coisa, pois a comparação é feita 
# entre o valor do estimate (a média da variável) e zero. Ou seja, um p< 0.05 para a comparação do valor no estimate do intercept nos diz apenas 
# que o valor da média do número de sílabas dos nomes próprios do sexo feminino é diferente de zero (H1)."    

- Class: mult_question
# Output: "Na segunda linha do quadro de Coeficientes, temos a indicação da variável Sexo no nível masculino e o valor de Estimate é -0.74. 
# Vimos esse número no gráfico da função de 1o grau com as médias do número de sílabas dos nomes próprios separados por sexo. Qual foi a incógnita 
# que calculamos naquela função com valor de -0.74?"    
AnswerChoices: O valor de a que acompanha x que corresponde ao coeficiente angular; 
               O valor do ponto em que a reta corta o eixo x; 
               O valor do ponto em que a reta corta o eixo y se x=1
CorrectAnswer: O valor de a que acompanha x que corresponde ao coeficiente angular


- Class: text
# Output: "Muito bem! O valor do estimate da variável sexo no nível masculino é o coeficiente angular na função de 1o grau que corresponde à reta 
# de correlação entre as variáveis estudadas. O coeficiente angular também é chamado de slope e corresponde basicamente à diferença entre as médias 
# de número de sílabas dos níveis feminino e masculino da variável sexo (3.58 - 2.84 = -0.74). Na sequência, temos as informações de erro padrão 
# e valor de T calculados para a média de n. de sílabas da variável sexo no nível masculino. E por último, temos o valor de p=0.000923 que é <0.05. 
# Mas o que significa encontrar um valor de p<0.05 neste teste? Significa que o valor da diferença entre as médias de n. de sílabas dos nomes próprios 
# femininos e masculinos é diferente de zero (H1). Podemos assumir então que há uma diferença significativa entre a média do número de sílabas de nomes
# próprios femininos e masculinos." 

- Class: cmd_question
# Output: "Diferentemente do teste T, no teste de regressão, não estipulamos a direcionalidade da H1. A H1 do teste de regressão vai tratar apenas da 
# diferença entre as médias da VD medida em relação às VIs estudadas. A direcionalidade da diferença entre as médias, no entanto, pode ser determinada 
# pelo sinal (positivo ou negativo) do valor do slope. No nosso estudo, o slope é negativo (-0.74), o que nos diz que a correlação entre a média do n. 
# de sílabas de nomes próprios e o sexo masculino é decrescente, ou seja, nomes próprios masculinos são menores em número de sílabas do que nomes próprios 
# femininos. Podemos criar um gráfico a partir do modelo gerado no teste de regressão que mostra o efeito das VIs na VD e nos ajuda a entender e a reportar 
# os resultados. Utilizamos os comandos 'plot' e 'allEffects' para fazer esse gráfico. O comando 'allEffects' pertence ao pacote 'effects'. 
# Para rodar a linha de comando a seguir, você tem que ter o pacote effects instalado e precisa também abri-lo com o comando library(effects). 
# Caso você não tenha feito isso antes de iniciar a lição, dê o comando play(), abra o pacote e volte com o comando nxt() para executar a linha de comando. 
# Digite: plot(allEffects(mod_nomes_1), grid = T)"  
plot(allEffects(mod_nomes_1), grid = T)


- Class: text
# Output: "No gráfico de efeitos que plotamos, podemos perceber que a reta formada entre os valores das médias de n. de sílabas dos nomes próprios femininos 
# (nível de referência - intercept) e de nomes masculinos é descrescente, confirmando que a correlação entre o número de sílabas nos nomes próprios e o sexo 
# masculino é decrescente."

- Class: figure
# Output: "Na imagem que abrimos no Plots, temos dois gráficos de função do 1o grau. No primeiro, o valor do coeficiente angular é maior que zero (a > 0), 
# o que gera uma reta crescente. No segundo, o valor do coeficiente angular é negativo (a < 0), gerando uma reta decrescente. Dessa forma, quando temos um 
# valor do coeficiente angular (slope) positivo no teste de regressão com p<0.05, a correlação entre os níveis da variável é crescente e quando temos um 
# valor negativo no slope com p<0.05, temos uma correlação decrescente." 

- Class: text
# Output: "As informações seguintes ao quadro de coeficientes da saída do teste de regressão referem-se a questões relativas à precisão e ao poder de estimativa 
# do teste em si. A primeira informação é o valor do erro padrão dos resíduos. Assim como o erro padrão amostral, quanto menor o erro padrão dos resíduos, 
# melhor é a capacidade do modelo estatístico de prever o comportamento das observações. Na sequência, temos os valores de R ao quadrado (R-squared) e de R 
# ao quadrado ajustado (Adjusted R-squared). Os valores de R ao quadrado nos informam a proporção da variação da VD que pode ser explicada por variações na VI. 
# Como se trata de uma escala de proporção, os valores de R ao quadrado estão compreendidos entre 0 e 1. Quanto mais próximo de 1, maior é a proporção de predição 
# do teste. Por último, temos a estatística F (F-statistic) e o valor de p dessa estatística que nos informam sobre a significância do modelo. Quando p<0.05, 
# podemos concluir que o modelo gerado no teste é significativo, ou seja, que pelo menos uma das VIs estudadas apresenta um efeito sobre a VD."   

- Class: text
# Output: "Vamos avaliar os valores dessas 3 informações finais para os nossos dados. O valor do erro padrão dos resíduos foi de 1.083. Esse é um valor relativamente 
# alto se pensarmos que a diferença entre as médias da amostra foi de 0.74 e que os valores de erro padrão das médias das variáveis foram de 0.15 e 0.21 respectivamente. 
# Isso significa que o modelo de regressão não prevê bem o comportamento das nossas observações. O valor de R ao quadrado foi 0.1065, que é um valor bem baixo. Isso significa 
# que cerca de apenas 10% da variação da nossa VD (número de sílabas) pode ser explicada pela variação da VI (Sexo). Por fim a estatística F foi de 11.68 com p = 0.000923. 
# Isso significa que o modelo de regressão gerado é significante e que pelo menos uma das diferenças entre as médias é significativa. Como realizamos um teste bem simples, 
# com apenas uma variável de 2 níveis, o valor de p para o modelo foi o mesmo valor de p encontrado no teste entre as variáveis."

- Class: cmd_question
# Output: "Aplicamos o teste de regressão aos dados de número de sílabas de nomes próprios por sexo para podermos aprender a executar e ler os resultados desse tipo de teste. 
# No entanto, se quiséssemos avaliar a diferença de apenas uma variável de 2 níveis, poderíamos ter aplicado um teste T que é bem mais simples. O teste de regressão é ideal para 
# comparações entre múltiplas variáveis com 2 ou mais níveis. Então vamos complicar um pouquinho mais as coisas. Vamos introduzir na nossa análise a variável tipo de nome 
# (composto x simples). Devemos começar a análise olhando para as médias de número de sílabas agora nas 4 condições testadas, sexo: feminino x masculino, e tipo: composto x simples. 
# Vamos usar o comando aggregate para produzir uma tabela com essas médias e vamos guardar o resultado em um dataframe chamado tab_nomes_ST. 
# Digite: tab_nomes_ST <- aggregate(n_silabas ~ Sexo + tipo, data = nomes, mean)" 
tab_nomes_ST <- aggregate(n_silabas ~ Sexo + tipo, data = nomes, mean)

- Class: cmd_question
# Output: "Agora vamos inspecionar nossa tabela. Digite: tab_nomes_ST"
tab_nomes_ST

- Class: figure
# Output: "Abrimos no plots um gráfico com as médias da relação entre nomes próprios compostos e simples do sexo feminino e masculino. Como temos agora duas VIs, temos um gráfico com duas retas."

- Class: cmd_question
# Output: "Vamos executar agora o teste de regressão linear para nossos dados com duas variáveis previsoras (VIs). Há duas maneiras de escrever a fórmula das VD e VIs no comando lm() a depender 
# do tipo de análise que você quer realizar. Se você quer analisar o efeito da interação entre as VIs na VD, a fórmula é (VD ~ VI*VI, data = ), se você quer testar o efeito das VIs individualmente 
# na VD (sem interação), a fórmula é (VD ~ VI + VI, data = ). Uma maneira de avaliar se há uma possível interação entre duas variáveis independentes é olhar para o gráfico de linhas das médias 
# das variáveis. Se as retas são completamente paralelas, ou seja, se as retas não se cruzam no plano mesmo que haja o prolongamento delas ao infinito, significa que as variáveis não interajem 
# entre si. Caso as retas não sejam paralelas, é possível que haja interação entre as variáveis. No nosso gráfico, as retas das médias de n. de sílabas dos nomes próprios femininos e masculinos, 
# simples e compostos não são paralelas. Então vamos executar o teste prevendo interação entre as variáveis e vamos guardar o resultado em um objeto chamado mod_nomes_ST. 
# Digite: mod_nomes_ST <- lm(n_silabas ~ Sexo*tipo, data = nomes)"  
mod_nomes_ST <- lm(n_silabas ~ Sexo*tipo, data = nomes)

- Class: cmd_question
# Output: "Agora vamos visualizar o resultado no teste de regressão linear com o comando summary(). Digite: summary(mod_nomes_ST)"
summary(mod_nomes_ST)

- Class: text
# Output: "Vamos analisar os resultados da saída do teste de regressão linear, começando pelos resíduos. Os valores de mínimo e máximo são: -2.1463 e 1.8537, e o valor da mediana é -0.1463. 
# Aparentemente, podemos dizer que os resíduos se aproximam da distribuição normal, uma vez que os valores absolutos de mínimo e máximo são próximos e que a mediana se aproxima de zero."  

- Class: mult_question
# Output: "Vamos olhar agora para o quadro de Coeficientes que é onde está o resultado da comparação entre as médias. Para começarmos nossa análise dos resultados, precisamos saber quais 
# são os níveis das VIs que foram considerados como níveis de referência e estão, portanto, no Intercept. Sabemos que o R usa o critério da ordem alfabética para determinar qual nível 
# será tomado como referência. Selecione a opção abaixo em que estão os níveis de referência do nosso teste."
AnswerChoices: feminino:composto;
               feminino:simples;
               masculino:composto
CorrectAnswer: feminino:composto

- Class: text
# Output: "Muito bem! No intercept temos o nível feminino da VI Sexo e o nível composto da VI tipo. O valor do estimate do intercept é, então, a média de n. de sílabas dos nomes próprios 
# do sexo feminino e do tipo composto (confira a tabela que fizemos anteriormente!), que é = 5.55. Na sequência temos o valor de erro padrão, o valor de t e o valor de p para o intercept. 
# Como vimos anteriormente, o fato de o valor de p no intercept ser menor que 0.05 não nos diz nada sobre a comparação das médias, pois o teste de regressão está comparando o valor do 
# estimate do intercept com zero, ou seja, o p <2e-16 no intercept nos diz que 5.55 é diferente de zero (o que é um tanto óbvio)."

- Class: text
# Output: "Na segunda linha, temos a indicação da variável Sexo no nível Masculino. Isso quer dizer que alteramos o nível da variável sexo em relação ao nível de referência, então o valor 
# do estimate é a diferença entre a média de n. de sílabas dos nomes próprios do sexo feminino e do tipo composto e a média do n. de sílabas dos nomes próprios compostos do sexo masculino. 
# Consultando a nossa tabela, temos (4.33 - 5.55 = -1.22). O valor de p<0.05 nesta linha (Pr(>|t|) = 0.00331), nos diz que a diferença entre  as médias das variáveis  nome próprio feminino 
# composto x nome próprio masculino composto é diferente de zero. Ou seja, se a diferença entre as médias é estatisticamente diferente de zero, isso significa que há um efeito do sexo sobre 
# os nomes próprios compostos, e como vimos na análise anterior, é um efeito de correlação decrescente." 

- Class: text
# Output: "Na terceira linha, temos a comparação entre as médias do n. de sílabas de nomes próprios femininos compostos x nomes próprios femininos simples. O valor de p abaixo de 0.05 
# (p = 2.41e-13) indica que o coeficiente angular de -2.4092 é diferente de zero. Isso significa que há um efeito significativo da variável tipo nos nomes próprios femininos, e esse 
# efeito é uma correlação decrescente entre o n. de sílabas dos nomes próprios femininos e o tipo simples." 

- Class: figure
# Output: "Na quarta e última linha do quadro Coefficients, temos a comparação entre os níveis de referência 'feminino:composto' e os níveis 'masculino:simples' das VIs sexo e tipo. 
# A conta aqui é um pouco mais complexa porque estamos trabalhando com a interação entre as variáveis, ou seja com duas retas em um plano cartesiano. Vamos relembrar a função de 
# 1o grau que estabelece as retas de correlação entre as variáveis, mas agora nos casos em que temos múltiplas variáveis. Veja a demonstração da função que abrimos na aba plots." 


- Class: cmd_question
# Output: "Substituindo os elementos da função pelos valores que já conhecemos, temos que f(x) nesta equação é o valor da média do n. de sílabas dos nomes próprios masculinos 
# simples (2.63), b é o valor da média do nível de referência - intercept (5.55) e temos 3 coeficientes angulares: aX1) a variação entre os níveis masculino x feminino, com o 
# tipo composto constante; aX2) a variação entre os tipos composto e simples com o sexo feminino constante; e aX3) a combinação da variação entre os níveis composto x simples 
# e feminino x masculino. Substituindo os coeficientes angulares que já conhecemos (aX1 e aX2), teremos algo assim: 2.63 = 5.55 + (-1.2222) + (-2.4092)  +  aX3. Vamos fazer 
# essa conta aqui no R para saber qual é o valor do coeficiente angular das VIs sexo e tipo nos níveis masculino e simples em interação? Relembrando a matemática básica do 
# ensino médio, se queremos descobrir o valor de uma incógnita, isolamos essa incógnita em um dos lados da igualdade e passamos os valores do lado da incógnita para o lado 
# oposto, trocando os sinais. Digite: aX3 =  2.63 - (5.55 - 1.22 - 2.41)"
aX3 =  2.63 - (5.55 - 1.22 - 2.41)

- Class: text
# Output: "Voilá! o resultado da nossa continha é o valor do estimate da 4a linha do quadro de coeficientes do nosso teste de regressão (0.7122). A comparação entre as médias d
# e n. de sílabas de nomes próprios nas condições feminino:composto x masculino:simples em interação não foi significativa (p = 0.10773). No entanto, devemos nos perguntar, 
# como pesquisadores, se essa comparação faz sentido. É relevante para nossa pesquisa comparar os nomes próprios femininos compostos com os nomes próprios masculinos simples? 
# A resposta é não. Não faz sentido porque já é de se esperar que haja uma diferença em número de sílabas entre nomes simples e compostos, independente do sexo, então não faz 
# nenhum sentido comparar os dois níveis da variável tipo, variando também os níveis da variável sexo. A leitura, a compreensão e a interpretação dos resultados de um teste 
# estatístico são partes fundamentais da pesquisa e cabe ao pesquisador tomar a decisão sobre os resultados que são relevantes ou não para seu estudo." 

- Class: text
# Output: "Por último, vamos dar uma olhadinha nos resultados referentes às estatísticas do teste de regressão em si. O valor do erro padrão dos resíduos foi de 0.7696. Valor mais 
# baixo do que o erro padrão dos resíduos do teste em que consideramos apenas a variável sexo. Isso nos diz que a inclusão da variável 'tipo' ajudou a prever melhor a variabilidade 
# das observações. O valor do R ao quadrado passou de aproximadamente 0.10 para 0.5578, ou seja, no teste com as duas variáveis (sexo e tipo), cerca de 55% da variação da VD pode 
# ser explicada pelas variações nas VIs. E, por fim, nosso modelo de regressão gerado é válido, uma vez que o valor de p para a estatística F foi <0.05. Podemos concluir que a 
# inclusão da variável 'tipo' foi benéfica para o modelo de correlação gerado pelo teste de regressão aplicado." 

- Class: cmd_question
# Output: 'Uma boa maneira de explicar e reportar os resultados de um teste estatístico é utilizando gráficos. Vamos então desenhar um gráfico a partir do modelo estatístico que geramos 
# com o teste de regressão linear aplicado aos nossos dados. Vamos usar os comandos plot e allEffects e vamos editar o título e os rótulos dos eixos x e y do nosso gráfico. 
# Digite: plot(allEffects(mod_nomes_ST), grid = T, main = "Efeito das variáveis sexo e tipo \n no número de sílabas de nomes próprios", ylab = "Número de sílabas (média)", xlab = "Sexo")'
plot(allEffects(mod_nomes_ST), grid = T, main = "Efeito das variáveis sexo e tipo \n no número de sílabas de nomes próprios", ylab = "Número de sílabas (média)", xlab = "Sexo")

- Class: text
# Output: "Agora que nós já sabemos executar e interpretar um teste de regressão linear, vamos aplicá-lo a uma pesquisa de verdade, um estudo de rastreamento ocular na leitura."   

- Class: video
# Output: "Os dados que vamos analisar são de uma das atividades experimentais da pesquisa de doutorado de Andressa Christine Oliveira da Silva. Neste experimento, Silva está 
# investigando o processamento de sentenças ambíguas com elipses do tipo Gapping. Vamos assistir um breve vídeo no Youtube para saber mais sobre este experimento?" 
# Link: https://www.youtube.com/watch?v=Yuj3Olki1T0

- Class: text
# Output: "Silva analisou um conjunto de 16 sentenças em 4 condições experimentais que se davam pelo cruzamento de duas variáveis independentes (Estrutura e Nome_tipo), com dois 
# níveis em cada: Estrutura Gapping e Nongapping; e Nome_tipo Nome próprio e Nome Comum. Nas investigações de leitura com rastreamento ocular, é necessário definir áreas de 
# interesse do texto para proceder às medições das variáveis dependentes que são, na maioria das vezes: a) a duração da primeira fixação na área de interesse (First Fixation 
# Duration); b) o tempo total de fixações na área de interesse (Total Fixation Duration); e c) o número de fixações na área de interesse (Fixation Count). Nesta análise, 
# vamos olhar apenas para a medida de tempo total de fixações (TFD) na área de interesse N2." 

- Class: cmd_question
# Output: 'Vamos carregar a planilha de dados em um dataframe chamado "dados". Digite: dados <- read.csv("dados_eyetracker.csv", header= T, sep = ",")' 
dados <- read.csv("dados_eyetracker.csv", header= T, sep = ",")

- Class: cmd_question
# Output: "Nosso dataframe tem 1146 observações de 7 variáveis. Vamos transformar as variáveis do tipo 'chr' em fatores para podermos prosseguir na inspeção dos dados. 
# Digite: dados <- dados %>% mutate_if(sapply(dados, is.character), as.factor)"
dados <- dados %>% mutate_if(sapply(dados, is.character), as.factor)

- Class: cmd_question
# Output: "Nosso primeiro comando de inspeção, já bem conhecido por aqui, é o str(). Digite: str(dados)"
str(dados)

- Class: text
# Output: "Temos 5 variáveis independentes: 'Participant', 'Item', 'Nome_tipo', 'Estrutura' e 'Condition'. A variável dependente é 'TFD' que é o tempo total de fixações 
# do olhar na área de interesse durante a leitura. A unidade de medida de 'TFD' é milissegundos. Por último, temos a variável 'Area' que não é exatamente uma variável 
# indepedentente. Esta variável apenas determina quais são as partes do item experimental em que as fixações do olhar no processo de leitura serão medidas." 

- Class: cmd_question
# Output: 'Vamos analisar nessa lição apenas a área de interesse chamada N2, que corresponde ao ponto em que acontece a elipse nos itens experimentais deste estudo. 
# Vejamos um exemplo. Na sentença Gapping:NComum (GNC) "A tia assou os biscoitos e a prima o bolo para a família.", o N2 corresponde ao DP "o bolo". 
# Já na sentença NonGapping:NComum (NGNC), "A tia assou os biscoitos e o bolo de nozes para a família.", o N2 corresponde ao DP "de nozes". Para analisarmos apenas 
# a área de interesse N2, vamos aplicar um filtro aos nossos dados e gerar um novo dataframe apenas com as observações referentes a essa área de interesse. 
# Vamos chamar esse novo dataframe de "dados_N2". Digite: dados_N2 = dados %>% filter(Area == "N2")'  
dados_N2 = dados %>% filter(Area == "N2")

- Class: cmd_question
# Output: "Agora temos um novo dataframe com 381 observações e as mesmas 7 variáveis do dataframe original. Podemos, então, começar a inspecionar nossos dados sobre 
# a presença de outliers e se nossos dados da área N2 seguem a distribuição normal para a aplicação de testes estatísticos inferenciais paramétricos, como o teste 
# de regressão linear que estamos aprendendo nessa lição. Vamos gerar um boxplot com a coluna TFD do dataframe dados_N2 e range = 3. Digite a linha de comando 
# correspondente no prompt da console."
boxplot(dados_N2$TFD, range = 3)

- Class: cmd_question
# Output: "Pela inspeção visual do boxplot, podemos notar que nossos dados para a área N2 não possuem outliers. Vamos então passar para a etapa 2 que é inspecionar 
# a distribuição dos dados. Vamos começar fazendo um histograma para a coluna TFD do dataframe dados_N2. Digite a linha de comando correspondente no prompt." 
hist(dados_N2$TFD)

- Class: cmd_question
# Output: "Pela inspeção visual do histograma, podemos inferir que os dados de TFD na área de interesse N2 não seguem a distribuição normal, mas para garantir, 
# vamos aplicar o teste de normalidade de Kolmogorov-Smirnov. Lembre-se que para rodar este teste é preciso ter aberto o pacote 'nortest' com o comando library(). 
# Caso você não tenha aberto o pacote antes de iniciar a lição, dê o comando play(), abra o pacote com o comando library(nortest) e volte para a lição com o comando nxt(). 
# Digite: lillie.test(dados_N2$TFD)"
lillie.test(dados_N2$TFD)

- Class: mult_question
# Output: "O valor de p encontrado no teste de normalidade foi de p=2.354e-13. O que podemos concluir sobre a distribuição dos dados?" 
AnswerChoices: Os dados não seguem a distribuição normal. Precisamos aplicar uma fórmula de normalização.; 
               Os dados seguem a distribuição normal. Podemos avançar para os testes inferenciais.; 
               Os dados não seguem a distribuição normal. Vamos aplicar um teste inferencial não paramétrico. 
CorrectAnswer: Os dados não seguem a distribuição normal. Precisamos aplicar uma fórmula de normalização.

- Class: cmd_question
# Output: "Muito bem! Os dados não seguem a distribuição normal, então precisamos tentar normalizá-los aplicando uma transformação matemática. Vamos aplicar a transformação 
# por log e vamos criar uma nova coluna no nosso dataframe dados_N2 chamada 'logTFD'. Digite: dados_N2$logTFD <- log(dados_N2$TFD)"
dados_N2$logTFD <- log(dados_N2$TFD)

- Class: cmd_question
# Output: "Podemos observar no 'Environment' que nosso dataframe 'dados_N2' agora tem 8 variáveis. Vamos aplicar novamente o teste de normalidade Kolmogorov-Smirnov sobre os 
# dados transformados por logaritmo. Digite: lillie.test(dados_N2$logTFD)"
lillie.test(dados_N2$logTFD)

- Class: mult_question
# Output: "O valor de p encontrado no teste agora é de p=0.5578. O que podemos concluir sobre a distribuição dos dados transformados por log?" 
AnswerChoices: A distribuição dos dados agora segue a curva normal. Podemos avançar para a análise inferencial dos dados com testes estatísticos paramétricos.; 
               Os dados continuam não seguindo a curva normal. Vamos precisar escolher um teste inferencial não paramétrico.; 
               Os dados continuam não seguindo a curva normal. Vamos precisar transformar os dados por raiz quadrada. 
CorrectAnswer: A distribuição dos dados agora segue a curva normal. Podemos avançar para a análise inferencial dos dados com testes estatísticos paramétricos.

- Class: cmd_question
# Output: "Ok. Os dados transformados por log passaram no teste de normalidade, então podemos aplicar testes inferenciais paramétricos para checar nossas hipóteses de estudo. 
# Vamos relembrar as hipóteses desse experimento para a área de interesse N2? Espera-se que o tempo total de fixações no nível Gapping, da variável Estrutura, seja maior do que
# o TFD do nível Nongapping, uma vez que nesse ponto da frase, na condição Gapping, há uma elipse, deixando a estrutura mais complexa do que na condição Nongapping. Com relação 
# a VI Nome_tipo, espera-se que a média de TFD do nível NPróprio seja menor do que a média de TFD do nível NComum, uma vez que a capitalização do nome próprio pode facilitar 
# a leitura do NP que está depois do conectivo 'e' como um sujeito de uma nova oração e não como um objeto coordenado. Vamos criar uma tabela com as médias de TFD para as 
# variáveis Estrutura e Nome_tipo, utilizando o comando aggregate. Digite: tab_N2 <- aggregate(TFD ~ Estrutura + Nome_tipo, data = dados_N2, mean)" 
tab_N2 <- aggregate(TFD ~ Estrutura + Nome_tipo, data = dados_N2, mean)

- Class: cmd_question
# Output: "Criamos a tabela em formato de dataframe. Vamos inspecionar a tabela que acabamos de criar? Digite o nome do dataframe no prompt." 
tab_N2

- Class: figure
# Output: "Para facilitar a leitura das médias de TFD pelas variáveis independentes, abrimos na aba plots um gráfico de linhas em que temos as médias de TFD no eixo y, 
# a VI Estrutura no eixo x e duas retas de cores diferentes separadas pela VI Nome_tipo."

- Class: text
# Output: "Aparentemente, temos uma diferença considerável de média de TFD em relação às estruturas Gapping (1252 e 1095) x estruturas Nongapping (847 e 895). 
# Essa diferença segue as previsões que fizemos para a variável Estrutura. No entanto, para a variável Nome_tipo, o comportamento das médias de TFD é ambíguo. 
# Temos uma diferença considerável entre as médias de Ncomum e Npróprio na estrutura Gapping (1252 X 1095), mas a diferença se inverte na Estrutura Nongapping 
# (847 x 895), sendo que o nível Npróprio é que possui média maior de TFD nessa estrutura. Para avaliarmos com mais precisão se as variáveis Estrutura e Nome-tipo 
# tiveram um efeito sobre o tempo total de fixações na leitura da área N2, vamos aplicar um teste de regressão linear, prevendo a interação entre as VIs 
# (uma vez que as retas no gráfico não são paralelas)." 

- Class: cmd_question
# Output: "Como já vimos, o comando para a regressão linear é lm(). Vamos aplicar o comando lm nos valores de TFD transformados por log, uma vez que os dados 
# só passaram no teste de normalidade após a transformação. Vamos guardar os resultados em um objeto chamado mod_N2. 
# Digite: mod_N2 <- lm(logTFD ~ Estrutura*Nome_tipo, data = dados_N2)"
mod_N2 <- lm(logTFD ~ Estrutura*Nome_tipo, data = dados_N2)

- Class: cmd_question
# Output: "Para visualizar os resultados do teste de regressão linear aplicado, usamos o comando summary(). Digite: summary(mod_N2)"
summary(mod_N2)

- Class: cmd_question
# Output: "O teste de regressão linear foi aplicado nos valores de TFD transformados por log. Vamos criar uma tabela com as médias de logTFD por condição 
# para nos auxiliar na interpretação dos resultados. Digite: tab_log <- aggregate(logTFD ~ Estrutura + Nome_tipo, data = dados_N2, mean)"
tab_log <- aggregate(logTFD ~ Estrutura + Nome_tipo, data = dados_N2, mean)

- Class: cmd_question
# Output: "Agora vamos inspecioná-la. Digite: tab_log"
tab_log

- Class: text
# Output: "Começando nossa análise pelos resíduos, podemos observar que os valores absolutos de mínimo e máximo são bem próximos (-1.65 e 1.47) e que 
# a mediana também é próxima de zero (0.00037). Isso nos indica que nossos dados seguem a distribuição normal. No entanto, essa informação já era esperada, 
# uma vez que normalizamos os dados a partir da transformação por log."

- Class: mult_question
# Output: "Vamos então analisar a parte mais importante da saída do teste, o quadro de Coeficientes. Para interpretarmos as comparações feitas neste quadro, 
# precisamos saber quais são os níveis das VIs que estão no Intercept. Lembrando que o R organiza os níveis das variáveis em ordem alfabética, selecione 
# a opção abaixo que traz os níveis das VIs que foram tomados como referência para o teste aplicado." 
AnswerChoices: Gapping:Ncomum;
               Gapping:Nproprio;
               Nongapping:Ncomum
CorrectAnswer: Gapping:Ncomum

- Class: text
# Output: "Acertou quem escolheu a opção Gapping:Ncomum. Observe que o valor que aparece no Estimate para o Intercept é exatamente o valor da média de logTFD 
# para os níveis Gapping e Ncomum na tabela tab_log (6.95457). Como vimos anteriormente, o valor de p no intercept não nos diz muita coisa, pois a comparação 
# feita aqui pelo R é entre o valor da média da VD do nível de referência da VI que está no intercept e zero. Um valor de p<0.05 nesta linha só significa que 
# a média de logTFD para Gapping:Ncomum é diferente de zero." 

- Class: text
# Output: "Na segunda linha, temos a indicação da variável Estrutura no nível Nongapping. Isso quer dizer que, na segunda linha, o R comparou as médias de logTFD 
# do intercept (Gapping:Ncomum) com a Estrutura Nongapping, mantendo constante o nível Ncomum para a VI Nome_tipo. O valor do slope (Estimate) aqui é -0.39002. 
# Se consultarmos a tab_log que criamos, podemos ver que -0.39 é a diferença entre as médias de logTFG de Nongapping:Ncomum xGapping:Ncomum  (6.56 - 6.95). 
# O erro padrão (Std. Error) é bem baixo = 0.08 e o valor de t = -4.483. O valor de t deve ser tomado como valor absoluto (despreza-se o sinal), 
# o que nos leva a um valor de p= 9.8e-06, menor do que o nível de significância 0.05. Este resultado nos diz que o tipo de Estrutura tem um efeito sobre o 
# tempo total de fixações do olhar na leitura da área N2 no experimento com as sentenças ambíguas com elipse. A correlação entre o nível Nongapping e a média 
# de logTFD é descrescente, ou seja, o valor da média de TFD diminui na condição Nongapping em relação à condição Gapping." 

- Class: text
# Output: "Na terceira linha, temos a indicação da variável Nome_tipo no nível Nproprio. Isso significa que o R vai comparar as médias de logTFD de 
# Gapping:Ncomum x Gapping:Nproprio. Se consultarmos mais uma vez a tab_log que criamos, veremos que os valores das médias de logTFD dessas condições 
# são: 6.954 e 6.834, o que gera a diferença de -0.119 entre as médias. O valor do erro padrão para essa comparação é também de 0.08 e o valor de t = -1.376. 
# O valor de p=0.170 nos indica que não podemos rejeitar a hipótese (nula) de que a diferença entre as médias de logTFD de Gapping:Ncomum x Gapping:Nproprio 
# é igual a zero. Ou seja, interpretamos que a variável Nome_tipo não exerceu nenhum efeito sobre as médias de logTFD no experimento em questão."   

- Class: text
# Output: "A quarta e última comparação feita no teste de regressão foi entre as condições Gapping:Ncomum x Nongapping:Nproprio. O slope calculado para essa 
# comparação é o resultado da aplicação da função de 1o grau, levando em consideração os valores dos slopes (ou coeficientes angulares) calculados anteriormente. 
# Como podemos observar pelos valores de t = 1.635 e p = 0.103, não houve um efeito de interação entre os níveis das VIs em estudo (não rejeitamos a H0)."  

- Class: cmd_question
# Output: 'Uma maneira sempre ilustrativa de reportar dados estatísticos é através de gráficos. Vamos então confeccionar um gráfico de efeitos do nosso modelo 
# de regressão linear. Digite: plot(allEffects(mod_N2), grid = T, main = "Efeito das variáveis Estrutura e tipo de Nome \n nas médias de TFD")'
plot(allEffects(mod_N2), grid = T, main = "Efeito das variáveis Estrutura e tipo de Nome \n nas médias de TFD")

- Class: cmd_question
# Output: 'O gráfico que desenhamos possui dois quadros, um para cada nível da variável Nome_tipo. A vantagem desse gráfico é que as barras mostram o intervalo 
# de confiança das médias, ou seja, temos uma informação a mais, além das médias. No entanto, se você preferir, podemos plotar o gráfico com as duas variáveis 
# em um único quadro, basta acrescentar o argumento "multiline = T" na linha de comando. Vamos testar? Digite: plot(allEffects(mod_N2), grid = T, multiline = T, 
# main = "Efeito das variáveis nas médias de TFD")' 
plot(allEffects(mod_N2), grid = T, multiline = T, main = "Efeito das variáveis nas médias de TFD")

- Class: cmd_question
# Output: "Além do gráfico, podemos (e devemos) utilizar uma tabela com as informações do quadro de Coeficientes do teste de regressão linear para reportar 
# nossos resultados. Para criar essa tabela, precisamos do pacote sjPlot. Caso você não tenha esse pacote no seu R, faça a instalação e abra o pacote com o 
# comando library() antes de rodar a linha de comando a seguir. Digite: tab_model(mod_N2)"  
tab_model(mod_N2)

- Class: text
# Output: "Terminamos aqui nossa lição sobre o teste de Regressão linear. Para saber mais sobre este teste estatístico inferencial, recomendo a leitura do 
# cap. 7, do livro 'How to do Linguistics with R', de Natalia Levshina (2015). Até breve!"

