install.packages("syuzhet")
install.packages("tidyverse")
library(syuzhet)
library(tidyverse)

df_bit <- read_csv2("Data/news_bitcoin.csv")
str(df_bit)
#df_bit_subset <- df_bit %>% filter(id < 21)#

sentiment_positive <- function(text){
  eval <- get_nrc_sentiment(text)
  print(eval)
  return (eval$positive)
}

sentiment_negative <- function(text){
  eval <- get_nrc_sentiment(text)
  print(eval)
  return (eval$negative)
}

df_bit$Negative <- sapply(df_bit$Title, sentiment_negative)
df_bit$Positive <- sapply(df_bit$Title, sentiment_positive)

write_csv(df_bit,"Data/news_bitcoin_sentiment.csv")
