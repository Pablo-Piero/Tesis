install.packages("randomForest")

# Carga el paquete especificacion del metodo Random Forest
library(randomForest)
library(tidyverse)


news_data <- read_csv2("news_Ethereum_sentiment.csv", col_types = cols(
  obs = col_number()
))
str(news_data)

news_data$etiqueta_noticia <- as.factor(news_data$etiqueta_noticia)
news_data$etiqueta_variacion <- as.factor(news_data$etiqueta_variacion)
news_data$id <- as.numeric(news_data$id)
str(news_data)

#news_data_df <- news_data %>% filter(Obs > 471 )
news_data_df <- news_data %>% filter(etiqueta_variacion != "Neutro" )
news_data_df <- news_data_df %>% filter(etiqueta_noticia != "Neutro" )

news_data_df

#news_data_df <-  news_data %>% select(Open,High, Low, Close,etiqueta_noticia, etiqueta_variacion)
news_data_df <-  news_data_df %>% select(Open,High, Low, Close, etiqueta_variacion)


str(news_data_df)

set.seed(67)
tamano.total <- nrow(news_data_df)
tamano.entreno <- round(tamano.total*0.8)
datos.indices <- sample(1:tamano.total , size=tamano.entreno)
datos.entreno <- news_data_df[datos.indices,]
datos.test <- news_data_df[-datos.indices,]

#modelo <- randomForest(etiqueta_variacion~., data=datos.entreno)
modelo <- randomForest(etiqueta_variacion~., data=datos.entreno)
#modelo <- randomForest(Variacion_num~., data=datos.entreno)

modelo

#modelo$importance

predicciones <- predict(modelo, datos.test)
(mc <- with(datos.test,table(predicciones, etiqueta_variacion)))

100 * sum(diag(mc)) / sum(mc)