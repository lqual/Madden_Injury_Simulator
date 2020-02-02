#libraries
library(dplyr)


#build dataframe of positions and injury probability
pr



positionProbs <- c(10/26, 5/26, 2/26, 2/26, 2/26, 1/26, 1/26, 1/26, 1/26, 1/26)
lookup1 <- sample(1:10, size = 3, replace = FALSE, prob = myprobs)
unigram <- data.frame(next_word = c("the", "and", "for", "that", "you",
                                    "with", "Was", "this", "have","are"))
answer1 <- data.frame(unigram$next_word[lookup1])
colnames(answer1) <- "answer"