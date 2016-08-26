require(ggplot2, quietly = TRUE)
library(ggfortify, quietly = TRUE)
# http://rpubs.com/sinhrks/basics
require(GGally, quietly = TRUE)
require(reshape2, quietly = TRUE)
require(dplyr, quietly = TRUE)
library(knitr, quietly = TRUE)
library(cluster)
library(ggdendro)
theme_set(theme_bw())
emendas <- read.csv("emendas_area_parlamentar.csv")
emendas <-subset(emendas, !is.na(NOME_PARLAMENTAR))
emendas2 <- log(emendas[,2:18]+1)
emendas2$NOME_PARLAMENTAR <- emendas$NOME_PARLAMENTAR
emendas3 <- emendas2[c(13, 14, 2)]
row.names(emendas3) = emendas2$NOME_PARLAMENTAR
pr.out = prcomp(emendas3, scale = TRUE)
kable(pr.out$rotation)

autoplot(pr.out, label = TRUE, label.size = 2, shape = TRUE, 
         loadings = TRUE, loadings.colour = 'blue',
         loadings.label = TRUE, loadings.label.size = 3)

# Porcentagem da variância explicada: 
plot_pve <- function(prout){
  pr.var <- pr.out$sdev^2
  pve <- pr.var / sum(pr.var)
  df = data.frame(x = 1:NROW(pve), y = cumsum(pve))
  ggplot(df, aes(x = x, y = y)) + 
    geom_point(size = 3) + 
    geom_line() + 
    labs(x='Principal Component', y = 'Cumulative Proportion of Variance Explained')
}

plot_pve(pr.out)