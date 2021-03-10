ui <- navbarPage(
  
  theme = bslib::bs_theme(bootswatch = "flatly"),
  
  "HPAanalyze",
  
  tabPanel("Tissue"),
  
  tabPanel(
    "Pathology",
    sidebarLayout(
      sidebarPanel(
        selectInput("gene", label = "Gene(s)", choices = NULL, multiple = TRUE),
        selectInput("cancer", label = HTML("Cancer(s) <br/> (Leave emplty for all)"), choices = NULL, multiple = TRUE),
        actionButton("go", "Go!", class = "btn-success"),
        HTML("<br/><br/>"),
        downloadButton("download_data", "Download data")
      ),
      mainPanel(
        withSpinner(plotOutput("plot", width = 500)),
        dataTableOutput("table")
      )
    )
  ),
  
  tabPanel("Subcellular location")
)