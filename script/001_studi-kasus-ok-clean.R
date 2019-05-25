library(tidyverse)
library(janitor)
library(ggpubr)
library(gridExtra)

## import data

daftar_file <- list.files(path="./data-raw", pattern="001", full.names=TRUE)
daftar_file

df <- map_dfc(daftar_file, read_csv)
df

## data preprocessing
df_clean <- df %>% select(hari_promosi, contains("jumlah"))
df_clean
str(df_clean)
class(df_clean)

## visualisasi data
theme_set(theme_pubclean())
pengguna <- ggplot(df_clean, aes(hari_promosi, jumlah_pengguna))+
  geom_line(color="#00AFBB")+
  geom_smooth(method="lm")+
  labs(title="Grafik Jumlah Pengguna Promosi", 
       x="hari promosi", y="jumlah pengguna")
komplain <- ggplot(df_clean, aes(hari_promosi, jumlah_komplain))+
  geom_line(color="#E7B800")+
  geom_smooth(method="lm")+
  labs(title="Grafik Jumlah Komplain Pengguna Hari Promosi", 
       x="hari promosi", y="jumlah komplain")
keuntungan <- ggplot(df_clean, aes(hari_promosi, jumlah_keuntungan))+
  geom_line(color="#FC4E07")+
  geom_smooth(method="lm")+
  labs(title="Grafik Jumlah Keuntungan Hari Promosi", 
       x="hari promosi", y="jumlah keuntungan")

grid.arrange(pengguna, komplain, keuntungan, nrow=2)

ggplot(df_clean, aes(hari_promosi, jumlah_komplain))+
  geom_line(color="#E7B800")+
  geom_smooth(method="lm")+
  scale_y_log10()+
  labs(title="Grafik Jumlah Komplain Pengguna Hari Promosi", 
       x="hari promosi", y="log10 jumlah komplain")

par(mfrow=c(2,2))
# model pengguna
mod_pengguna <- lm(jumlah_pengguna~hari_promosi, data=df_clean)
summary(mod_pengguna)
plot(mod_pengguna)
predict(mod_pengguna, newdata=data.frame(hari_promosi=c(130,150,200)), 
        interval="confidence")

# model komplain
mod_komplain <- lm(log10(jumlah_komplain)~hari_promosi, data=df_clean)
summary(mod_komplain)
plot(mod_komplain)
predict(mod_komplain, newdata=data.frame(hari_promosi=c(130,150,200)), 
        interval="confidence")^10

# model keuntungan
mod_keuntungan <- lm(jumlah_keuntungan~poly(hari_promosi,2), data=df_clean)
summary(mod_keuntungan)
plot(mod_keuntungan)
predict(mod_keuntungan, newdata=data.frame(hari_promosi=c(130,150,200)), 
        interval="confidence")
