library(tidyverse)
library(skimr)
library(naivebayes)
library(caret)

# import data

df <- read_csv("./data-raw/002_twitter-bot.csv")

# ekplorasi data
glimpse(df)
skim(df)

df %>% 
  select(-contains("count"),
         -friend_ratio,-tweet,
         -hashtags,-contains("name")) %>% 
  map(unique)

table(df$status)

# data cleaning
df_clean<- df %>% 
  drop_na() %>% 
  select(-tweet,-hashtags,-contains("name"),
         -account_created_at) %>% 
  mutate(status=tolower(status)) %>% 
  filter(status %in% c("bot","human","suspicious")) %>% 
  mutate_if(is_character, as_factor) 

df_clean %>% skim()

# data preprocessing
set.seed(123)
#Membangi Data Ke Training dan Testing (70:30)
index_train <- sample(1:nrow(df_clean), 0.7 * nrow(df_clean))
train <- df_clean[index_train, ]
test <- df_clean[-index_train, ]

# ---------------Naive Bayes--------------------------
#Membuat model prediksi Naive Bayes
nb <- naive_bayes(status ~ ., data = train)

#Melihat model yang telah dibuat 
nb

#Visualisasi Model
par(mfrow=c(2,4))
plot(nb)

#Melakukan prediksi dengan data testing
pred_nb <- predict(nb, as.data.frame(test))

# validation
#Membuat Confussion Matrix Naive Bayes
confnb <- table(test$status, pred_nb)
confnb

#confusion matrix lengkap
confusionMatrix(pred_nb, test$status)

# CV
nb_cv <- train(df_clean[,-24],df_clean$status,
            method="nb",
            trControl = trainControl(method = "cv", number = 10))
nb
plot(nb)

# -----------------Decision tree---------------------
#Membuat Model Decison Tree Untuk Mengklasifikasi Apakah Seseorang akan klaim Asuransi atau tidak. 
tree <- rpart(status ~., train, method = "class")
prp(tree)