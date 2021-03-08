ui <- navbarPage(
  "HPAanalyze",
  tabPanel("Tissue"),
  
  tabPanel(
    "Pathology",
    sidebarLayout(
      sidebarPanel(
        textInput("gene", label = "Gene")
      ),
      mainPanel(
        plotOutput("plot", width = 500),
        verbatimTextOutput("text")
      )
    )
  ),
  
  tabPanel("Subcellular location")
)