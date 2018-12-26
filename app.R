

library(shiny)
library(shinythemes)
library(htmltools)
library(dplyr)
library(tidyr)
library(hashids)
library(lubridate)

source('src/lightbox.R')
source('src/photoswipe.R')

images <- data.frame(src = list.files('www/img')) %>%
  tidyr::separate(col = 'src', c('txt', 'date', 'time', 'msec'), sep = '_|\\.', remove = FALSE) %>%
  rowwise() %>%
  mutate(date = lubridate::ymd(date),
         key = hashids::encode(1e3 + as.integer(msec), hashid_settings(salt = 'this is my salt')))


ui <- fluidPage(theme = shinytheme("superhero"),
   
    titlePanel(withTags(
      div("Shiny Image Galleries",
          div(class = 'pull-right',
              a(href = 'https://github.com/mrjoh3/shiny-gallery-example',
                icon('github'))), hr() )
    ), 
    windowTitle = "Shiny Image Galleries"
    ),
   
    tabsetPanel(
          tabPanel('Lightbox',
                   fluidRow(
                     column(12, 
                            uiOutput('lb')
                     ))
                                     
          ),
          tabPanel('PhotoSwipe',
                   fluidRow(
                     column(12,
                            uiOutput('ps')
                     ))
          )
        )
      )


server <- function(input, output) {
   
  output$lb <- renderUI({
    
    lightbox_gallery(images[sample(1:nrow(images), 12, replace = FALSE),], 'gallery', display = TRUE)
    
  })
  
  output$ps <- renderUI({
    
    photoswipe_gallery(images[sample(1:nrow(images), 12, replace = FALSE),], 'ps-gallery', display = TRUE)
    
  })

}

# Run the application 
shinyApp(ui = ui, server = server)

