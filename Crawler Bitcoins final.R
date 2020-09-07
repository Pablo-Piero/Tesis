library(jsonlite)
library(Rcrawler)
library(tidyverse)

#Obtiene los slug
category = "ethereum" #Nombre de la categoria que se quiere obtener
listURLs <- c()
pageNumber <- 1 #Creo que debieran ser hasta 150
  for (i in 1:pageNumber){
    url <- paste("https://www.coindesk.com/wp-json/v1/articles/tag/", category, "/", i,"?mode=list")
    print(url)
    mydata <- fromJSON(url) 
    listURLs <- c(listURLs,paste("https://www.coindesk.com/",mydata$post$slug, sep=''))
  }
print(listURLs)
#Crawler de noticias
news<-ContentScraper(Url = listURLs,
                     CssPatterns =c(".article-hero-title > .heading",".article-body","[datetime]"),
                     PatternsName = c("Title","Content", "Date"),
                     ManyPerPattern = FALSE)

df <- data.frame(matrix(unlist(news), nrow=length(news), byrow=T))

#Eliminamos los saltos de líneas
df$X1 <- sapply(df$X1, function(x) { gsub("[\r\n]", ".", x) })
df$X2 <- sapply(df$X2, function(x) { gsub("[\r\n]", ".", x) })
df
#df es para ver como el print#
#Guarda el archivo
filePath <- "C:\\Users\\cmadr\\OneDrive\\Escritorio\\TESIS\\" #EN Windows debe ser C:\\Users\\JM\\Desktop\\
filePath <- paste(filePath, category, "-newsethereum8.csv", sep="")
write_csv(df,filePath)
