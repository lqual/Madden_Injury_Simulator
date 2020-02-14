#libraries
library(dplyr)


#build dataframe of positions and injury probability
positionsdf <- read.csv("position_probabilities_3-4_defense.csv", 
                        stringsAsFactors = FALSE)


#calculate probabilities of injury by position
positionsdf <- positionsdf %>% mutate(probabilities = position_count/sum(position_count))


#select a position
lookupHurt <- sample(1:length(positionsdf$position), 
                  size = 1, replace = FALSE, 
                  prob = positionsdf$probabilities)
position <- positionsdf[lookupHurt, 1]
position


#build dataframe of number of injured weeks
weeksdf <- read.csv("injured_weeks_probability.csv", 
                        stringsAsFactors = FALSE)


#select a number of weeks
lookupWeeks <- sample(1:length(weeksdf$injured_weeks), 
               size = 1, replace = FALSE, 
               prob = weeksdf$probability)
weeks <- weeksdf[lookupWeeks, 1]
weeks


#injury
injury <- sample(c("Yes", "No", "No", "No"), 1)


#quarter
quarter <- sample(c("Quarter 1", "Quarter 2", "Quarter 3", "Quarter 4"), 1)






