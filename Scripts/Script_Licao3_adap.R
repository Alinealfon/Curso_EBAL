- Class: meta
Course: EBAL
Lesson: Licao_3
Author: Aline Alves Fonseca
Type: Standard
Organization: Universidade Federal de Juiz de Fora
Version: 2.4.5

- Class: text
#Output: "Nesta lição, vamos falar de distribuição normal e formas de 
#normalização de dados numéricos e contínuos. Mas o que é uma distribuição 
#normal? " 

- Class: text
#Output: " Uma distribuição estatística é uma função que define uma curva, 
#e a área sob essa curva determina a probabilidade de ocorrer o evento por 
#ela correlacionado. A Distribuição normal de variáveis contínuas é aquela 
#que segue a curva normal, ou curva gaussiana. A curva normal tem seu pico 
#de frequência na média amostral e a maioria dos dados estão em torno da 
#média de forma simétrica. Frederick Gauss, no século XIX, observou a partir 
#de estudos sobre eventos da natureza que muitas distribuições amostrais 
#seguiam um padrão e se distribuíam com mais frequência em torno da média. 
#Dados como peso e altura dos seres humanos são exemplos de dados que seguem 
#a distribuição normal."

- Class: figure
#Output: " A distribuição normal é representada pela curva normal, aquela famosa
#com formato de sino. A função matemática da curva normal leva em consideração 
#os valores de média e desvio padrão da amostra. Vejamos na aba plots um gráfico 
#de distribuição de um amostra de dados x em função da frequência de x."


- Class: text
#Output: "Grande parte dos testes estatísticos inferenciais usam medidas de 
#tendência central como a média e a variância. Para esses testes, a normalidade 
#da distribuição dos dados numéricos contínuos é um pré-requisito. Por isso, 
#nessa lição, vamos aprender a fazer histogramas que são gráficos de frequência 
#e a fazer testes de normalidade. Quando nossos dados não passam pelo crivo dos 
#testes de normalidade, ainda temos a alternativa de tentar normalizá-los a partir 
#da aplicação de transformações matemáticas. Também vamos ver algumas dessas 
#alternativas de transformação dos dados nessa lição. Se mesmo após a transformação, 
#os dados não passarem nos testes de normalidade, a indicação é realizar testes 
#inferênciais chamados de não-paramétricos." 

- Class: cmd_question
#Output: 'Vamos usar como nossa primeira amostra de dados uma planilha com as notas 
#fictícias de uma prova de redação de 100 candidatos em um processo seletivo para 
#a Universidade de Faz de Conta. Vamos carregar a planilha no R em um dataframe chamado 
#"dados_n". Digite no prompt: dados_n <- read.csv("dados_norm1.csv", header = T, sep = ",")' 
dados_n <- read.csv("dados_norm1.csv", header = T, sep = ",")

- Class: cmd_question
#Output: "Podemos observar no 'Enviroment' que nosso dataframe tem 100 observações 
#de 2 variáveis. Vamos observar a estrutura do nosso dataframe por meio do comando 
#'str()'. Digite str(dados_n)"
str(dados_n)

- Class: cmd_question
#Output: "Nosso dataframe possui duas variáveis 'Candidatos' e 'notas'. A variável 
#'Candidatos' é do tipo 'chr' e a variável 'notas' é do tipo 'num'. Isso significa 
# que as observações da variável 'Canditados' são formadas por uma sequência de 
# caracteres (letras e números ou somente letras), e que as observações de 'notas' 
# são formadas por uma sequência de números não inteiros. Para que possamos realizar 
# vários testes estatísticos no R, precisamos transformar a sequência de caracteres 
# em fatores. Isso faz com que o R entenda as observações da variável 'Candidatos' 
# como uma sequência de níveis ou categorias da variável. Vamos usar a linha de comando 
# a seguir para realizar essa transformação. 
# Digite: dados_n <- dados_n %>% mutate_if(sapply(dados_n, is.character), as.factor)"
dados_n <- dados_n %>% mutate_if(sapply(dados_n, is.character), as.factor)

- Class: cmd_question
#Output: "Agora vamos inspecionar os dados novamente com o comando 'str()'. 
#Digite: str(dados_n)"
str(dados_n)

  
  - Class: cmd_question
# Output: "Pronto! Agora nossa variável 'Candidatos' é um fator com 100 níveis. 
# Um outro comando importante de inspeção de dados (que já vimos em lições anteriores) 
# é o 'summary()'. Com o comando summary podemos checar alguns dados de estatística 
# descritiva de dados numéricos e podemos checar totais de níveis/categorias de variáveis 
# do tipo 'factor'. Vamos testar este comando em nosso dataframe? 
# Digite: summary(dados_n)" 
summary(dados_n)

- Class: text
# Output: "Com o comando summary podemos observar os valores de mínimo, máximo, média, mediana, 
# 1o quartil e 3o quartil da variável numérica 'notas' e o número de ocorrências de alguns dos 
# níveis da variável 'Candidatos'."

- Class: cmd_question
# Output: "Vamos fazer um boxplot com os parâmetros default do R só para checar graficamente a 
# distribuição dos dados. Digite: boxplot(dados_n$notas)" 
boxplot(dados_n$notas)

- Class: cmd_question
# Output: "Outro gráfico importante para a inspeção dos dados é o histograma. 
# No eixo y  de um histograma, temos a frequência de ocorrência dos dados e no 
# eixo x temos os intervalos de valores da variável. Vamos ver como fazer um 
# histograma na prática? Digite: hist(dados_n$notas)" 
hist(dados_n$notas)

- Class: text
# Output: " Assim como no boxplot, podemos fazer um histograma mais personalizado. 
# Podemos escolher o número de barras que teremos no gráfico, podemos editar a escala 
# do eixo y e os rótulos dos eixos x e y, podemos escolher outra cor para as barras e 
# podemos colocar um título...além de outras coisinhas mais."

- Class: cmd_question
# Output: 'Vamos fazer isso? Copie e cole a linha de comando:  hist(dados_n$notas, breaks= 7, 
# ylim = c(0, 50), col = "lightblue", ylab = "Frequência", xlab = "notas", main = "Histograma de Notas")'
hist(dados_n$notas, breaks= 7, ylim = c(0, 50), col = "lightblue", ylab = "Frequência", xlab = "notas", main = "Histograma de Notas")

- Class: text
#Output: "Observe que, quando diminuímos o número de barras, aumentamos o intervalo de valores da 
# variável que está no eixo x e, consequentemente, temos que aumentar a escala de frequência, pois 
# teremos mais ocorrências em cada intervalo maior." 

- Class: figure
# Output: "Quando uma amostra de dados segue a distribuição normal, a área ocupada pelas barras em 
# seu histograma corresponde aproximadamente a área sob a curva de distribuição normal - a curva em 
# formato de sino. A imagem que abrimos na aba Plots é um histograma dos dados das notas dos Candidatos 
# do processo seletivo da Universidade de Faz de Conta, mais a curva de densidade amostral que corresponde
# a curva normal. Podemos observar que a maior parte do histograma está sob a curva e que as alturas das 
# barras correspondem aos pontos de mínimo e máximo da curva. Pela inspeção visual de um histograma, podemos 
# ter uma ideia se a distribuição da amostra está próxima da normalidade ou não. No entanto, só teremos 
# certeza deste fato se aplicarmos um teste estatístico de normalidade."

- Class: text
# Output: "Nosso próximo passo, então, é aplicar um teste de normalidade nos dados. Há dois testes muito 
# utilizados pelos estatísticos que são: o teste de normalidade Kolmogorov-Smirnov e o teste de normalidade
# Shapiro-Wilk. Os nomes dos testes fazem referência a seus desenvolvedores. Andrei Kolmogorov e Nikolai 
# Smirnov foram dois grandes matemáticos russos. Samuel Shapiro é um estatístico norte-americano e Martin 
# Wilk foi um estatístico canadense. Ambos os testes servem para averiguar se uma dada amostra de números 
# contínuos segue a distribuição normal ou Gaussiana. A hipótese nula de um teste de normalidade é de que 
# uma amostra númerica aleatória retirada de uma população segue a distribuição normal. Ambos os testes 
# estatísticos reportam um coeficiente e um valor de p. Uma vez que não queremos rejeitar a hipótese nula, 
# quando aplicamos um teste de normalidade, esperamos encontrar valores de p maiores que 0.05." 

- Class: cmd_question
# Output: 'Para realizar os testes de normalidade Kolmogorov-Smirnov e Shapiro_Wilk, usamos os comandos 
# lillie.test() e shapiro.test(), respectivamente. O argumento desses comandos deve ser a variável numérica 
# que se deseja testar. Para aplicar estes testes e outros testes de normalidade, precisamos ter instalado 
# e aberto o pacote "nortest". Então, caso o comando não funcione, siga as instruções das Obs. a seguir. 
# Obs: Primeiro vamos sair da Lição com o comando play(), em seguida, vamos instalar o pacote com o comando 
# install.packages("nortest") e depois abrir com o comando library(nortest). Em seguida, vamos voltar para 
# a Lição com o comando nxt(). Vamos começar testando os dados com o teste Komolgorov-Smirnov. 
# Digite: lillie.test(dados_n$notas)'
lillie.test(dados_n$notas) 


- Class: text
# Output: "Observe que a saída do teste nos dá a origem dos dados, um valor da estatística D e um valor de p. 
# Na aplicação do teste de Kolmogorov-Smirnov para os dados de notas, o valor de p = 0.9623. Isso significa que 
# não podemos rejeitar a hipótese nula que afirma que os dados numéricos de uma amostra aleatória retirada de 
# uma população seguem a distribuição normal. Ou seja, os dados de notas que acabamos de analisar seguem 
# a distribuição normal." 

- Class: cmd_question
# Output: "Agora vamos executar o teste de Shapiro Wilk? Digite: shapiro.test(dados_n$notas)"
shapiro.test(dados_n$notas)

- Class: text
# Output: "A saída do teste de Shapiro-Wilk também nos dá a origem dos dados, o valor da 
# estatística W e o valor de p. O valor de p do teste que realizamos foi p= 0.745. Os valores 
# de p são diferentes porque os testes usam fórmulas matemáticas diferentes em sua base de cálculos. 
# No entanto, assim como no teste de Kolmogorov-Smirnov, o valor de p foi p>0.05 o que indica 
# que não podemos rejeitar a hipótese nula e que os dados, portanto, são considerados normais."

- Class: video
# Output: "Agora que nós já aprendemos um pouco sobre distribuição normal e sobre os testes de 
# normalidade com dados fictícios, vamos aplicar o que aprendemos a dados reais de uma pesquisa 
# linguística. Para isso, vamos usar os dados de um dos testes realizado por Soares (2021) 
# que investigou o processamento de palavras homonímias e polissêmicas em sentenças ambíguas. 
# Para acessar o trabalho completo de Soares (2021), escolha 'Yes' na pergunta a seguir, digitando 'y'."
# Link: https://drive.google.com/file/d/1l9il23QTvoxhXRZhVane9th2JHXXGjE1/view

- Class: text
# Output: "Em um teste de leitura automonitorada, Soares (2021) mediu  o tempo de leitura de sentenças 
# ambíguas como 'A manga foi cortada (pelo vendedor, na loja./pela madrasta, no lanche.)'. A sentença 
# foi dividida em duas partes, a primeira continha a palavra ambígua (manga, no exemplo) e a segunda 
# continha a parte desambiguadora. Vamos utilizar os tempos de leitura da segunda parte aqui em nossa lição."  

- Class: cmd_question
# Output: 'Vamos carregar a planilha de dados de Soares (2021) no R, transformando-a em um dataframe. 
# Para isso, vamos usar o comando "read.csv". 
# Digite: dados_TL <- read.csv("dados_norm2.csv", header = T, sep = ",")'
dados_TL <- read.csv("dados_norm2.csv", header = T, sep = ",")

- Class: cmd_question
# Output: "Podemos observar no 'Environment' que o dataframe dados_TL possui 480 observações 
# e 7 variáveis. Vamos checar quais são essas variáveis? Para isso, podemos usar o comando str(). 
# Digite: str(dados_TL)" 
str(dados_TL)

- Class: cmd_question
# Output: "O dataframe dados_TL possui 5 variáveis categóricas do tipo 'chr' e duas variáveis 
# numéricas do tipo 'int', que significa 'números inteiros'. Precisamos transformar as variáveis 
# categóricas em fatores para que a sequência de caracteres seja lida como níveis das variáveis. 
# Vamos usar os comandos 'mutate_if() e sapply()'. 
# Digite: dados_TL <- dados_TL %>% mutate_if(sapply(dados_TL, is.character), as.factor)"
dados_TL <- dados_TL %>% mutate_if(sapply(dados_TL, is.character), as.factor)

- Class: cmd_question
# Output: "Agora podemos repetir o comando str() para conferir se a transformação funcionou. 
# Digite: str(dados_TL)"
str(dados_TL)

- Class: cmd_question
# Output: "Também podemos checar as estatísticas descritivas iniciais com o comando 'summary()'. 
# Digite: summary(dados_TL)" 
summary(dados_TL)

- Class: text
# Output: "A partir dos comandos str() e summary(), podemos ver que o experimento de Soares (2021) 
# possuia uma variável independente de 2 níveis, a variável 'Cond', cujo os níveis eram 'Homonímia' 
# e 'Polissemia'. O teste foi aplicado com 40 participantes e havia 12 frases experimentais. 
# Ao final da leitura, os participantes respondiam a uma pergunta de compreensão de múltipla escolha 
# com 4 opções de resposta. Com relação à variável dependente 'Tempo_leitura2', podemos observar que 
# o valor mínimo foi de 416ms e o máximo foi de 8766ms. A média e a mediana foram, respectivamente, 
# 1768ms e 1584ms. Nosso próximo passo é checar se a amostra de Soares (2021) possui outliers que 
# precisam ser excluídos para balancear os dados." 

- Class: cmd_question
# Output: 'Vamos construir um gráfico do tipo boxplot para checar se há outliers nos dados que 
# precisam ser excluídos. Nosso boxplot vai usar a fórmula VD ~ VI com range = 3 e limite inferior
# e superior do eixo y determinados pelos valores de mínimo e máximo da amostra. 
# Copie e cole a linha de comando a seguir no prompt: 
# boxplot(Tempo_leitura2 ~ Cond, range= 3.0, data = dados_TL, ylim= c(400, 9000), xlab= "TR por condição no fragmento 2", 
# ylab= "TR", main= "Boxplot TR por condição no fragmento 2",  col= "lightgreen")
boxplot(Tempo_leitura2 ~ Cond, range= 3.0, data = dados_TL, ylim= c(400, 9000), xlab= "TR por condição no fragmento 2", ylab= "TR", main= "Boxplot TR por condição no fragmento 2",  col= "lightgreen")


- Class: cmd_question
# Output: 'Além do boxplot, podemos fazer também um histograma para verificar se os dados_TL aparentam seguir a curva normal. 
# Vamos tentar? Digite: hist(dados_TL$Tempo_leitura2, main = "Histograma dados brutos")' 
hist(dados_TL$Tempo_leitura2, main = "Histograma dados brutos")

- Class: cmd_question
# Output: 'Podemos verificar no boxplot que a condição "Polissemia" possui outliers que estão acima de cerca de 
# 6000ms e no histograma podemos ver que os dados possuem uma cauda à direita, demonstrando que os dados estão 
# desbalanceados e confirmando a presença de outliers nos valores superiores da amostra. Para termos uma noção 
# mais precisa de um valor de corte para a exclusão dos outliers, vamos calcular o limite superior da distribuição 
# dos dados_TL. Para isso, vamos usar range = 3 e os valores dos quartis da variável "Tempo_leitura2" que vimos 
# com o comando summary(). A fórmula de cálculo do limite superior é Q3 + (Q3-Q1)*3. Guarde o resultado em um 
# objeto chamado "TL2_lsup".' 
TL2_lsup <- 2215 + (2215 - 1154)*3

- Class: cmd_question
# Output: 'Vimos no "Environment" que o valor do TL2_lsup = 5398ms. Vamos então aplicar um filtro nos dados com 
# o valor arredondado de 5500ms. Digite: dados_TL = dados_TL %>% filter(Tempo_leitura2 < 5500)'
dados_TL = dados_TL %>% filter(Tempo_leitura2 < 5500)


- Class: cmd_question
# Output: "Agora que já excluímos os outliers, vamos verificar novamente os valores da estatística descritiva 
# dos tempos de leitura do fragmento 2 dos dados_TL? Digite: summary(dados_TL$Tempo_leitura2)"
summary(dados_TL$Tempo_leitura2)

- Class: cmd_question
# Output: 'Podemos também fazer um novo histograma para checar se a exclusão dos outliers modificou a distribuição 
# dos dados em relação à frequência de ocorrência. 
# Digite: hist(dados_TL$Tempo_leitura2, main = "Histograma dados brutos sem outliers")' 
hist(dados_TL$Tempo_leitura2, main = "Histograma dados brutos sem outliers")

- Class: cmd_question
# Output: 'Agora vamos desenhar uma linha com o valor da média amostral em nosso histograma para verificarmos se o 
# pico de frequência coincide com a média. Essa é uma das características das distribuições normais, lembram-se? 
# Para desenhar a linha com a média, vamos usar o comando "abline()". Vamos usar como argumento desse comando o valor 
# da média da amostra e a vamos determinar a cor da linha que queremos desenhar no gráfico. Digite: abline(v = 1717, col = "red")'
abline(v = 1717, col = "red")

- Class: text
# Output: "Pela inspeção visual do histograma, podemos dizer que os tempos de leitura de dados_TL não parecem seguir 
# a distribuição normal. O pico de frequência não coincide com a média amostral e a distribuição dos dados não é simétrica 
# em relação a média. No  entanto, para termos certeza, precisamos aplicar os testes de normalidade."

- Class: cmd_question
# Output: "Vamos começar com o teste Kolmogorov-Smirnov. Digite: lillie.test(dados_TL$Tempo_leitura2)"
lillie.test(dados_TL$Tempo_leitura2)

- Class: text
# Output: "O valor de p dado na saída do teste de Kolmogorov-Smirnov foi p = 2.397e-09. Também podemos 
# ler esse número como 2,397 x 10^-9 ou ainda 0,000000002397. Ou seja, o valor de p é baixíssmo, muito 
# menor que 0.05. Neste caso, rejeitamos a H0 de que os dados seguem uma distribuição normal e aceitamos 
# a H1 de que os dados NÃO são normais."

- Class: cmd_question
# Output: "Vamos tentar agora o teste de Shapiro-Wilk? 
# Digite: shapiro.test(dados_TL$Tempo_leitura2)"
shapiro.test(dados_TL$Tempo_leitura2)

- Class: text
# Output: "O valor de p na saída do teste de Shapiro-Wilk foi p= 4.791e-14, que também pode ser escrito 
# p=0,00000000000004791! Ou seja, novamente temos um valor de p baixíssimo que nos faz rejeitar a hipótese
# nula que prevê uma distribuição normal da amostra e aceitar a hipótese alternativa que prevê que os dados 
# testados não seguem a distribuição normal. Nas próximas questões, vamos aprender a fazer algumas 
# tranformações matemáticas nos dados para tentar normalizá-los para que possamos utilizar testes estatísticos 
# inferenciais paramétricos em nossa amostra."

- Class: text
# Output: "Há várias maneiras diferentes de transformar dados para adequá-los a distribuição normal. Nesta lição, 
# vamos aprender 3 métodos, as transformações por raiz quadrada, logaritmo e por z-score. Vamos começar com a 
# transformação por raiz quadrada." 

- Class: cmd_question
# Output: "Para fazer a transformação por raiz quadrada, vamos usar o comando sqrt(). É interessante criar 
# uma nova coluna com os dados transformados em nosso dataframe para que possamos posterioremente aplicar 
# os testes de normalidade. Na linha de comando a seguir, vamos transformar os dados de tempo de leitura 
#'x' em raiz quadrada de 'x' e vamos guardar os resultados em uma nova coluna do dataframe dados_TL chamada
#'sqrtTL2'. Digite: dados_TL$sqrtTL2 <- sqrt(dados_TL$Tempo_leitura2)" 
dados_TL$sqrtTL2 <- sqrt(dados_TL$Tempo_leitura2)

- Class: cmd_question
# Output: "Observe no 'Environment' que agora o nosso dataframe dados_TL possui 8 variáveis. Isso aconteceu 
# porque acrescentamos uma coluna no dataframe com os dados de Tempo de Leitura transformados por raiz quadrada. 
# Agora vamos usar essa coluna do dataframe para aplicar os testes de normalidade, vamos começar com o teste 
# de Kolmogorov-Smirnov. Digite: lillie.test(dados_TL$sqrtTL2)"
lillie.test(dados_TL$sqrtTL2)

- Class: cmd_question
# Output: "A saída do teste nos dá um p=7.937e-05, ou seja, p<0.05. Rejeitamos a H0 e aceitamos a H1 que diz 
# que os dados NÃO seguem a distribuição normal. Vamos tentar o teste de Shapiro-Wilk para confirmar este resultado. 
# Digite: shapiro.test(dados_TL$sqrtTL2)"
shapiro.test(dados_TL$sqrtTL2)

- Class: text
# Output: "O resultado do teste de Shapiro-Wilk para o dados transformados por raiz quadrada também tem valor de p<0.05
# (p=1.883e-06). Concluímos então que a raiz quadrada não é um método adequado para a transformação dos dados de tempo 
# de leitura coletados." 

- Class: cmd_question
# Output: "Vamos passar para o método 2 e o mais comum entre os métodos de transformação de dados, a transformação logarítmica. 
# O comando que usaremos é o 'log()'. Assim como fizemos no método 1, vamos guardar o resultado da transformação dos tempos de 
# leitura em uma nova coluna do dataframe 'dados_TL'. Digite: dados_TL$logTL2 <- log(dados_TL$Tempo_leitura2)"
dados_TL$logTL2 <- log(dados_TL$Tempo_leitura2)

- Class: cmd_question
# Output: "Agora vamos aplicar os testes de normalidade. Vamos começar novamente com o teste de Kolmogorov-Smirnov. 
# Digite: lillie.test(dados_TL$logTL2)"
lillie.test(dados_TL$logTL2)

- Class: cmd_question
# Output: "A saída do teste de Kolmogorov-Smirnov com os dados transformados por log nos deu um p=0.01477. Apesar de 
# ser um valor consideravelmente maior do que os valores de p dos dados brutos ou transformados por raiz quadrada, 
# ainda é um valor abaixo de 0.05. Ou seja, ainda não podemos considerar os dados normais. Vamos realizar o teste 
# de Shapiro-Wilk para conferir. Digite: shapiro.test(dados_TL$logTL2)"
shapiro.test(dados_TL$logTL2)

- Class: cmd_question
# Output: 'Aham! No teste de Shapiro-Wilk para os dados transformados por log, encontramos p=0.09303. Temos p>0.05, 
# então podemos aceitar a H0 de que os dados da amostra seguem a distribuição normal. Vamos fazer um histograma 
# para comparar a distribuição dos dados transformados com os dados brutos? Digite: hist(dados_TL$logTL2, 
# main= "Histograma dados normalizados por Log", breaks = 7, col = "orange")'
hist(dados_TL$logTL2, main= "Histograma dados normalizados por Log", breaks = 7, col = "orange")

- Class: cmd_question
# Output: "Vamos desenhar a linha do valor da média no histograma para verificarmos se a média coincide com o pico 
# de frequência? Para isso precisamos primeiro saber qual é o valor da média. Podemos fazer isso com dois comandos 
# diferentes, com o comando summary() ou com o comando mean(). Vamos usar o comando mean(). Digite: mean(dados_TL$logTL2)"
mean(dados_TL$logTL2)

- Class: cmd_question
# Output: 'Agora vamos desenhar a linha com o comando abline(). Digite: abline(v = 7.36, col = "red")'
abline(v = 7.36, col = "red")

- Class: text
#Output: "Podemos observar que o valor da média está no pico de frequência dos dados e que há uma certa 
# simetria na distribuição dos dados a partir da média se comparado com a distribuição dos dados brutos. 
# Pela inspeção visual do histograma, podemos supor que os dados transformados por log se aproximam da 
# distribuição normal, o que de fato foi confirmado pelo teste de normalidade de Shapiro-Wilk."

- Class: cmd_question
# Output: "Se estivéssemos no processo de análise dos dados de uma pesquisa, poderíamos parar os teste 
# de normalidade aqui porque a transformação por log foi bem sucedida. Nossa próxima etapa seria a aplicação 
# do teste estatístico inferencial paramétrico mais adequado para os dados. No entanto, como estamos em 
# uma lição, vamos aprender mais um método de transformação de dados, o método chamado z-score. 
# Nesse método, aplica-se uma fórmula matemática aos dados que se baseia nos valores da média e do desvio padrão
# amostral. A fórmula é z = (x - média)/sd, onde x é o valor de cada observação da amostra. O R possui um comando 
# que faz esse cálculo automaticamente, o comando 'normalize()'. Este comando está dentro de um pacote chamado 'som'. 
# Provavelmente será necessário instalar e abrir o pacote 'som' antes de rodar a linha de comando a seguir. 
# Faça isso usando os comando play() para sair da lição e nxt() para retornar. Depois, 
# digite: dados_TL$zscoreTL2 <- normalize(dados_TL$Tempo_leitura2, byrow= TRUE)" 
dados_TL$zscoreTL2 <- normalize(dados_TL$Tempo_leitura2, byrow= TRUE)


- Class: cmd_question
# Output: "Agora que nosso dataframe tem os dados transformados por z-score, vamos aplicar o teste de normalidade 
# Kolmogorov-Smirnov. Digite: lillie.test(dados_TL$zscoreTL2)"
lillie.test(dados_TL$zscoreTL2)

- Class: cmd_question
# Output: "A saída do teste foi de p= 2.397e-09. O mesmo valor de p encontrado no teste realizado com os dados brutos. 
# Isso quer dizer que, com o método z-score, não foi possível transformar a distribuição dos dados para normal. 
# Vamos tentar o teste de Shapiro-Wilk? Digite: shapiro.test(dados_TL$zscoreTL2)" 
shapiro.test(dados_TL$zscoreTL2)


- Class: text
# Output: "Com o teste de Shapiro-Wilk encontramos um p=4.791e-14, mesmo resultado do teste com os dados brutos novamente. 
# Com o método de z-score, rejeitamos a H0 e assumimos a H1 que afirma que os dados da amostra não seguem a distribuição normal." 

- Class: text
# Output: "Uma vez que encontramos um método de transformação dos dados que se mostrou eficiente nos testes de normalidade, 
# o método de transformação logarítmica, nosso próximo passo em uma pesquisa real seria escolher e executar o teste estatístico 
# inferencial paramétrico mais adequado para a nossa amostra. O teste escolhido deve ser realizado com os dados transformados 
# por log, pois são esses dados que seguem a premissa da distribuição normal. Com essa lição, fechamos a parte da inspeção e 
# preparação dos dados para a aplicação dos testes de hipóteses. Nas próximas lições, vamos aprender como aplicar e como interpretar 
# os resultados de testes estatísticos inferênciais. Até breve!" 
