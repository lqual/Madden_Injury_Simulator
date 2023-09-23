library(shiny)
library(dplyr)
library(shinybusy)
library(shinythemes)
shinyServer(function(input, output) {
        
        
        #build dataframe of positions and injury probability
        positionsdf <- read.csv("position_probabilities_3-4_defense.csv", 
                                stringsAsFactors = FALSE)
        
        
        #calculate probabilities of injury by position
        offensedf <- positionsdf %>% 
                filter(group == "Offense") %>%
                mutate(probabilities = position_count/sum(position_count))
        defensedf <- positionsdf %>% 
                filter(group == "Defense") %>%
                mutate(probabilities = position_count/sum(position_count))
        
        
        #build dataframe of number of injured weeks
        weeksdf <- read.csv("injured_weeks_probability.csv", 
                            stringsAsFactors = FALSE)
        

        observeEvent(input$run_it, {
                show_modal_spinner()
                
                week_of_season <- input$slider
                #probability <- input$probability
                
                
                #update week number in input file
                next_weak <- read.csv("week_number.csv",
                                        stringsAsFactors = FALSE)
                next_weak$week_number[1] <- ifelse(
                  week_of_season > 19,
                  1,
                  week_of_season + 1
                )
                # write.table(next_weak, 
                #             "week_number.csv",
                #             col.names = T,
                #             row.names = F,
                #             append = F,
                #             sep = ",")
                
                #offense select a position
                offense_lookupHurt <- sample(1:length(offensedf$position), 
                                     size = 1, replace = FALSE, 
                                     prob = offensedf$probabilities)
                offense_position <- offensedf[offense_lookupHurt, 1]
                
                
                #offense select a number of weeks
                offense_lookupWeeks <- sample(1:length(weeksdf$injured_weeks), 
                                      size = 1, replace = FALSE, 
                                      prob = weeksdf$probability)
                offense_weeks <- weeksdf[offense_lookupWeeks, 1]
                
                
                #offense injury
                injury_prob <- input$probability #/ 2
                non_injury_prob <- 1 - injury_prob
                offense_injury <- sample(c("Yes, there was an injury on offense.", 
                                   "No, there wasn't an injury on offense."),
                                 prob = c(injury_prob, non_injury_prob),
                                 1)
                
                
                #offense quarter
                offense_quarter <- sample(c("Quarter 1", "Quarter 2", "Quarter 3", "Quarter 4"), 1)
                
                
                #offense words
                offense_text_1 <- if(offense_injury == "No, there wasn't an injury on offense.") {
                        paste(offense_injury)
                } else {
                        paste0("The ", offense_position, " was hurt in quarter ", offense_quarter, ".")
                }
                
                offense_text_2 <- if(offense_injury == "No, there wasn't an injury on offense.") {
                        paste(" ")
                } else {
                        paste0("He will be out ", offense_weeks, 
                              " week(s), and will return in week ", week_of_season + offense_weeks + 1, ".")
                }
                
                
                #defense select a position
                defense_lookupHurt <- sample(1:length(defensedf$position), 
                                             size = 1, replace = FALSE, 
                                             prob = defensedf$probabilities)
                defense_position <- defensedf[defense_lookupHurt, 1]
                
                
                #defense select a number of weeks
                defense_lookupWeeks <- sample(1:length(weeksdf$injured_weeks), 
                                              size = 1, replace = FALSE, 
                                              prob = weeksdf$probability)
                defense_weeks <- weeksdf[defense_lookupWeeks, 1]
                
                
                #defense injury
                injury_prob <- input$probability #/ 2
                non_injury_prob <- 1 - injury_prob
                defense_injury <- sample(c("Yes, there was an injury on defense.", 
                                           "No, there wasn't an injury on defense."),
                                         prob = c(injury_prob, non_injury_prob),
                                         1)
                
                
                #defense quarter
                defense_quarter <- sample(c("Quarter 1", "Quarter 2", "Quarter 3", "Quarter 4"), 1)
                
                
                #defense words
                defense_text_1 <- if(defense_injury == "No, there wasn't an injury on defense.") {
                        paste0(defense_injury)
                } else {
                        paste0("The ", defense_position, " was hurt in quarter ", defense_quarter, ".")
                }
                
                defense_text_2 <- if(defense_injury == "No, there wasn't an injury on defense.") {
                        paste(" ")
                } else {
                        paste0("He will be out ", defense_weeks, 
                               " week(s), and will return in week ", week_of_season + defense_weeks + 1, ".")
                }
                
                
                #filling in the outputs
                output$text_1 <- renderText({
                        #paste(offense_injury)
                        paste(offense_text_1)
                })
                        
                output$text_2 <- renderText({
                        #paste("The ", offense_position, " would be affected.")
                        paste(offense_text_2)
                })
                        
                output$text_3 <- renderText({
                        #paste("The player would have been hurt in ", offense_quarter, ".")
                        paste(defense_text_1)
                })
                        
                output$text_4 <- renderText({
                        #paste("The player would be out ", offense_weeks, " week(s).")
                        paste(defense_text_2)
                })
                        
                #output$week_return <- renderText({
                #        paste("The player would return from injury in week ", 
                #              week_of_season + offense_weeks + 1, ".")
                #})
                
                
                remove_modal_spinner()
        }
        )
})