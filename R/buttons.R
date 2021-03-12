buttons_ui <- function(id) {
  tagList(
    actionButton(NS(id,"go"), "Go!", class = "btn-primary btn-lg btn-block"),
    HTML("<br/><br/>"),
    downloadButton(NS(id, "download_data"), "Data", class = "btn-block"),
    downloadButton(NS(id, "download_plot"), "Plot", class = "btn-block")
  )
}
