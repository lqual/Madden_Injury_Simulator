library(shiny)
library(dplyr)
library(shinybusy)
library(shinythemes)
shinyUI(fluidPage(theme = shinytheme("flatly"),
                  titlePanel(
                          h1("Madden Injury Simulator", align = "center")
                  ),
                  sidebarLayout(
                          sidebarPanel(width = 12,
                                  h4("Simulates whether or not an injury occurs
                                     in franchise mode.  Use after playing each
                                     week's game."),
                                  sliderInput(
                                          "slider", "Week of Season",
                                          value = 1, min = 1, max = 20, step = 1
                                  ),
                                  actionButton(
                                          inputId = "run_it",
                                          label = "Run Simulator"
                                  )
                          ),
                          mainPanel(
                            h2(""),
                            textOutput("injury"),
                            tags$head(tags$style("#injury{color: black;
                            font-size: 25px;
                            }"
                            )
                            ),
                            h2(""),
                            textOutput("position_hurt"),
                            tags$head(tags$style("#position_hurt{color: black;
                            font-size: 25px;
                            }"
                            )
                            ),
                            h2(""),
                            textOutput("quarter_hurt"),
                            tags$head(tags$style("#quarter_hurt{color: black;
                            font-size: 25px;
                            }"
                            )
                            ),
                            h2(""),
                            textOutput("weeks_out"),
                            tags$head(tags$style("#weeks_out{color: black;
                            font-size: 25px;
                            }"
                            )
                            ),
                            h2(""),
                            textOutput("week_return"),
                            tags$head(tags$style("#week_return{color: black;
                            font-size: 25px;
                            }"
                            )
                            ),
                    )
            )        
))