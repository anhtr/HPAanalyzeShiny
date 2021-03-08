server <- function(input, output, session) {
    
    output$plot <- renderPlot(hpaVisPatho(targetGene = input$gene))
    output$text <- renderPrint(input$gene)
    
}