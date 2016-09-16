#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# Pergunta 1: Usando inferência sobre os dados apresentados, podemos dizer qual é o filme mais popular de 2014?
# Pergunta 2: 

library(shiny)
library(ggplot2)
library(dplyr)

#load Data
movie.ratings <- read.csv("dados/ratings-por-filme.csv")
movie.genre <- read.csv("movie-genre.csv")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    est <- input$estado
    despesa <- input$despesa
    meses = filter(ano.atual ,numMes < 6)
    if(est == "Todos"){
      mesesfiltrados = meses
    }else{
      mesesfiltrados = filter(meses, meses$sgUF == est)  
    }
    if(despesa == "Todas"){
      ggplot(mesesfiltrados, aes(x = numMes, y = vlrDocumento, colour = txtDescricao))+
        labs(x = "Mes de 2016", y = "Gastos") + ylim(0, 50000)+
        geom_point(position = position_jitter(width = 0.35), alpha = 0.1, na.rm = TRUE)+
        facet_wrap(~ txtDescricao, ncol = 4) + 
        theme(legend.position="none", strip.text.x = element_text(hjust = 0, size = 8))
    }else{
      mesesfiltrados = filter(meses, mesesfiltrados$txtDescricao == despesa)  
      ggplot(mesesfiltrados, aes(x = numMes, y = vlrDocumento))+
      labs(x = "Mes de 2016", y = "Gastos", title=despesa) + ylim(0, max(mesesfiltrados$vlrDocumento, na.rm = FALSE))+
      geom_point(position = position_jitter(width = 0.40), alpha = 0.6, na.rm = TRUE)
     
    }
    
    
  })
  
})
