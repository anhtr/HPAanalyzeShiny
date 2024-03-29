subcellUI <- function(id) {
  tagList(
    sidebarLayout(
      sidebarPanel(
        selectInput(NS(id,"gene"), label = "Genes", 
                    choices = NULL, multiple = TRUE),
        selectInput(NS(id,"reliability"), 
                    label = "Reliability", 
                    choices = c("enhanced", "supported", 
                                "approved", "uncertain"),
                    selected = c("enhanced", "supported", 
                                "approved", "uncertain"), 
                    multiple = TRUE),
        buttons_ui(id)
      ),
      mainPanel(
        withSpinner(plotOutput(NS(id,"plot"), width = 500)),
        dataTableOutput(NS(id,"table"))
      )
    )
  )
}

subcellServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    ## Selectize input
    
    updateSelectizeInput(
      session, "gene", 
      choices = HPAanalyze::hpa_histology_data$subcellular_location[["gene"]],
      server = TRUE)
    
    ## Creating plot
    output$plot <- renderPlot({
      req(input$go, isolate(input$gene))
      output_plot <<- hpaVisSubcell(data = HPAanalyze::hpa_histology_data,
                    targetGene = isolate(input$gene), 
                    reliability = isolate(input$reliability))
      output_plot
    })
    
    ## Creating table
    data <- reactive({
      req(input$go, isolate(input$gene))
      hpaSubset(data = HPAanalyze::hpa_histology_data,
                targetGene = isolate(input$gene))$subcellular_location
    })
    
    output$table <- renderDataTable(
      data(),
      options = list(pageLength = 5))
    
    output$download_data <- downloadHandler(
      filename = function() {
        paste0("subcell_", gsub("[^0-9]", '', Sys.time()), ".csv")
      },
      content = function(file) {
        vroom::vroom_write(data(), file, delim = ",")
      }
    )
    
    output$download_plot <- downloadHandler(
      filename = function() {
        paste0("subcell_", gsub("[^0-9]", '', Sys.time()), ".pdf")
      },
      content = function(file) {
        ggplot2::ggsave(file, output_plot, device = "pdf")
      }
    )
  })
}