library(tidyverse)
library(skimr)
library(naivebayes)
library(caret)
library(gridExtra)

# ----------import data------------------

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

# --------------data cleaning---------------------
df_clean<- df %>% 
  drop_na() %>% 
  select(-tweet,-hashtags,-contains("name"),
         -account_created_at) %>% 
  mutate(status=tolower(status)) %>% 
  mutate(lang=ifelse(lang=="in", "in", "others"),
         account_lang=ifelse(account_lang=="id", "id", "others")) %>% 
  filter(status %in% c("bot","human","suspicious")) %>% 
  mutate_if(is_character, as_factor) 

df_clean %>% skim()

# ----------------Exploratory Data Analysis----------------
theme_set(theme_classic())
## Variabel Numerik
favourite <- ggplot(df_clean, aes(favorite_count))+
  geom_density(fill="yellow")
favourites <- ggplot(df_clean, aes(favourites_count))+
  geom_density(fill="red")
followers<- ggplot(df_clean, aes(followers_count))+
  geom_density(fill="blue")
friend <- ggplot(df_clean, aes(friend_ratio))+
  geom_density(fill="gray")
friends <- ggplot(df_clean, aes(friends_count))+
  geom_density(fill="orange")
listed <- ggplot(df_clean, aes(listed_count))+
  geom_density(fill="violet")
retweet <- ggplot(df_clean, aes(retweet_count))+
  geom_density(fill="green")
statuses <- ggplot(df_clean, aes(statuses_count))+
  geom_density(fill="magenta")

grid.arrange(favourite, favourites,
             followers, friend,
             friends, listed,
             retweet, statuses, nrow=3)

# Variabel factor
source<-df_clean %>% 
  group_by(source) %>%
  summarise(frekuensi=n()) %>%
  top_n(10) %>% 
  ggplot(aes(x=reorder(source,frekuensi), y=frekuensi, 
             fill=source))+
  geom_bar(stat="identity")+
  theme(legend.position="none")+
  coord_flip()+
  labs(x="source",
       title="top 10 tweet source")

account <- df_clean %>% 
  group_by(account_lang) %>%
  summarise(frekuensi=n()) %>% 
  ggplot(aes(x=reorder(account_lang,frekuensi), y=frekuensi, 
             fill=account_lang))+
  geom_bar(stat="identity")+
  theme(legend.position="none")+
  coord_flip()+
  labs(x="account_lang",
       title="account language")
lang <- df_clean %>% 
  group_by(lang) %>%
  summarise(frekuensi=n()) %>% 
  ggplot(aes(x=reorder(lang,frekuensi), y=frekuensi, 
             fill=lang))+
  geom_bar(stat="identity")+
  theme(legend.position="none")+
  coord_flip()+
  labs(x="lang",
       title="tweet language")
status <- df_clean %>% 
  group_by(status) %>%
  summarise(frekuensi=n()) %>% 
  ggplot(aes(x=reorder(status,frekuensi), y=frekuensi, 
             fill=status))+
  geom_bar(stat="identity")+
  theme(legend.position="none")+
  coord_flip()+
  labs(x="status",
       title="account status")

grid.arrange(source,
             grid.arrange(account,lang, status, nrow=1),
             nrow=2)

# variabel logikal
media <- ggplot(df_clean, aes(contain_media, fill=status))+
  geom_bar(position=position_dodge())+
  theme(legend.position="none")+
  labs(title="contain media?")+
  coord_flip()
url <- ggplot(df_clean, aes(contain_url, fill=status))+
  geom_bar(position=position_dodge())+
  theme(legend.position="none")+
  labs(title="contain url?")+
  coord_flip()
coord <- ggplot(df_clean, aes(have_coordinate, fill=status))+
  geom_bar(position=position_dodge())+
  theme(legend.position="none")+
  labs(title="have coordinate?")+
  coord_flip()
url_17 <- ggplot(df_clean, aes(have_url_17, fill=status))+
  geom_bar(position=position_dodge())+
  theme(legend.position="none")+
  labs(title="have url 17?")+
  coord_flip()
url_26 <- ggplot(df_clean, aes(have_url_26, fill=status))+
  geom_bar(position=position_dodge())+
  theme(legend.position="none")+
  labs(title="have url 26?")+
  coord_flip()
quote <- ggplot(df_clean, aes(is_quote, fill=status))+
  geom_bar(position=position_dodge())+
  theme(legend.position="none")+
  labs(title="is quote?")+
  coord_flip()
mention <- ggplot(df_clean, aes(mention, fill=status))+
  geom_bar(position=position_dodge())+
  theme(legend.position="none")+
  labs(title="is mention?")+
  coord_flip()
reply <- ggplot(df_clean, aes(reply, fill=status))+
  geom_bar(position=position_dodge())+
  theme(legend.position="none")+
  labs(title="is reply?")+
  coord_flip()
banner <- ggplot(df_clean, aes(use_banner, fill=status))+
  geom_bar(position=position_dodge())+
  theme(legend.position="none")+
  labs(title="account profile use banner?")+
  coord_flip()
loc <- ggplot(df_clean, aes(use_location, fill=status))+
  geom_bar(position=position_dodge())+
  theme(legend.position="none")+
  labs(title="account profile use location?")+
  coord_flip()
verified <- ggplot(df_clean, aes(verified, fill=status))+
  geom_bar(position=position_dodge())+
  theme(legend.position="none")+
  labs(title="verified account?")+
  coord_flip()
desc <- ggplot(df_clean, aes(have_description, fill=status))+
  geom_bar(position=position_dodge())+
  theme(legend.position="none")+
  labs(title="account have description?")+
  coord_flip()

grid.arrange(media, url, coord, 
             url_17, url_26,
             quote, mention, reply,
             nrow=3)

grid.arrange(banner, verified, loc, desc, nrow=2)

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
par(mfrow=c(3,2))
plot(nb)

#Melakukan prediksi dengan data testing
pred_nb <- predict(nb, as.data.frame(test))

# validation
#Membuat Confussion Matrix Naive Bayes
confnb <- table(test$status, pred_nb)
confnb

#confusion matrix lengkap
confusionMatrix(pred_nb, test$status)
mean(pred_nb==test$status)

# CV
nb_cv <- train(df_clean[,-24],df_clean$status,
            method="nb",
            trControl = trainControl(method = "cv", number = 10))
nb_cv
plot(nb_cv)
