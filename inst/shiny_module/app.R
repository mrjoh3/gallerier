

library(shiny)
library(shinythemes)
library(gallerier)

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
                                    galleryUI('lb')
                             ))
                           
                  )
                )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
   
  callModule(gallery, id = 'lb', images = 'www/img', gallery = 'lightbox', session = session)  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

