ui <- fluidPage(
  titlePanel(
    "HPAanalyze"
  ),
  sidebarLayout(
    sidebarPanel(
      textInput("gene", label = "Gene")
    ),
    mainPanel(
      plotOutput("plot", width = 500),
      verbatimTextOutput("text")
    )
  )
)