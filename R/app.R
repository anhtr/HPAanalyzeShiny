#' @import shiny
#' @import HPAanalyze
#' @import shinycssloaders

hpaShiny <- function(...) {
  ui <- navbarPage(
    
    theme = bslib::bs_theme(bootswatch = "flatly"),
    
    "HPAanalyze",
    
    tabPanel(
      "Tissue",
      tissueUI("tissue")
    ),
    
    tabPanel(
      "Pathology",
      pathologyUI("pathology")
    ),
    
    tabPanel("Subcellular location")
  )
  
  server <- function(input, output, session) {
    
    ## TISSUE ==================================
    tissueServer("tissue")
    
    ## PATHOLOGY ===============================
    pathologyServer("pathology")
    
    
  }
  
  shinyApp(ui, server, ...)
}