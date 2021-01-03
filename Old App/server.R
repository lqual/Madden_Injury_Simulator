library(shiny)
library(dplyr)
library(shinybusy)
library(shinythemes)
shinyServer(function(input, output) {
        
        
        #build dataframe of positions and injury probability
        positionsdf <- read.csv("position_probabilities_3-4_defense.csv", 
                                stringsAsFactors = FALSE)
        
        
        #calculate probabilities of injury by position
        positionsdf <- positionsdf %>% mutate(probabilities = position_count/sum(position_count))
        
        
        #build dataframe of number of injured weeks
        weeksdf <- read.csv("injured_weeks_probability.csv", 
                            stringsAsFactors = FALSE)
        
        
        observeEvent(input$run_it, {
                show_modal_spinner()
                
                week_of_season <- input$slider
                
                
                #select a position
                lookupHurt <- sample(1:length(positionsdf$position), 
                                     size = 1, replace = FALSE, 
                                     prob = positionsdf$probabilities)
                position <- positionsdf[lookupHurt, 1]
                
                
                #select a number of weeks
                lookupWeeks <- sample(1:length(weeksdf$injured_weeks), 
                                      size = 1, replace = FALSE, 
                                      prob = weeksdf$probability)
                weeks <- weeksdf[lookupWeeks, 1]
                
                
                #injury
                injury <- sample(c("Yes, there was an injury.", 
                                   "No, there wasn't an injury.",
                                   "No, there wasn't an injury.",
                                   "No, there wasn't an injury."), 1)
                
                
                #quarter
                quarter <- sample(c("Quarter 1", "Quarter 2", "Quarter 3", "Quarter 4"), 1)
                
                
                #filling in the outputs
                output$injury <- renderText({
                        paste(injury)
                })
                        
                output$position_hurt <- renderText({
                        paste("The ", position, " would be affected.")
                })
                        
                output$quarter_hurt <- renderText({
                        paste("The player would have been hurt in ", quarter, ".")
                })
                        
                output$weeks_out <- renderText({
                        paste("The player would be out ", weeks, " week(s).")
                })
                        
                output$week_return <- renderText({
                        paste("The player would return from injury in week ", 
                              week_of_season + weeks + 1, ".")
                })
                
                
                remove_modal_spinner()
        }
        )
})