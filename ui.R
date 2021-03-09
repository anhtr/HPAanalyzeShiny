ui <- navbarPage(
  
  theme = bslib::bs_theme(bootswatch = "flatly"),

  "HPAanalyze",
  
  tabPanel("Tissue"),
  
  tabPanel(
    "Pathology",
    sidebarLayout(
      sidebarPanel(
        textInput("gene", label = "Gene"),
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