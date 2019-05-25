library(tidyverse)
library(ggpubr)
library(skimr)
library(rattle)
library(rpart)
library(rpart.plot)
library(naivebayes)
library(class)
library(e1071)
library(caret)

# import dataset
df <- read_csv("./data-raw/003_lamudi.csv")
df
skim(df)

# data cleaning
df_clean <- df %>% mutate_if(is.character, as.factor) %>% filter(!is.na(harga_rumah)==TRUE)
skim(df_clean)

# data preprocessing
set.seed(123)
#Membangi Data Ke Training dan Testing (70:30)
index_train <- sample(1:nrow(df_clean), 0.7 * nrow(df_clean))
train <- df_clean[index_train, ]
test <- df_clean[-index_train, ]

# -----------------Decision tree---------------------
#Membuat Model Decison Tree Untuk Mengklasifikasi Apakah Seseorang akan klaim Asuransi atau tidak. 
tree <- rpart(alamat_rumah ~., train, method = "class")
prp(tree)

#Memvisualisasikan Decison Tree dengan lebih informatif
fancyRpartPlot(tree)  

#Menggunakan Untuk Melakukan Prediksi Pada Data Testing
pred_dt <- predict(tree, test, type = "class")

# validation
#Validasi Menggunakan Confussion Matrix
conf <- table(test$alamat_rumah, pred_dt)
conf

#confusion matrix lengkap
confusionMatrix(pred_dt, test$alamat_rumah)


# menghitung nilai akurasi
acct <- mean(prediction==test$alamat_rumah)
acct  

# ---------------Naive Bayes--------------------------
#Membuat model prediksi Naive Bayes
nb <- naive_bayes(alamat_rumah ~ ., data = train)

#Melihat model yang telah dibuat 
nb

#Visualisasi Model
par(mfrow=c(2,4))
plot(nb)

#Melakukan prediksi dengan data testing
pred_nb <- predict(nb, as.data.frame(test))

# validation
#Membuat Confussion Matrix Naive Bayes
confnb <- table(test$alamat_rumah, pred_nb)
confnb

#confusion matrix lengkap
confusionMatrix(pred_nb, test$alamat_rumah)

# akurasi
accnb <- mean(pred_nb==test$alamat_rumah)
accnb

# -----------------K-NN-------------------------------
# Data preprocessing
df_clean <- mutate_if(df_clean, is.factor, as.numeric)

#Membuat fungsi Normalisasi
normalize<-function(x){
  temp<-(x-min(x))/(max(x)-min(x))
  return(temp)
}

#Melakukan Normalisasi
df_norm<-as.data.frame(lapply(df_clean[,-1],normalize))
df_norm2<-bind_cols(df_clean[,1],df_norm)
df_norm2

#Membagi ke Data Train dan Data Testing
index_train <- sample(1:nrow(df_norm2), 0.7 * nrow(df_norm2))
df_norm2_train <- df_norm2[index_train, -1]
df_norm2_test <- df_norm2[-index_train, -1]

#Mengambil Label
df_norm2_train_target<-df_norm2[index_train ,1]
df_norm2_test_target<-df_norm2[-index_train ,1]

#Membuat KNN-Model dengan Nilai K=3
knnmodel <-knn(train=df_norm2_train,test=df_norm2_test,
               cl=as.matrix(df_norm2_train_target,k=2))

knnmodel

# Validation
#Validasi Menggunakan Confussion Matrix
confknn <- table(df_norm2_test_target$alamat_rumah, knnmodel)
confknn

#confusion matrix lengkap
confusionMatrix(knnmodel, 
                as.factor(df_norm2_test_target$alamat_rumah))

# akurasi
acck <- mean(knnmodel==df_norm2_test_target$alamat_rumah)
acck

# ---------------------Membandingkan Model-------------------
acct
accnb
acck

