#' @import shiny
#' @import HPAanalyze
#' @import shinycssloaders

hpaShiny <- function(...) {
  ui <- navbarPage(
    
    theme = bslib::bs_theme(bootswatch = "flatly"),
    
    title = "HPAanalyze",
    
    tabPanel(
      "Tissue",
      tissueUI("tissue")
    ),
    
    tabPanel(
      "Pathology",
      pathologyUI("pathology")
    ),
    
    tabPanel(
      "Subcellular location",
      subcellUI("subcell")
    )
  )
  
  server <- function(input, output, session) {
    
    ## TISSUE ==================================
    tissueServer("tissue")
    
    ## PATHOLOGY ===============================
    pathologyServer("pathology")
    
    ## SUBCELLULAR LOCATION ====================
    subcellServer("subcell")
    
  }
  
  shinyApp(ui, server, ...)
}