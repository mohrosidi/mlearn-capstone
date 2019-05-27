library(tidyverse)
library(cluster)
library(factoextra)
library(skimr)
library(gridExtra)

# import data
df <- read_csv("./data-raw/004_hdi.csv")
df
glimpse(df)
skim(df)

# visualisasi data
theme_set(theme_classic())
scatter<-ggplot(df, aes(x=hdi,y=revenue))+
  geom_point(shape=1)

hdi <- ggplot(df, aes(x=hdi, fill="#00AFBB"))+
  geom_density()+
  theme(legend.position="none")

revenue <- ggplot(df, aes(x=revenue, fill="#FC4E07"))+
  geom_density()+
  theme(legend.position="none")

grid.arrange(revenue, hdi, scatter, nrow=2)


#Lakukan Standarisasi dan assign ke variable baru dengan nama "dfnorm".  
dfnorm <- scale(df[,3:4])
skim(as.data.frame(dfnorm))

#Melihat 10 data teratas pada dataset yang telah dinormalisasi
head(dfnorm, 10)

#Menggabungkan label
dfnorm2 <- as.data.frame(cbind(df[,1], dfnorm[,1:2]),row.names=df$kota)
head(dfnorm2)

#Menhitung Ditance Matrix menggunakan fungsi get_distance()
distance <- get_dist(dfnorm2[,2:3], method = "euclidean" )

#Memvisualisasikan Distance Matrix menggunakan fungsi fviz_dist()
fviz_dist(distance, gradient = list(low = "white", high = "#FC4E07"))

#Membuat Model K-Means Klustering dengan Jumlah K/Centers =2, nstart = 25, dengan nama K2
k2 <- kmeans(dfnorm2[,2:3], centers = 2, nstart = 25)
str(k2)

#Print Hasil Kluster
k2

table(k2$cluster)

# visualisasi kluster menggunakan fungsi fviz_cluster()
fviz_cluster(k2, data = dfnorm2[,2:3], ggtheme=theme_classic())

dfnorm2 %>%
  as_tibble() %>%
  mutate(cluster = k2$cluster,
         kota = row.names(dfnorm2)) %>%
  ggplot(aes(hdi, revenue, color = factor(cluster), label = kota)) +
  geom_text()

# Elbow Method
#Visualisasi Elbow Method menggunakan fungsi fviz_nbclust()
fviz_nbclust(dfnorm2[,2:3], kmeans, method = "wss")

# Silhoutte Method
#Visualisasi Average Silhoutte menggunakan fugsi fviz_nbclust()
fviz_nbclust(dfnorm2[,2:3], kmeans, method = "silhouette")

#Membuat Model K-Means Klustering dengan Jumlah K/Centers =3, nstart = 25, dengan nama K2
k3 <- kmeans(dfnorm2[,2:3], centers = 3, nstart = 25)
str(k3)

#Print Hasil Kluster
k3

table(k3$cluster)

# visualisasi kluster menggunakan fungsi fviz_cluster()
fviz_cluster(k3, data = dfnorm2[,2:3], ggtheme=theme_classic())
