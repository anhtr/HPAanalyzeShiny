server <- function(input, output, session) {
  
  output$plot <- renderPlot(hpaVisPatho(targetGene = input$gene))

  output$table <- renderDataTable(
    hpaSubset(targetGene = input$gene)$pathology,
    options = list(pageLength = 5))

}