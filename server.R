pathologyServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    ## Selectize input
    updateSelectizeInput(
      session, "gene", 
      choices = HPAanalyze::hpa_histology_data$pathology$gene,
      server = TRUE)
    
    updateSelectizeInput(
      session, "cancer", 
      choices = HPAanalyze::hpa_histology_data$pathology$cancer,
      server = TRUE)
    
    ## Creating plot
    output$plot <- renderPlot({
      req(input$go, isolate(input$gene))
      hpaVisPatho(targetGene = isolate(input$gene), 
                  targetCancer = isolate(input$cancer))
    })
    
    ## Creating table
    data <- reactive({
      req(input$go, isolate(input$gene))
      hpaSubset(targetGene = isolate(input$gene), 
                targetCancer = isolate(input$cancer))$pathology
    })
    
    output$table <- renderDataTable(
      data(),
      options = list(pageLength = 5))
    
    output$download_data <- downloadHandler(
      filename = function() {
        paste0("pathology_", gsub("[^0-9]", '_', Sys.time()), ".csv")
      },
      content = function(file) {
        vroom::vroom_write(data(), file, delim = ",")
      }
    )
  })
}

server <- function(input, output, session) {
  
  # ## Selectize input
  # updateSelectizeInput(
  #   session, "gene", 
  #   choices = HPAanalyze::hpa_histology_data$normal_tissue$gene,
  #   server = TRUE)
  # 
  # updateSelectizeInput(
  #   session, "tissue", 
  #   choices = HPAanalyze::hpa_histology_data$normal_tissue$tissue,
  #   server = TRUE)
  # 
  # updateSelectizeInput(
  #   session, "cell_type", 
  #   choices = HPAanalyze::hpa_histology_data$normal_tissue$cell_type,
  #   server = TRUE)
  
## PATHOLOGY ===================================================================
  pathologyServer("pathology")

  
}