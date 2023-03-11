# load packages
pacman::p_load(dplyr,
               readr,
               stringr,
               tidytext,
               tidyverse,
               textdata)

# load data
scripts <- read_csv("data/raw-data/scripts.csv") %>%
  janitor::clean_names()

# wrangle data
scripts <- scripts %>%
  unnest_tokens(tbl = ., input = dialogue, output = word)

stp_wrds <- get_stopwords(source = "smart")

scripts_new <- anti_join(scripts, stp_wrds, by = "word")

nrc <- get_sentiments(lexicon = "nrc")

db_nrc <- inner_join(scripts_new, nrc, by = "word")

db_nrc <- count(db_nrc, x1, character, episode_no,
                 seid, season, word, sentiment)

db_nrc <- spread(key = sentiment, value = n, fill = 0, data = db_nrc)

db_nrc <- mutate(sentiment = positive - negative, .data = db_nrc)

db_nrc$character <- str_to_title(db_nrc$character)

character_filter <- c("Jerry", "Kramer", "George", "Elaine")

db_nrc <- db_nrc |>
  filter(character %in% character_filter)

# check for anomalies
word_check <- db_nrc %>%
  group_by(word) %>%
  summarise(n=n(), sent = sum(sentiment)) %>%
  arrange(desc(n))
  # anomalies:

mean_episode_sentiments <- db_nrc %>%
  group_by(seid) %>%
  summarise(mean_sent = round(mean(sentiment),2))

mean_episode_sentiments <- mean_episode_sentiments %>%
  separate(seid, c("season", "episode"), sep = 3) %>%
  mutate(show_number = row_number())

# export episode sentiments
write_csv(mean_episode_sentiments, "data/02-nrc-episode-sentiments.csv")
