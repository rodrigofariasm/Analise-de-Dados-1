## Problema 1 
library(ggplot2)
library(dplyr)


ano.atual <- read.csv("problema1/dados/ano-atual.csv")
cota.estado <- read.csv("problema1/dados/valor-cota-por-estado.csv")
names(cota.estado) <- c("sgUF", "sum")

##Pergunta 1
##filtrando para ter os 5 primeiros meses
trimestre1 = ano.atual %>% filter(numMes < 6)

## Agrupando por mes e por tipo de despesa, e somando todos os gastos.
tri.sum = trimestre1 %>% group_by(numMes, txtDescricao) %>% summarize(sum = sum(vlrDocumento))


##Mapeando os números para o tipo de Mês.
tri.sum$numMes <- as.factor(tri.sum$numMes)
levels(tri.sum$numMes) <- c("Janeiro", "Fevereiro", "Marco", "Abril", "Maio")

ggplot(tri.sum,aes(x=factor(txtDescricao),y=sum/1000000, fill = factor(numMes))) +
  labs(x = "Tipo de gasto", fill = "Mes/2016", y ="Gastos em milhoes") +
  geom_bar(position = "dodge", stat = "identity") +
  coord_flip()

## despesa de março para abril de emissao de bilhetes aéreos
gastosabrilemaio = ano.atual %>% filter((numMes == 4 | numMes == 3)
                                        & txtDescricao == "Emissão Bilhete Aéreo")
medias = gastosabrilemaio %>% 
  group_by(numMes) %>% 
  summarise(vlrDocumento = mean(vlrDocumento))

ggplot(gastosabrilemaio, mapping = aes(x = as.factor(numMes), y = vlrDocumento) ) +
  labs( y ="Preco do Bilhete Aereo", x= "Mes", title = "Gastos com passagens aéreas maio e abril") +
  geom_boxplot()+
  geom_point(position = position_jitter(width = 0.3), alpha = 0.03) +
  geom_point(data = medias, colour = "red", size = 1.5) 


trimestre1 %>% count(numMes)
  
## pergunta 2  Qual estado economiza mais em relação as cotas? 
deputados = ano.atual %>% filter(numMes<6) %>%
  group_by(sgUF, txNomeParlamentar) %>% summarize(sum = sum(vlrDocumento)/5)
ggplot(deputados, mapping = aes(x = sgUF, y = sum))+
  geom_point(position = position_jitter(width = 0.2), alpha = 0.5, na.rm = TRUE)+
  geom_point(data = cota.estado, colour = "red", size = 1.5)

estados = deputados %>% group_by(sgUF) %>% summarise(sum = mean(sum))
estados = estados %>% filter(sgUF != "")
ggplot(estados, mapping = aes(x = sgUF, y = sum))+
  geom_point(position = position_jitter(width = 0.2), alpha = 0.5, na.rm = TRUE)+
  geom_point(data = cota.estado, colour = "red", size = 1.5)

estados$pc = estados$sum/cota.estado$sum*100 
ggplot(estados, mapping = aes(x = sgUF, y = pc))+
  geom_bar(position = "dodge", stat = "identity")

