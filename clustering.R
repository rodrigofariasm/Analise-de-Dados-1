library(plotly)
library(dplyr)
library(ggplot2)
library(gapminder)
emendas <- read.csv("emendas_area_parlamentar.csv")
emendas.c = subset(emendas, Assistencia.Social > 0 | Seguranca.Publica > 0)
emendas_kmeans <- emendas.c %>%
  select(Seguranca.Publica, Assistencia.Social) %>% 
  kmeans(centers = 3, nstart = 100, iter.max = 50)

ggplot(emendas.c, aes(x = Seguranca.Publica, y = Assistencia.Social), text= NOME_PARLAMENTAR) +
  geom_point(aes(color = factor(emendas_kmeans$cluster)))

ggplotly(filename="ggplot2-docs/clustering")
