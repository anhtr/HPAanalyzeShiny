tissueUI <- function(id) {
  tagList(
    sidebarLayout(
      sidebarPanel(
        selectInput(NS(id,"gene"), label = "Genes", 
                    choices = NULL, multiple = TRUE),
        selectInput(NS(id,"tissue"), label = HTML("Tissues"), 
                    choices = NULL, multiple = TRUE),
        selectInput(NS(id,"cell_type"), 
                    label = HTML("Cell types <br/> (Leave emplty for all)"), 
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
      output_plot <<- hpaVisTissue(data = HPAanalyze::hpa_histology_data,
                   targetGene = isolate(input$gene), 
                   targetTissue = isolate(input$tissue),
                   targetCellType = isolate(input$cell_type))
      output_plot
    })
    
    ## Creating table
    data <- reactive({
      req(input$go, isolate(input$gene), isolate(input$tissue))
      hpaSubset(data = HPAanalyze::hpa_histology_data,
                targetGene = isolate(input$gene), 
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
    
    output$download_plot <- downloadHandler(
      filename = function() {
        paste0("tissue_", gsub("[^0-9]", '_', Sys.time()), ".pdf")
      },
      content = function(file) {
        ggplot2::ggsave(file, plot = output_plot, device = "pdf")
      }
    )
  })
}
