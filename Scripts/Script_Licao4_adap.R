- Class: meta
Course: EBAL
Lesson: Licao_4
Author: Aline Alves Fonseca
Type: Standard
Organization: Universidade Federal de Juiz de Fora
Version: 2.4.5

- Class: text
# Output: "Nas lições anteriores, aprendemos a calcular algumas métricas importantes da estatística descritiva
# como a média, a mediana e o desvio padrão, aprendemos a inspecionar os dados para encontrar outliers e 
# excluí-los, aprendemos sobre a distribuição normal de dados numéricos e contínuos, e aprendemos a aplicar testes 
# de normalidade e a transformar os dados com fórmulas matemáticas para adequá-los à distribuição normal. 
# Tudo isso que aprendemos são passos importantes para se chegar aos testes estatísticos inferenciais, também 
# chamados de testes de hipóteses. Nesta lição, vamos aprender um pouco sobre um dos mais simples testes 
# estatísticos inferenciais paramétricos, o teste T de Student."  

- Class: text
# Output: "O teste T de Student foi desenvolvido por Willian Sealy Gosset em 1908. Gosset havia sido contratado como 
# químico da Cervejaria Guiness e desenvolveu o teste para comparar amostras da cerveja tipo Stout e garantir o controle
# de qualidade do produto. Gosset escreveu um artigo sobre seu teste, mas por questões de sigilo industrial, usou o 
# pseudônimo 'Student'. Daí a origem do nome, Teste T de Student."  

- Class: text
# Output: "Os testes de hipóteses, como o teste T de Student, seguem algumas premissas que precisam ser contempladas 
# pelos dados que serão analisados, caso contrário invalidam sua aplicação. O teste T é utilizado para se comparar a 
# média amostral de duas condições (ou variáveis independentes) e segue as seguintes premissas: a) os participantes 
# do estudo devem ser selecionados randomicamente a partir da população; b) a variável resposta deve ser numérica 
# e contínua; c) a distribuição dos dados da amostra deve seguir a curva normal ou a amostra deve ter tamanho acima 
# de 30 observações; d) a variância da amostra deve ser homogênea."  

- Class: text
# Output: "O Teste T possui ainda duas características: i) ele pode ser aplicado em amostras independentes ou pareadas, 
# e ii) sua aplicação pode ser bidirecional ou unidirecional, de acordo com a hipótese alternativa formulada para o teste." 

- Class: cmd_question
# Output: 'Para ilustrar a aplicação do teste T de Student, vamos utilizar mais uma vez os dados da pesquisa sobre a 
# percepção de pares mínimos do português brasileiro por falantes estrangeiros aprendizes de Português como L2. 
# Vamos carregar nossa planilha de dados em um dataframe chamado "dados_BV". Copie e cole a linha de comando no 
# prompt: dados_BV <- read.csv("ple_esp_BV.csv", header = T, sep = ",")'
dados_BV <- read.csv("ple_esp_BV.csv", header = T, sep = ",")

- Class: cmd_question
# Output: 'Vamos transformar as sequências de caracteres em fatores no nosso dataframe. Para isso vamos usar o 
# comando "mutate_if". Digite a linha de comando a seguir no prompt da console. Não se esqueça que para que essa 
# linha de comando funcione, você precisa abrir o pacote "dplyr" com o comando library(dplyr). 
# dados_BV<- dados_BV%>% mutate_if(sapply(dados_BV, is.character), as.factor)'
dados_BV<- dados_BV%>% mutate_if(sapply(dados_BV, is.character), as.factor)

- Class: cmd_question
# Output: "Agora vamos inspecionar os dados? Vamos começar com o comando str(). Digite: str(dados_BV)"
str(dados_BV)

- Class: cmd_question
# Output: "O outro comando de inspeção de dados que nos reporta as medidas básicas da estatística descritiva 
# das variáveis numéricas e mais informações sobre as variáveis nominais é o comando summary(). 
# Digite: summary(dados_BV)"
summary(dados_BV)

- Class: text
# Output: "Nosso dataframe 'dados_BV' tem 80 observações de 7 variáveis: Teste, Participante, L1, Cond, Item_RE, 
# Resposta, TR_ms. As variáveis independentes são o teste (se T1 ou T2), a condição (pares mínimos de [b] x [v] 
# tipo 'bento x vento'), a L1 do participante (Espanhol), os participantes e os itens experimentais. As variáveis 
# dependentes são a acurácia na identificação da palavra (Resposta certa ou errada) e o tempo gasto para responder 
# cada item (TR em milissegundos). Neste experimento, queremos testar se instruções explícitas sobre as características 
# acústicas e fisiológicas dos sons [b] e [v] para falantes de Espanhol aprendizes de Português como L2 aumentam a 
# acurácia dos participantes na identificação dos itens lexicais com os sons foneticamente semelhantes [b] e [v] 
# e se diminuem o tempo gasto na tarefa de identificação dos itens. Ou seja, para o tempo de resposta (TR) nossa 
# hipótese nula (H0) é de que TR em T1 = TR em T2, e nossa hipótese alternativa (H1) é de que TR em T1 > TR em T2."  

- Class: text
# Output: "Nossa amostra de dados é então do tipo pareada, já que temos os mesmos participantes respondendo a estímulos
# em dois momentos distintos, antes e depois de instruções fonéticas explícitas sobre a diferença entre [b] e [v] e nossa 
# H1 é unidirecional, já que esperamos que os tempos de resposta no Teste 1 sejam maiores que os tempos de resposta no Teste 2."  

- Class: text
# Output: "O 1o passo para a escolha do teste estatístico inferencial que vamos utilizar para analisar nossos dados é responder 
# a perguntas do tipo: 1) Qual é o nível de mensuração da variável resposta coletada em meu teste? 2) Quantas variáveis independentes 
# serão testadas e em quantos níveis? 3) Os dados coletados seguem as premissas dos testes de hipótese paramétricos?" 

- Class: text
# Output: "Respondendo a pergunta 1, nossa variável dependente é do tipo númerica e contínua. Respondendo a pergunta 2, vamos testar 
# uma variável independente de dois níves Teste 1 e Teste 2. Para responder a pergunta 3, precisamos saber se os dados foram coletados 
# de uma amostra aleatória da população, se os dados seguem a distribuição normal, e se a variância da amostra é homogênea. Podemos 
# considerar que os dados foram coletados a partir de uma amostra aleatória da população de falantes de Espanhol aprendizes de Português 
# como L2, já que não houve nenhuma seleção prévia para determinar quais seriam os participantes do estudo. Sobre a homogeneidade da 
# variância, não precisamos nos preocupar agora porque o teste T realizado no R traz um algoritmo de ajuste para a variância
# (correção de Welch) que dispensa testes de homogeneidade prévios. Por último, precisamos saber se nossa amostra segue a distribuição 
# normal. Para isso vamos começar analisando a distribuição dos dados com o boxplot para identificarmos outliers e excluí-los, se for o caso."

- Class: cmd_question
# Output: "Vamos criar um boxplot com a fórmula VD ~ VI, range = 3, e limites do eixo y baseados nos valores de mínimo e máximo de TR_ms 
# (role a console para recuperar essa informação na saída do comando summary(), realizado anteriormente). Crie a linha de comando com 
# as informações solicitadas no prompt."  
boxplot(TR_ms ~ Teste, data = dados_BV, range = 3, ylim = c(1470, 21250))

- Class: cmd_question
#Output: "Pela inspeção visual dos dados, podemos checar que nossa amostra possui outliers. Ainda pela inspeção visual do gráfico, 
# podemos determinar que o limite superior da amostra está em cerca de 10.000ms. Vamos usar este valor como teto para o corte dos 
# outliers. Digite a linha de comando seguinte no prompt: dados_BV = dados_BV %>% filter(TR_ms < 10000)"
dados_BV = dados_BV %>% filter(TR_ms < 10000)

- Class: cmd_question
# Output: "Agora que já excluímos os outliers, vamos checar a distribuição dos dados a partir do gráfico de frequência chamado histograma. 
# Vamos fazer um primeiro histograma com as configurações default do sistema, mas vamos acrescentar o argumento 'prob=TRUE' para que o eixo 
# y fique ajustado para a densidade de ocorrência das observações. Isso será importante para o passo seguinte, quando desenharemos a curva 
# da densidade amostral junto ao histograma. 
# Digite no prompt: hist(dados_BV$TR_ms, prob=TRUE)
hist(dados_BV$TR_ms, prob=TRUE)

- Class: cmd_question
# Output: 'Vamos agora desenhar a curva de densidade amostral junto ao histograma para verificarmos se a densidade amostral segue a curva normal. 
# Para isso vamos usar os comandos "curve" e "dnorm". A curva que será desenhada no histograma usa as informações de média e desvio padrão da amostra.
# Copie e cole a linha de comando seguinte no prompt: curve(dnorm(x, mean=mean(dados_BV$TR_ms), sd=sd(dados_BV$TR_ms)), add=TRUE, col = "red")' 
curve(dnorm(x, mean=mean(dados_BV$TR_ms), sd=sd(dados_BV$TR_ms)), add=TRUE, col = "red")

- Class: cmd_question
# Output: "Aparentemente os dados da nossa amostra de TRs não seguem a distribuição normal. A curva de densidade amostral não é simétrica a partir do pico
# de frequência. Na verdade, a curva possui uma cauda para a direita, o que indica que o valor da média é maior que o valor da mediana. Para termos certeza 
# de que os dados não seguem a distribuição normal, precisamos aplicar um Teste de normalidade. Vamos aplicar o teste de Shapiro-Wilk. Lembre-se que para que 
# este teste funcione, é preciso abrir o pacote 'nortest' com o comando library(nortest). Digite: shapiro.test(dados_BV$TR_ms)" 
shapiro.test(dados_BV$TR_ms)

- Class: cmd_question
# Output: "Como prevíamos, os dados não passaram pelo teste de normalidade de Shapiro-Wilk. Encontramos um p = 9.644e-05, que é um valor bem abaixo de 0.05. 
# Este resultado indica que devemos rejeitar a hipótese nula de que a amostra possui distribuição normal e devemos acatar a hipótese alternativa de que os 
# dados amostrais não seguem a distribuição normal. Como vimos na lição anterior, podemos tentar adequar os dados à distribuição normal através de transformações 
# matemáticas. Vamos fazer isso, começando pela transformação logarítmica. Vamos criar uma nova coluna em nosso dataframe com os valores de TR transformados 
# por log e vamos chamá-la de 'logTR_ms'. Digite: dados_BV$logTR_ms <- log(dados_BV$TR_ms)" 
dados_BV$logTR_ms <- log(dados_BV$TR_ms)


- Class: cmd_question
# Output: "Se observarmos no 'Environment', nosso dataframe agora conta com 8 variáveis porque acrescentamos a variável 'logTR_ms' com os valores de TR transformados 
# por logaritmo. Vamos aplicar o teste de normalidade Shapiro- Wilk nos dados transformados por log. Digite a seguinte linha de comando no prompt: 
#shapiro.test(dados_BV$logTR_ms)"   
shapiro.test(dados_BV$logTR_ms)

- Class: cmd_question
# Output: 'Opa! A saída do teste de Shapiro-Wilk com os dados normalizados por log nos deu um valor de p=0.7144. Este valor é maior do que o nível de significância 0.05. 
# Isso quer dizer que aceitamos a H0 que diz que os dados da amostra seguem a distribuição normal. Vamos desenhar um novo histograma para verificarmos visualmente as mudanças? 
# Vamos fazer um histograma um pouco mais personalizado, vamos colocar um título e escolher uma cor diferente de cinza para as barras. Digite: hist(dados_BV$logTR_ms, prob=TRUE, 
# main = "Histograma e curva de densidade dos dados \n transformados por log", col = "lightyellow")' 
hist(dados_BV$logTR_ms, prob=TRUE, main = "Histograma e curva de densidade dos dados \n transformados por log", col = "lightyellow")


- Class: cmd_question
# Output: 'Agora vamos desenhar a curva de densidade amostral dos dados transformados. 
# Digite: curve(dnorm(x, mean=mean(dados_BV$logTR_ms), sd=sd(dados_BV$logTR_ms)), add=TRUE, col = "red")'
curve(dnorm(x, mean=mean(dados_BV$logTR_ms), sd=sd(dados_BV$logTR_ms)), add=TRUE, col = "red")


- Class: cmd_question
# Output: "Para fechar a nossa checagem visual da distribuição dos nossos dados transformados, vamos calcular a média de LogTR_ms e em seguida desenhar uma linha no nosso gráfico 
# com o valor da média. Para calcular a média, use a função mean()." 
mean(dados_BV$logTR_ms)

- Class: cmd_question
# Output: 'Agora vamos desenhar a linha do valor da média no histograma com o comando abline(). Digite: abline( v= 8.14, col = "blue")' 
abline( v= 8.14, col = "blue")

- Class: text
# Output: "Agora nosso gráfico está completo! Podemos observar que a média amostral coincide com o pico de frequência e com o pico de densidade amostral e que a curva de densidade 
# vai diminuindo de forma simétrica a partir da média em direção as extremidades. Ou seja, a distribuição dos dados de TR transformados por log segue a curva normal. Com isso, 
# respondemos a pergunta 3 sobre as premissas dos testes de hipótese paramétricos e podemos escolher aplicar na análise dos nossos dados um teste paramétrico (também chamados 
# de testes clássicos). Vamos aplicar o teste T de Student pois temos uma variável dependente numérica e contínua, estamos testando apenas uma condição de dois níveis e nossos 
# dados seguem a distribuição normal. Atendemos todas as exigências para a aplicação adequada do teste estatístico escolhido." 

- Class: text
# Output: "Como dissemos anteriormente, nossa amostra é pareada porque os mesmos sujeitos realizaram as tarefas da condição Teste 1 e Teste 2 em dois momentos distintos, antes 
# e depois de receberem instruções explícitas sobre as diferenças fonéticas dos sons envolvidos nos itens lexicais do teste. As instruções alteraram o background dos participantes
# e nossa hipótese é de que essa mudança influenciará a percepção dos aprendizes, melhorando a acurácia de identificação dos itens lexicais e diminuindo o tempo de resposta na tarefa. 
# Vamos então criar uma pequena tabela com os valores de média dos dois testes para checar se nossa hipótese alternativa unidirecional procede. Para isso vamos usar o comando 'aggregate()'."

- Class: cmd_question
# Output: "O comando aggregate() possui como argumentos a fórmula VD ~ VI, data = o nome do dataframe, e o nome da operação matemática que queremos calcular. No nosso caso, queremos 
# calcular as médias de TR, então a função matemática que queremos é 'mean' . 
# Digite: aggregate(TR_ms ~ Teste, data = dados_BV, mean) "
aggregate(TR_ms ~ Teste, data = dados_BV, mean)


- Class: text
# Output: 'De fato, a média de TR no Teste 1 é maior do que a média de TR no Teste 2. Isso indica que nossa hipótese alternativa unidirecional procede. Agora precisamos checar se essa 
# diferença entre as médias é estatisticamente significativa. Para isso vamos usar o teste T. O comando para executar o teste T no R é t.test(). Este comando usa como argumentos a 
# fórmula dataframe$VD ~ dataframe$VI, paired = TRUE ou FALSE, e alternative = "two.sided" ou "greater" ou "less". No R, a sintaxe de fórmula (y ~ x) pressupõe amostras independentes. 
# Quando realizamos um teste pareado, o R exige que passemos dois vetores separados para alinhar as observações par a par. O valor default para o argumento paired é, portanto, FALSE. 
# Já o argumento "alternative" possui como valor default "two.sided" que significa que a hipótese alternativa testada para os dados é bidirecional, ou seja, testa-se apenas a diferença 
# entre as médias das duas condições experimentais e não se a média X é maior que a média Y, que é indicada pelo valor "greater", ou se a média X é menor do que a média Y, que é indicada 
# pelo valor "less".' 

- Class: cmd_question
# Output: 'Vamos então aplicar o teste T de Student aos nossos dados? Duas observações importantes: a) como vimos anteriormente, nossa VD será os valores de TR transformados por log, 
# pois são os dados trasformados que seguem a distribuição normal, b) Como o nosso teste é pareado, precisamos definir dentro do comando t.test quais são os dois subgrupos testados. 
# No nosso caso, os subgrupos foram T1 = antes das instruções e T2 = depois das instruções. Digite: t.test(dados_BV$logTR_ms[dados_BV$Teste == "T1"], dados_BV$logTR_ms[dados_BV$Teste == "T2"], 
# paired = TRUE, alternative = "greater")'
t.test(dados_BV$logTR_ms[dados_BV$Teste == "T1"], dados_BV$logTR_ms[dados_BV$Teste == "T2"], paired = TRUE, alternative = "greater")

- Class: text
# Output: "A saída do teste T nos dá o nome do teste 'Paired t-test', nos informa a fonte dos dados analisados 'dados_BV$logTR_ms by dados_BV$Teste', nos dá os valores da estatística 
# t = 3.3887, o valor dos graus de liberdade df = 37 e o valor de p=0.0008401. Uma vez que o valor de p foi menor que o nível de significância 0.05, podemos rejeitar a H0 e assumir a H1. 
# Na 3a linha da saída do teste temos essa informação: 'alternative hypothesis: true difference in means is greater than 0', que siginifica que a diferença entre as médias das duas 
# condições testadas é maior de zero. Ou seja, podemos assumir nossa hipótese alternativa de que as médias de TR no Teste 1 são significativamente maiores do que as médias do Teste 2. 
# Na sequência, temos o intervalo de confiança de 95% : 0.1586216 - Inf. O intervalo de confiança nos informa que se o experimento fosse replicado várias vezes com amostras da mesma população, 
# a diferença entre as médias ficaria entre 0.1586217 e o infinito com 95% de probabilidade. Observe que o intervalo de confiança para estes dados não incluiu o valor 0 ou valores negativos. 
# Isso significa que podemos confiar no resultado de p e na afirmação da hipótese alternativa de que a diferença entre a média de TR em T1 é verdadeiramente maior do que a média de TR em T2. 
# Por fim, a saída do teste nos dá o valor da diferença entre as médias das duas condições testadas = 0.3158941." 

- Class: text
# Output: "Para reportamos o resultado do teste T em artigos e textos acadêmicos, devemos indicar o valor da estatística t, o valor dos graus de liberdade (df) e o valor de p. Se estivéssemos 
# reportando os resultados do nosso estudo, a descrição ficaria assim: Aplicamos um teste T de amostras pareadas e unidirecional aos dados de tempo de resposta na identificação de itens lexicais 
# do português com o par de sons foneticamente semelhantes [b] e [v] dos falantes de Espanhol, aprendizes de Português como L2, antes e depois de receberem instruções explícitas sobre as diferenças 
# fonéticas entre os sons em estudo. Os resultados apontam para um menor tempo de resposta na identificação das palavras na tarefa realizada após a instrução explícita (Teste 2) com t= 3.38, df = 37 e p < 0.001." 

- Class: video
# Output: "É importante relatar o valor da estatística t e o valor dos graus de liberdade porque estes valores estão diretamente relacionados com o nível de significância (p) do teste aplicado. 
# Os valores da estatística t formam uma tabela em que as linhas referem-se aos valores do grau de liberdade (n-1) e as colunas referem-se aos níveis de significância. Dessa maneira, se soubermos 
# quais são os valores de t e de df (graus de liberdade), podemos dizer, consultando a tabela t, qual é o valor aproximado de p. A título de ilustração, vamos abrir na web uma tabela de distribuição t. 
# Responda 'Y' na pergunta abaixo se quiser abrir a tabela agora."
# Link: https://sites.icmc.usp.br/francisco/SME0123/listas/Tabela_Dist_t.pdf

- Class: text
# Output: "Vamos ver se entendemos bem a diferença entre amostras pareadas e indenpedentes? Vou dar alguns exemplos e vocês vão escolher nas opções se o experimento citado tem amostras pareadas, 
# independentes ou nenhuma das opções."

- Class: mult_question
# Output: "Exemplo 1: Selecionamos dois grupos de estudantes de Inglês como L2, um grupo de nível avançado e um grupo de nível intermediário. Em uma tarefa de leitura, medimos a velocidade com 
# que os participantes liam frases com palavras pouco frequentes e muito frequentes. De que tipo é essa amostra?" 
AnswerChoices: Independente; 
               Pareada; 
               Nenhuma das opções
CorrectAnswer: Independente


- Class: mult_question
# Output: "Exemplo 2: Selecionamos dois grupos de falantes nativos de Português Brasileiro, um grupo de falantes mineiros de Belo Horizonte e um grupo de falantes baianos de Salvador. 
# Realizamos um teste de produção a partir da leitura de palavras com as vogais médias /e/ e /o/ na posição pretônica e depois analisamos acusticamente os valores de F1 das vogais 
# produzidas pelos dois grupos. Lembrando que o valor de F1 está associado com a abertura das vogais, quanto maior o valor de F1, mais aberta as vogais são. De que tipo é essa amostra?"  
AnswerChoices: Independente;
               Pareada;
               Nenhuma das opções
CorrectAnswer: Independente

- Class: mult_question
# Output: "Exemplo 3: Selecionamos dois grupos de participantes, um grupo de estudantes do ensino médio e um grupo de estudantes universitários. Apresentamos ao grupo dois fragmentos
# de um mesmo texto, mas em duas codições distintas, primeiro sem que houvesse qualquer informação sobre a natureza ou o assunto do texto (sem contexto) e depois explicando para os 
# participantes a natureza e o assunto do texto (com contexto). Medimos o tempo gasto na leitura do texto nas duas condições para cada grupo de participantes e em seguida medimos 
# as taxas de acerto e erro de perguntas sobre os trechos em um teste de compreensão. De que tipo é essa amostra?" 
AnswerChoices: Indenpendente;
               Pareada;
               Nenhuma das opções
CorrectAnswer: Pareada

- Class: text
# Output: "Agora vamos verificar se entendemos as opções de direcionalidade da hipótese alternativa no teste T de Student. Vou dar alguns exemplos e vocês vão me dizer se a H1 é 
#'two.sided', 'greater' ou 'less'."

- Class: mult_question
# Output: " No exemplo 1, comparamos a velocidade de leitura de palavras pouco frequentes em dois grupos de estudantes de Inglês como L2, um grupo avançado e um grupo intermediário. 
# Esperamos que o grupo de alunos avançados leia as palavras pouco frequentes mais rapidamente do que o grupo de alunos intermediários. Qual é a direção dessa H1?"
AnswerChoices: Less;
               Greater; 
               Two sided
CorrectAnswer: Less


- Class: mult_question
# Output: "No exemplo 2, medimos os valores de F1 das vogais /e/ e /o/ produzidas na posição pretônica por falantes mineiros e baianos. Esperamos que os valores de F1 das vogais 
# produzidas pelos baianos sejam maiores do que os valores de F1 das vogais produzidas pelos mineiros. Qual é a direção dessa H1?"
AnswerChoices: Greater; 
               Less; 
               Two sided
CorrectAnswer: Greater


- Class: mult_question
# Output: "No exemplo 3, resolvemos verificar se, dentro do grupo de estudantes do ensino médio, encontraríamos diferenças entre estudantes do sexo feminimo e estudantes do sexo 
# masculino no tempo de leitura do trecho do texto na condição sem contexto. Acreditamos que haja uma diferença de tempo de leitura associada ao sexo, mas não sabemos supor qual 
# dos grupos terá tempo de leitura maior. Qual é a direção dessa H1?"
AnswerChoices: Two sided; 
               Less; 
               Greater
CorrectAnswer: Two sided

- Class: text
# Output: "Nos casos em que as premissas do teste de hipóteses paramétrico não são atendidas, principalmente no que diz respeito à distribuição e à natureza dos dados, podemos 
# alternativamente aplicar testes de hipóteses não-paramétricos. O teste de hipótese não paramétrico similar ao teste T de Student é o chamado Teste de Wilcoxon. O cálculo do 
# teste de Wilcoxon é baseado em um rankeamento das observações dos grupos que estão sendo testados e na diferença entre as medianas dos grupos e não sobre a diferença entre 
# as médias como no teste T. O comando para a realização do teste de Wilcoxon no R é 'wilcox.test()' e usa como argumentos elementos semelhantes ao teste T."  

- Class: text
# Output: "Encerramos aqui nossa lição 4. Para saber mais sobre os testes T e de Wilcoxon, aconselho a leitura do cap. 5 de livro da Levshina (2015) 'How to do linguistics with R'. Até mais!"


