# load packages
pacman::p_load(dplyr,
               readr,
               stringr,
               tidytext,
               tidyverse)

# load data
scripts <- read_csv("scripts.csv") %>%
  janitor::clean_names()

# wrangle data
scripts <- scripts %>%
  unnest_tokens(tbl = ., input = dialogue, output = word)

stp_wrds <- get_stopwords(source = "smart")

scripts_new <- anti_join(scripts, stp_wrds, by = "word")

bing <- get_sentiments(lexicon = "bing")

db_bing <- inner_join(scripts_new, bing, by = "word")

db_bing <- count(db_bing, x1, character, episode_no,
                 seid, season, word, sentiment)

db_bing <- spread(key = sentiment, value = n, fill = 0, data = db_bing)

db_bing <- mutate(sentiment = positive - negative, .data = db_bing)

db_bing$character <- str_to_title(db_bing$character)

character_filter <- c("Jerry", "Kramer", "George", "Elaine")

db_bing <- db_bing |>
  filter(character %in% character_filter)

# check for anomalies
word_check <- db_bing %>%
  group_by(word) %>%
  summarise(n=n(), sent = sum(sentiment)) %>%
  arrange(desc(n))
  # anomalies:
  # funny

mean_episode_sentiments <- db_bing %>%
  group_by(seid) %>%
  summarise(mean_sent = round(mean(sentiment),2))

# export episode sentiments
write_csv(mean_episode_sentiments, "01-bing-episode-sentiments.csv")