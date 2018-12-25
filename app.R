

library(shiny)
source('src/lightbox.R')

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Shiny Image Galleries"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tabPanel('Lightbox',
                 
                 fluidRow(
                   column(12, h2('Image Availability'),
                          uiOutput('lightbox')
                   ))
                 
        )
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  output$lightbox <- renderUI({

    images <- data.frame()
    
    # gallery DIV
    lightbox_gallery(images, display = TRUE)
    
  })

}

# Run the application 
shinyApp(ui = ui, server = server)

