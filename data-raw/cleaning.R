library(tidyverse)
library(readxl)
library(janitor)
library(lubridate)

# HDI ---------------------------------------------------------------------

hdi_raw <- read_csv("data-raw/DATASET HDI.csv")
hdi_raw %>% 
  clean_names() %>% 
  write_csv("data-raw/hdi.csv")

# Twitter Bot -------------------------------------------------------------

twitter_bot_raw <- read_excel("data-raw/Dataset_bot.xlsx")
twitter_bot_raw %>% 
  clean_names() %>% 
  write_csv("data-raw/twitter_bot.csv")


# Lamudi ------------------------------------------------------------------

lamudi_raw <- read_csv("data-raw/Klasifikasi_Lamudi.csv")
lamudi_raw %>%
  clean_names() %>%
  mutate(harga_rumah = parse_number(harga_rumah, locale = locale(
    decimal_mark = ",", grouping_mark = "."
  ))) %>% 
  write_csv("data-raw/lamudi.csv")

# Psikologis --------------------------------------------------------------

multitimeline_raw <- read_csv("data-raw/multiTimeline.csv")
multitimeline_raw %>% 
  clean_names() %>% 
  rename_all(~str_remove_all(.x, "_jawa_barat")) %>% 
  transmute(tanggal = str_remove(minggu, "^[:alpha:]+, "),
            tanggal = mdy(tanggal),
            psikolog,
            skizofrenia,
            bipolar) %>% 
  write_csv("data-raw/psikologis.csv")

