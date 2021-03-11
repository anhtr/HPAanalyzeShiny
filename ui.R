download_buttons_ui <- function(id) {
  tagList(
    HTML("<br/><br/>"),
    downloadButton(NS(id,"download_data"), "Download data")
  )
}

pathologyUI <- function(id) {
  tagList(
    sidebarLayout(
      sidebarPanel(
        selectInput(NS(id,"gene"), label = "Gene(s)", choices = NULL, multiple = TRUE),
        selectInput(NS(id,"cancer"), label = HTML("Cancer(s) <br/> (Leave emplty for all)"), choices = NULL, multiple = TRUE),
        actionButton(NS(id,"go"), "Go!", class = "btn-success"),
        download_buttons_ui(id)
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
    # sidebarLayout(
    #   sidebarPanel(
    #     selectInput("gene", label = "Gene(s)", choices = NULL, multiple = TRUE),
    #     selectInput("tissue", label = HTML("Tissue(s)"), choices = NULL, multiple = TRUE),
    #     selectInput("cell_type", label = HTML("Cell type(s) <br/> (Leave emplty for all)"), choices = NULL, multiple = TRUE),
    #     actionButton("go", "Go!", class = "btn-success"),
    #     download_buttons_ui()
    #   ),
    #   mainPanel(
    #     withSpinner(plotOutput("plot", width = 500)),
    #     dataTableOutput("table")
    #   )
    # )
  ),
  
  tabPanel(
    "Pathology",
    pathologyUI("pathology")
  ),
  
  tabPanel("Subcellular location")
)

