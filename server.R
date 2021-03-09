server <- function(input, output, session) {
  
  output$plot <- renderPlot(hpaVisPatho(targetGene = input$gene))
  
  data <- reactive(hpaSubset(targetGene = input$gene)$pathology)
  
  output$table <- renderDataTable(
    data(),
    options = list(pageLength = 5))
  
  output$download_data <- downloadHandler(
    filename = function() {
      paste0("pathology_", input$gene, ".csv")
    },
    content = function(file) {
      vroom::vroom_write(data(), file, delim = ",")
    }
  )
  
}