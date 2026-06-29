- Class: meta
Course: EBAL
Lesson: Licao_5
Author: Aline Alves Fonseca
Type: Standard
Organization: Universidade Federal de Juiz de Fora
Version: 2.4.5

- Class: text
# Output: "Nas lições anteriores, aprendemos a inspecionar, manipular e a aplicar um tipo de teste inferencial com variáveis numéricas. 
# Nesta lição, vamos aprender a inspecionar os dados e aplicar o teste estatístico inferencial de Qui-quadrado, que é um teste para 
# variáveis nominais ou categóricas."

- Class: text
# Output: "O Teste de Qui-quadrado avalia as proporções ou frequências de ocorrência de uma variável nominal e compara os valores observados 
# com valores esperados para aquela amostra. O teste de Qui-quadrado é não-paramétrico, ou seja, não depende de parâmetros populacionais (média e variância)."

- Class: text
# Output: "Nesta lição vamos executar um teste de Qui-quadrado para avaliar os dados de um experimento de escolha de interpretação de sentenças ambíguas 
# com adjuntos adverbiais do tipo 'A tia da Sabrina soube que o Mário ligou durante  o almoço de domingo'. Há duas interpretações possíveis para essa frase: 
# 1) A tia da Sabrina soube de algo durante o almoço de domingo - chamamos essa interpretação de aposição alta ou não local do adjunto adverbial; ou 
# 2) O Mário ligou durante o almoço de domingo (interpretação default) - chamamos essa interpretação de aposição baixa ou local do adjunto adverbial. 
# Em um teste simples de leitura, sem manipulação de variáveis linguísticas, encontramos que cerca de 90% das escolhas de interpretação dos participantes 
# para sentenças como essa foram de aposição baixa. No experimento que vamos analisar aqui nos interessa verificar se elementos de focalização como acento 
# tonal e alongamento silábico (foco prosódico) e partículas de foco (como o advérbio 'só') podem influenciar e alterar a escolha da interpretação default 
# (aposição baixa), favorecendo a escolha da interpretação não default, a aposição alta do adjunto."  

- Class: cmd_question
# Output: 'Vamos carregar nossa planilha do tipo csv para o R em formato de dataframe, com o comando read.csv. Digite: dados_so <- read.csv("dados_adv_SO.csv", 
# header = T, sep = ",")'
dados_so <- read.csv("dados_adv_SO.csv", header = T, sep = ",")


- Class: cmd_question
# Output: "Vamos inspecionar nosso dataframe com o comando str(). Digite: str(dados_so)"
str(dados_so)

- Class: cmd_question
# Output: 'O nosso dataframe "dados_so" possui 720 observações de 8 variáveis. Podemos verificar nessa inspeção incial com o comando str() que temos 6 variáveis 
# do tipo "chr" e duas variáveis "int". Para que possamos prosseguir com a inspeção dos dados, precisamos transformar as variáveis do tipo "chr" em variáveis do 
# tipo "factor". Vamos fazer isso com o comando mutate_if. Obs. Lembre-se que para que esse comando funcione o pacote "dplyr" precisa estar aberto com o comando 
# library(dplyr). Digite : dados_so <- dados_so %>% mutate_if(sapply(dados_so, is.character), as.factor)'
dados_so <- dados_so %>% mutate_if(sapply(dados_so, is.character), as.factor)

- Class: cmd_question
# Output: "Agora podemos continuar a inspecionar os dados com os comandos str() e summary(). Vamos executar o comando str() de novo. Digite: str(dados_so)"
str(dados_so)


- Class: text
# Output: "A variável 'Subject' refere-se aos participantes da pesquisa. Podemos constatar que 36 pessoas participaram do experimento. A variável 'Group' 
# refere-se a divisão dos participantes em grupos, ou seja, tivemos 4 grupos de participantes. A variável 'Escolha_attach' é a variável dependente que 
# vamos analisar nesta lição. Ela é uma variável nominal de dois níveis: 'High' e 'Low'. O nível 'High' corresponde às escolhas de interpretação de aposição 
# alta do adjunto adverbial e o nível 'Low' corresponde às escolhas de aposição baixa do adjunto. A variável TR_Final (Tempo de Reação final) também é uma 
# variável dependente e nos dá o tempo gasto pelos participantes para escolher a opção de interpretação no teste. TR_Final é uma variável numérica e contínua. 
# As variáveis 'Cond', 'Adv_so' e 'Verbo' são as variáveis independentes que foram manipuladas pelas pesquisadoras. A variável 'Cond' tem 4 níveis: SOV1, SOV2, 
# V1 e V2. Vamos detalhar essa variável e das demais na próxima questão." 

- Class: text
# Output: "A codificação SOV1, SOV2, V1 e V2  da variável 'Cond' refere-se aos 4 tipos de estímulos auditivos que aplicamos no teste. O nível SOV1 refere-se 
# a sentenças em que o advérbio 'só' estava presente junto ao verbo 1 que também estava focalizado, como em: 'A tia da Sabrina só SOUBE que o Mário ligou 
# durante o almoço de domingo'; o nível SOV2 refere-se a sentenças com o advérbio 'só' acompanhando o verbo 1 e com o verbo 2 focalizado prosodicamente, 
# como em: 'A tia da Sabrina só soube que o Mário LIGOU durante o almoço de domingo'; já o nível V1 apresentava apenas a focalização prosódica no verbo 1, 
# como em: 'A tia da Sabrina SOUBE que o Mário ligou durante o almoço de domingo'; e as sentenças do nível V2 tinham apenas o verbo 2 focalizado prosodicamente, 
# sem a presença do advérbio 'só', como em: 'A tia da Sabrina soube que o Mário LIGOU durante o almoço de domingo'. As variáveis 'Adv_so' e 'Verbo' 
# foram estabelecidas para 'isolar' as manipulações linguísticas presença x ausência do advérbio focalizador 'só', e presença x ausência do foco 
# prosódico no verbo 1 e no verbo 2."  

- Class: video
# Output: "Vamos assistir uma apresentação de 5 minutos no youtube sobre essa pesquisa? Responda 'Yes' na pergunta abaixo." 
# Link: https://youtu.be/GGtgp5spbhs

- Class: cmd_question
# Output: "Por último, a variável 'Item' foi lida como uma variável de números inteiros pelo R, mas na verdade ela é uma variável 
# categórica também. Os números nesta variável representam uma codificação para as condições experimentais dos itens. Vamos então 
# transformar essa variável numérica em uma variável categórica para que a leitura de todo o dataframe 'dados_so' fique correta. 
# Para isso vamos usar o comando 'as.factor()'. Digite: dados_so$Item <- as.factor(dados_so$Item)"  
dados_so$Item <- as.factor(dados_so$Item)

- Class: cmd_question
# Output: "Agora vamos executar o segundo comando de inspeção dos dados, o comando summary(). Digite: summary(dados_so)"
summary(dados_so)

- Class: text
# Output: "Com o comando summary, podemos observar que cada participante respondeu a 20 itens experimentais, que cada nível da 
# variável 'Cond' obteve 180 respostas e que cada nível das variáveis 'Adv-so' e 'Verbo' obtiveram 360 respostas. Para as nossas 
# variáveis dependentes, podemos observar que a variável 'Escolha_attach' obteve 330 respostas no nível 'High' e 390 respostas no 
# nível 'Low'. Já a variável TR_Final tem média de 7278ms, mediana de 5789ms, valores de mínimo e máximo da amostra de 1450ms e 65197ms. 
# O valor de máximo nos indica que temos outliers nessa amostra. Não vamos analisar os tempos de reação nessa lição, apenas as respostas 
# de interpretação, mas os outliers de TR correspondem a respostas de interpretação não confiáveis, por isso precisamos excluí-los antes
# de fazer a análise inferencial dos dados da variável 'Escolha_attach'." 

- Class: cmd_question
# Output: 'Já sabemos o passo-a-passo de inspeção e exclusão de outliers, certo? Vamos criar um boxplot, calcular o valor do limite superior 
# do boxplot com o range = 3 e, em seguida, filtrar os dados com o valor do limite superior encontrado. Começando pelo boxplot, 
# digite: boxplot(TR_Final ~ Escolha_attach, range = 3, data = dados_so, ylim= c(1400, 50000), xlab= "TR por Escolha de Aposição", ylab= "TR",  main= "boxplot TR por escolha de Aposição \n dados brutos", col= "purple")' 
boxplot(TR_Final ~ Escolha_attach, range = 3, data = dados_so, ylim= c(1400, 50000), xlab= "TR por Escolha de Aposição", ylab= "TR",  main= "boxplot TR por escolha de Aposição \n dados brutos", col= "purple")

- Class: cmd_question
# Output: 'Podemos observar pelo gráfico boxplot que há muitos outliers acima de 20000ms. Vamos calcular o valor do limite superior para termos 
# uma noção mais precisa do ponto de corte. Lembre-se de que a fórmula para o cálculo é Q3 + (Q3-Q1)*3.'  
8006 + (8006-4218)*3


- Class: cmd_question
# Output: "O valor do limite superior da amostra foi de 19370ms. Vamos arredondar esse valor e aplicar o filtro em 20000ms como havíamos presumido 
# pela inspeção visual do gráfico. Digite: dados_so = dados_so %>% filter(TR_Final < 20000)"
dados_so = dados_so %>% filter(TR_Final < 20000)

- Class: cmd_question
# Output: "A filtragem dos dados cortou 24 observações com valores outliers. Apesar de ser um número relativamente grande de observações, a relação 
# com o tamanho total da amostra ainda é inferior a 5%, ou seja, temos mais de 95% dos dados da amostra preservados. Podemos então prosseguir para 
# uma segunda inspeção dos dados sem outliers. Digite: summary(dados_so)"
summary(dados_so)

- Class: text
# Output: "Podemos observar na segunda inspeção dos dados sem outliers que o número de observações dos níveis da variável 'Cond' ficaram relativamente
# próximos (171, 176, 175 e 174). Isso significa que os tempos de reação com valores outliers não foram motivados pela maior dificuldade ou facilidade 
# de um dos níveis da variável. Podemos avaliar que os itens experimentais foram satisfatoriamente balanceados quanto ao nível de dificuldade. 
# Com relação ao número de observações na variável dependente 'Escolha_attach', obtivemos 319 repostas no nível 'High' e 377 respostas no nível 'Low', 
# ou seja, um corte de 11 observações no nível 'High' e 13 observações no nível 'Low'. Podemos presumir com esse resultado que os valores de outliers 
# também não foram motivados pelo tipo de resposta escolhida, ou seja, os participantes não demoraram mais (a ponto de gerar um outlier) para escolher 
# a opção de aposição alta ou baixa. Essa inspeção nos dá segurança de que os dados que temos após a filtragem constituem uma amostra válida para a 
# tarefa experimental que planejamos e aplicamos." 

- Class: cmd_question
# Output: "A primeira parte da análise de dados, sejam nominais ou numéricos, é a análise descritiva. Vamos começar checando quais foram as frequências 
# de ocorrência de respostas 'High' e 'Low' por condição experimental. Para isso vamos criar uma tabela com o comando table(). Dentro dos parênteses do 
# comando table() determinamos primeiro qual é a variável que vai ocupar a posição das linhas e depois qual é a variável que vai ocupar a posição das 
# colunas {L, C}. Para definir essas variáveis, usamos a sintaxe 'nomedodataframe$nomedavariavel'. Vamos guardar nossa tabela em um objeto chamado 
#'tab_cond'. Digite: tab_cond <- table(dados_so$Cond, dados_so$Escolha_attach)"  
tab_cond <- table(dados_so$Cond, dados_so$Escolha_attach)


- Class: cmd_question
# Output: "Para inspecionar a tabela que acabamos de criar, basta digitar o nome dela no prompt. Digite: tab_cond"
tab_cond

- Class: cmd_question
# Output: "Observamos que os níveis SOV1 e SOV2 tiveram escolhas de aposição alta 123 e 116 vezes, respectivamente. Jás os níveis V1 e V2 tiveram apenas 
# 43 e 37 observações de escolha de aposição alta em cada. Podemos adicionar margens a nossa tabela com os somatórios das variáveis especificadas nas 
# linhas e nas colunas da tabela. Vamos testar? Digite: addmargins(tab_cond)" 
addmargins(tab_cond)

- Class: text
# Output: "Os valores dos somatórios das linhas são os mesmos que vimos no comando summary para cada nível da variável 'Cond', e os somatórios das colunas 
# são os mesmos valores que vimos para os níveis da variável 'Escolha_attach'. Por fim, o somatório das linhas ou o somatório das colunas da tabela nos dá 
# o valor total das observações da amostra após a exclusão dos outliers (696)." 

- Class: mult_question
# Output: "Vamos agora checar as proporções ou porcentagens de escolha de aposição por condição? A proporção é uma medida importante para variáveis nominais 
# e faz parte da análise descritiva dos dados. Para calcular a proporção, usamos o comando 'prop.table'. O argumento desse comando será a tabela de observações 
# que criamos anteriormente. Devemos ainda definir se queremos as proporções calculadas por linha ou por coluna. Avaliando a nossa tabela tab_cond, qual é a 
# melhor maneira de calcular as proporções de resposta?"
AnswerChoices: por linha; 
               por coluna; 
               prefiro não comentar
CorrectAnswer: por linha


- Class: cmd_question
# Output: "Acertou quem escolheu a resposta 'por linha' porque teremos a proporção de escolhas 'High' ou 'Low' para cada nível da condição experimental. 
# Vamos ao comando das proporções! Para selecionar a proporção por linha, acrescentamos o número '1' como argumento do comando 'prop.table()', após o nome 
# da tabela que iremos usar como objeto para calcular as proporções. E, por fim, para que as proporções fiquem no formato de porcentagem, devemos multiplicar 
# o comando prop.table() por 100. Vamos guardar o resultado em uma nova tabela chamada 'tab_cond_prop'. A linha de comando final fica assim: 
# tab_cond_prop <-prop.table(tab_cond, 1)*100" 
tab_cond_prop <-prop.table(tab_cond, 1)*100


- Class: text
# Output: "Obs. Se quiséssemos calcular a proporção da nossa tabela por colunas, bastava substituir o número '1' na linha de comando anterior pelo número 2. 
# Lembre-se sempre de que, quando trabalhamos com tabelas no R, a ordem será {L, C} ou seja {1, 2}."

- Class: cmd_question
# Output: "Vamos inspecionar nossa tabela de proporções? Digite: tab_cond_prop"
tab_cond_prop

- Class: text
# Output: "Com a inspeção da tabela de proporções, verificamos que nas condições em que o advérbio 'só' está presente junto ao verbo 1, há uma maior escolha 
# pela interpretação de aposição alta (SOV1 = 71.9% e SOV2 = 65.9%). Nos níveis V1 e V2, a maior proporção de escolha foi para a interpretação de aposição 
# baixa do adjunto adverbial (V1 = 75.4% e V2 = 78.7%). Este resultado nos dá indícios de como os elementos focalizadores de foco prosódico e de foco morfológico 
# influenciam a escolha de interpretação dos participantes." 

- Class: text
# Output: "Agora que já fizemos a análise inicial e descritiva dos dados, vamos partir para a análise inferencial. Como já sabemos, análises inferenciais são testes 
# estatísticos que vão inferir se um resultado observado em uma amostra pode ser tomado como válido para a população da qual a amostra em questão faz parte. 
# Os testes inferenciais também são chamados de testes de hipóteses, porque estamos testando se a hipótese nula (H0) pode ser rejeitada em favor da hipótese alternativa (H1). 
# Visto isso, é de suma importância que as hipóteses nula e alternativa sejam definidas antes de se executar um teste estatístico inferencial nos dados." 

- Class: mult_question
# Output: "Vamos começar definindo a hipótese nula do nosso teste de Qui-quadrado? Qual das opções abaixo tem a melhor formulação para a H0 do estudo dos adjuntos adverbiais ambíguos?"
AnswerChoices: A frequência de escolhas High observadas será igual à frequência de escolhas High esperadas para todos os níveis da variável Cond.; 
               A frequência de escolhas High observadas vai ser diferente da frequência de escolhas High esperadas para todos os níveis da variável Cond. ; 
               A frequência de escolhas High observadas vai ser maior do que a frequência de escolhas High esperadas nos níveis da variável Cond em que V1 está focalizado.
CorrectAnswer: A frequência de escolhas High observadas será igual à frequência de escolhas High esperadas para todos os níveis da variável Cond.


- Class: mult_question
# Output: "Já definimos nossa H0, agora precisamos definir nossa H1. Qual das opções abaixo tem a melhor formulação da H1 para o experimento dos adjuntos adverbiais ambíguos?"
AnswerChoices: A frequência de escolhas High observadas vai ser diferente da frequência de escolhas High esperadas nos níveis da variável Cond em que V1 está focalizado.; 
               A frequência de escolhas High observadas vai ser diferente da frequência de escolhas High esperadas para todos os níveis da variável Cond.; 
               A frequência de escolhas Low observadas vai ser igual à frequência de escolhas Low esperadas para todos os níveis da variável Cond.
CorrectAnswer: A frequência de escolhas High observadas vai ser diferente da frequência de escolhas High esperadas nos níveis da variável Cond em que V1 está focalizado.

- Class: text
# Output: "Diferentemente do teste T, o teste Qui-quadrado não permite hipóteses direcionais (de X maior que Y ... ou de X menor que Y...). No entanto, pela observação das proporções 
# e pelo resultado do teste que vai rejeitar ou acatar a H0, podemos deduzir se as diferenças entre as frequências observadas são maiores ou menores do que as frequências esperadas."

- Class: cmd_question
# Output: "Agora que fizemos a análise descritiva dos dados, que retiramos as respostas não confiáveis com a exclusão dos outliers e que definimos nossas hipóteses nula e alternativa, 
# podemos executar o teste inferencial Qui-quadrado. A execução do teste é muito simples. Usa-se o comando chisq.test() e o argumento desse comando é a tabela de obervações dos dados. 
# Digite: chisq.test(tab_cond)"
CorrectAnswer: chisq.test(tab_cond)


- Class: text
# Output: "A saída do teste nos fornece o nome do teste realizado 'Pearson's Chi-squared test', a origem dos dados analisados 'data: tab_cond', o valor da estatística X-squared = 149.65, 
# o valor dos graus de liberdade da amostra df = 3 e, por último o valor de p < 2.2e-16. Assim como o teste T, os valores da estatística X-squared formam uma tabela organizada por df nas 
# linhas e nível de significância (alpha) nas colunas. Os graus de liberdade no teste de Qui-quadrado é calculado pelo número de condições ou de grupos testados (número de linhas na tabela 
# de observações) - 1. No nosso caso, temos  df = (4 condições - 1), logo df = 3. Estipulamos o nível de siginificância do nosso teste em alpha < 0.05. Vamos então checar o valor da estatística 
# de X-squared que precisávamos encontrar para rejeitar a nossa hipótese nula com nível de significância < 0.05?"

- Class: figure
# Output: "Observe a tabela da distribuição de X2 que abrimos na aba Plots. Cruzando a linha de df = 3 e a coluna de nível de significância 0.05, encontramos que o valor de X-squared calculado 
# deveria ser igual ou maior que 7.815 para que pudéssemos rejeitar H0. O valor de X-squared calculado em nosso teste foi de 149.65, ou seja, muito maior que 7.815. Observe que o último nível 
# de significância na tabela é 0.001 e o valor de X-squared para esse nível com df = 3 é 16.266. O nosso valor de X-squared ainda é muito maior do que isso, por isso o valor de p do nosso teste 
# é tão baixo, muito menor que 0.001."


- Class: figure
# Output: "Mas o que significa esse valor de X-squared calculado? Como vimos no início da lição, o teste de Qui-quadrado avalia se as frequências de ocorrência observadas de um determinado fenômeno
# são diferentes das frequências de ocorrência esperadas para aquela amostra. Por isso, a fórmula da estatística de X-squared se baseia na diferença entre as frequências observadas e as frequências 
# esperadas. Observe a fórmula que abrimos na aba Plots. O valor de X-squared vai ser igual ao somatório das (frequências observadas - frequências esperadas) ^2 e dividido pelas frequências esperadas."


- Class: cmd_question
# Output: "Ok, mas o que são esses valores esperados? A saída do teste Qui-quadrado é bem simples, mas há muito mais em sua estrutura. Vamos executar novamente o teste, só que agora vamos guardar em um 
# objeto chamado 'X2_tab_cond' para que possamos inspecionar a sua estrutura em um próximo passo. Digite: X2_tab_cond <- chisq.test(tab_cond)" 
CorrectAnswer: X2_tab_cond <- chisq.test(tab_cond)

- Class: cmd_question
# Output: "Agora vamos inspecionar o objeto 'X2_tab_cond' com o comando str(). Digite: str(X2_tab_cond)"
str(X2_tab_cond)

- Class: cmd_question
# Output: "A estrutura do teste Qui-quadrado é uma lista de 9 variáveis. Nos interessa em especial as variáveis '$ observed' e '$ expected'. A variável '$ observed' corresponde à tabela que inserimos no 
# teste, nossa 'tab_cond'. E a variável '$ expected'? Podemos observar que ela também é uma tabela de 4 linhas e 2 colunas, assim como a tabela de observações 'tab_cond', mas o que significa esses valores 
# esperados? Vamos inspecionar a tabela de valores esperados? Digite: X2_tab_cond$expected"
X2_tab_cond$expected


- Class: figure
# Output: "Abrimos na aba Plots a fórmula para calcular os valores esperados de uma amostra. Os elementos do cálculo, total da linha, total da coluna e total geral são baseados nos totais de observações por 
# condição (VI) e por resposta (VD). Nós fizemos esses cálculos de somatório de linhas e colunas quando adicionamos margens à nossa tabela de observações com o comando 'addmargins', vocês se lembram? Se não, 
# voltem algumas questões e inspecionem novamente a tabela de observações com os valores totais de linhas e colunas." 

- Class: figure
# Output: "Para facilitar nossa vida, abrimos aqui no Plots uma tabela com os valores observados da nossa amostra e os valores esperados calculados. Observe que os valores esperados calculados coincidem 
# exatamente com os valores da variável '$ expected' da estrutura do teste Qui-quadrado." 

- Class: text
# Output: "Uma vez que os somatórios dos valores observados nas condições do nosso teste foram relativamente homogêneos, os valores esperados por condição (VI) para o nível High de escolha de aposição 
# (VD) também são relativamente homogêneos entre si. O mesmo acontece para o nível Low da VD. No entanto, nos valores observados, vemos que a distribuição das observações não é homogênea. Temos uma maior 
# frequência de ocorrência de respostas High nas condições SOV1 e SOV2 do que nas condições V1 e V2. O teste de Qui-quadrado nos confirma que há uma diferença de respostas High entre as condições. 
# Por isso rejeitamos a H0."  

- Class: cmd_question
# Output: "A título de ilustração, vamos calcular 'manualmente' o valor de X-squared para os nossos dados? Para isso, vamos criar dois vetores, um com os valores observados da nossa amostra, e outro com 
# os valores esperados. Vamos começar com o vetor dos valores observados. Digite: Obs_cond <- c(123, 48, 116, 60, 43, 132, 37, 137)"
Obs_cond <- c(123, 48, 116, 60, 43, 132, 37, 137)

- Class: cmd_question
# Output: "Vamos criar o nosso segundo vetor com  os valores esperados. Digite: Esp_cond <- c(78.375, 92.625, 80.66667, 95.33333, 80.208333, 94.79167, 79.75, 94.25)"
Esp_cond <- c(78.375, 92.625, 80.66667, 95.33333, 80.208333, 94.79167, 79.75, 94.25)

- Class: cmd_question
# Output: "Agora basta substituirmos os valores Observados (O) e Esperados (E) na fórmula do X2 (X2 = sum(((O - E)^2) / E ) pelos nossos vetores Obs_cond e Esp_cond. 
# Digite: X2 <-sum(((Obs_cond - Esp_cond)^2)/(Esp_cond))"
X2 <-sum(((Obs_cond - Esp_cond)^2)/(Esp_cond))


- Class: text
# Output: "Voilá! O resultado do nosso cálculo manual de X-squared foi 149.65... (confira no Environment), o mesmo valor que foi dado na saída do teste Qui-quadrado."  

- Class: text
# Output: "Para reportar o resultado do nosso teste Qui-quadrado, precisamos indicar os valores de X-squared, de df e de p. Mas também seria interessante apresentar um gráfico com os valores das proporções 
# de escolha por condição, não é verdade? Vamos aprender a fazer um gráfico de proporções bem legal para usar em nossos textos acadêmicos?" 

- Class: cmd_question
# Output: 'O gráfico que vamos desenhar é do tipo histograma, mas é um pouco diferente do histograma que aprendemos a fazer para observar a distribuição de dados numéricos. Nesse gráfico, temos a porcentagem 
# de ocorrência no eixo Y e os níveis da VD no eixo X. Para fazer esse gráfico vamos precisar instalar e abrir um novo pacote de comandos chamado "lattice". Para isso vamos sair da lição com o comando play(), 
# em seguida vamos instalar o pacote e abrí-lo com os comandos intall.packages("lattice") e library(lattice), aí voltamos para a lição com o comando nxt(). Feito isso, vamos rodar a seguinte linha de comando: 
# histogram(~ Escolha_attach | Cond, data= dados_so, layout=c(2,2), col = c( "lightgreen", "lightblue"), ylab = "Porcentagem de escolha", xlab = "Escolha de Aposição", main = "Porcentagem de escolha de aposição por condição")' 
histogram(~ Escolha_attach | Cond, data= dados_so, layout=c(2,2), col = c( "lightgreen", "lightblue"), ylab = "Porcentagem de escolha", xlab = "Escolha de Aposição", main = "Porcentagem de escolha de aposição por condição") 


- Class: text
# Output: "A linha de comando anterior é extensa, mas tem poucas novidades. A maioria dos argumentos nós já conhecemos e aplicamos em outros gráficos. Os argumentos novos são, a fórmula com a qual representamos 
# a VD e a VI (~ VD | VI), e a função 'layout' que vai nos dizer como será a disposição dos quadros do gráfico na tela. Para este gráfico, escolhemos o layout=c(2, 2) que significa 2 linhas por 2 colunas. 
# Os demais argumentos, data=, col=, ylab=, xlab=, e main= já são nossos conhecidos. Vamos escolher um novo layout para testar o funcionamento dessa função?"

- Class: cmd_question
# Output: 'Digite: histogram(~ Escolha_attach | Cond, data= dados_so, layout=c(1,4), col = c( "lightyellow", "lightpink"), ylab = "Porcentagem de escolha", xlab = "Escolha de Aposição", main = "Porcentagem 
# de escolha de aposição por condição")'
histogram(~ Escolha_attach | Cond, data= dados_so, layout=c(1,4), col = c( "lightyellow", "lightpink"), ylab = "Porcentagem de escolha", xlab = "Escolha de Aposição", main = "Porcentagem de escolha de aposição por condição")

- Class: text
# Output: "As informações que temos nesse segundo gráfico são as mesmas do primeiro, apenas o layout é diferente. No novo gráfico temos a distribuição dos quadros do gráfico em uma só coluna e em quatro linhas. 
# Mudamos também as cores das barras de porcentagem para demonstrar que podemos usar nossa criatividade na montagem dos gráficos no R de forma a encontrar a melhor exposição dos dados da nossa pesquisa." 

- Class: text
# Output: "Terminamos aqui a nossa lição 5. Esperamos que todas as informações trabalhadas nessa lição ajudem-no não só a aplicar o teste de Qui-quadrado, a ler os resultados e a reportá-los, mas também a entender 
# a lógica por trás deste teste estatístico inferencial. Até breve!"

