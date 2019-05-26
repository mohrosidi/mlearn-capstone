library(tidyverse)
library(cluster)
library(factoextra)
library(skimr)

# import data
df <- read_csv("./data-raw/004_hdi.csv")
df
glimpse(df)
skim(df)

# visualisasi data
ggplot(df, aes(x=hdi,y=revenue))+
  geom_point()+
  theme_classic()

#Lakukan Standarisasi dan assign ke variable baru dengan nama "dfnorm".  
dfnorm <- scale(df[,3:4])
skim(as.data.frame(dfnorm))

#Melihat 10 data teratas pada dataset yang telah dinormalisasi
head(dfnorm, 10)

#Menggabungkan label
dfnorm2 <- cbind(df[,1], dfnorm[,1:2])
dfnorm2 <- as_tibble(dfnorm2)

#Menhitung Ditance Matrix menggunakan fungsi get_distance()
distance <- get_dist(dfnorm2, method = "euclidean" )

#Memvisualisasikan Distance Matrix menggunakan fungsi fviz_dist()
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
