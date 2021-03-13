pathologyUI <- function(id) {
  tagList(
    sidebarLayout(
      sidebarPanel(
        selectInput(NS(id,"gene"), label = "Genes", 
                    choices = NULL, multiple = TRUE),
        selectInput(NS(id,"cancer"), 
                    label = HTML("Cancers <br/> (Leave emplty for all)"), 
                    choices = NULL, multiple = TRUE),
        buttons_ui(id)
      ),
      mainPanel(
        withSpinner(plotOutput(NS(id,"plot"), width = 500)),
        dataTableOutput(NS(id,"table"))
      )
    )
  )
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
      hpaVisPatho(data = HPAanalyze::hpa_histology_data,
                  targetGene = isolate(input$gene), 
                  targetCancer = isolate(input$cancer))
    })
    
    ## Creating table
    data <- reactive({
      req(input$go, isolate(input$gene))
      hpaSubset(data = HPAanalyze::hpa_histology_data,
                targetGene = isolate(input$gene), 
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