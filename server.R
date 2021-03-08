server <- function(input, output, session) {
    
    output$plot <- renderPlot(hpaVisPatho())
    
}