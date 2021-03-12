tissueServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    ## Selectize input
    
    for (i in c("gene", "tissue", "cell_type")) {
      updateSelectizeInput(
        session, i, 
        choices = HPAanalyze::hpa_histology_data$normal_tissue[[i]],
        server = TRUE)
    }
    
    ## Creating plot
    output$plot <- renderPlot({
      req(input$go, isolate(input$gene), isolate(input$tissue))
      hpaVisTissue(targetGene = isolate(input$gene), 
                  targetTissue = isolate(input$tissue),
                  targetCellType = isolate(input$cell_type))
    })
    
    ## Creating table
    data <- reactive({
      req(input$go, isolate(input$gene), isolate(input$tissue))
      hpaSubset(targetGene = isolate(input$gene), 
                targetTissue = isolate(input$tissue),
                targetCellType = isolate(input$cell_type))$normal_tissue
    })
    
    output$table <- renderDataTable(
      data(),
      options = list(pageLength = 5))
    
    output$download_data <- downloadHandler(
      filename = function() {
        paste0("tissue_", gsub("[^0-9]", '_', Sys.time()), ".csv")
      },
      content = function(file) {
        vroom::vroom_write(data(), file, delim = ",")
      }
    )
  })
}


pathologyServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    ## Selectize input
    
    for (i in c("gene", "cancer")) {
      updateSelectizeInput(
        session, i, 
        choices = HPAanalyze::hpa_histology_data$pathology[[i]],
        server = TRUE)
    }

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
  
## TISSUE
  tissueServer("tissue")
  
## PATHOLOGY ===================================================================
  pathologyServer("pathology")

  
}