ui <- navbarPage(
  
  theme = bslib::bs_theme(bootswatch = "flatly"),

  "HPAanalyze",
  
  tabPanel("Tissue"),
  
  tabPanel(
    "Pathology",
    sidebarLayout(
      sidebarPanel(
        textInput("gene", label = "Gene")
      ),
      mainPanel(
        withSpinner(plotOutput("plot", width = 500)),
        verbatimTextOutput("text")
      )
    )
  ),
  
  tabPanel("Subcellular location")
)