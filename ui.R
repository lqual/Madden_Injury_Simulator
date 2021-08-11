library(shiny)
library(dplyr)
library(shinybusy)
library(shinythemes)


#week number for slider
week_number <- read.csv("week_number.csv", 
                        stringsAsFactors = FALSE)


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
                                          value = week_number$week_number[1], 
                                          min = 1, max = 20, step = 1
                                  ),
                                  sliderInput(
                                          "probability", "Injury Probability",
                                          value = .25, min = 0, max = 1, step = 0.05
                                  ),
                                  actionButton(
                                          inputId = "run_it",
                                          label = "Run Simulator"
                                  )
                          ),
                          mainPanel(
                            h2(""),
                            textOutput("text_1"),
                            tags$head(tags$style("#text_1{color: black;
                            font-size: 25px;
                            }"
                            )
                            ),
                            h2(""),
                            textOutput("text_2"),
                            tags$head(tags$style("#text_2{color: black;
                            font-size: 25px;
                            }"
                            )
                            ),
                            h2(""),
                            textOutput("text_3"),
                            tags$head(tags$style("#text_3{color: black;
                            font-size: 25px;
                            }"
                            )
                            ),
                            h2(""),
                            textOutput("text_4"),
                            tags$head(tags$style("#text_4{color: black;
                            font-size: 25px;
                            }"
                            )
                            ),
                            #h2(""),
                            #textOutput("week_return"),
                            #tags$head(tags$style("#week_return{color: black;
                            #font-size: 25px;
                            #}"
                            #)
                            #),
                    )
            )        
))