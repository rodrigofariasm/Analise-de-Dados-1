## Problema 1 
library(ggplot2, quietly = TRUE)
library(dplyr, quietly = TRUE)

ano.atual <- read.csv("problema1/dados/ano-atual.csv")

##Selecionando os gastos da Paraíba
panorama  = ano.atual%>%select(1,5, 6, 15, 23)  %>% filter(sgUF =="PB")
names(panorama) = c("partido", "nome", "estado", "descricao", "valor")

panorama.sumarizado = panorama%>% group_by(nome)
panorama.sumarizado.sum = panorama.sumarizado %>%
  summarize(media= mean(valor))
ggplot(panorama.sumarizado, mapping= aes(x = nome,
                                         y = valor))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  geom_boxplot()+
  geom_point(position = position_jitter(width = .2), 
             alpha = .7) + 
  geom_point(panorama.sumarizado.sum,
             colour = "red", size = 1, 
             mapping = aes(y = media, x = nome))

##selecionando os gastos
gastos = ano.atual%>%select(15, 23)
names(gastos) = c("descricao", "valor-liquido")
## sumarizando os gastos por grupos e guardando sua soma.
gastos.sumarizados = gastos%>% group_by(descricao)
gastos.sumarizados.sum = gastos.sumarizados  %>% 
  summarise(valorLiquido=sum(`valor-liquido`))

ggplot(gastos.sumarizados.sum, aes(descricao, valorLiquido)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  geom_bar(stat="identity", position = "dodge") + coord_flip() 

## Procurar despesas que mais variam, usando desvio padrão

gastos.sumarizados.sd = aggregate(gastos.sumarizados$`valor-liquido`,
                                  list(gastos$descricao), sd)
names(gastos.sumarizados.sd) = c("Descricao", "desvio.padrao")

ggplot(gastos.sumarizados.sd, aes(Descricao, desvio.padrao))+
  geom_bar(stat="identity", position = "dodge") + coord_flip() 

