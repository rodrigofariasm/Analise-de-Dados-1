## Problema 1 
library(ggplot2, quietly = TRUE)
library(dplyr)

ano.atual <- read.csv("problema1/dados/ano-atual.csv")

##Pergunta 1

##Levando em conta o primeiro trimestre há alguma despesa que teve um aumento ou redução de gastos considerável durante esse período?

trimestre1 = ano.atual %>% filter(numMes < 4)
tri.sum = trimestre1 %>% group_by(numMes, txtDescricao) %>% summarize(sum = sum(vlrDocumento))



## pergunta 2