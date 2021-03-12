buttons_ui <- function(id) {
  tagList(
    actionButton(NS(id,"go"), "Go!", class = "btn-primary btn-lg btn-block"),
    HTML("<br/><br/>"),
    downloadButton(NS(id, "download_data"), "Data", class = "btn-block"),
    downloadButton(NS(id, "download_plot"), "Plot", class = "btn-block")
  )
}

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

