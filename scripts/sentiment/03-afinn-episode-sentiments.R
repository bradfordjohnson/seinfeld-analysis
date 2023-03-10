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

afinn <- get_sentiments(lexicon = "afinn")

db_afinn <- inner_join(scripts_new, afinn, by = "word")

db_afinn$character <- str_to_title(db_afinn$character)

character_filter <- c("Jerry", "Kramer", "George", "Elaine")

db_afinn <- db_afinn |>
  filter(character %in% character_filter)

# check for anomalies
word_check <- db_afinn %>%
  group_by(word) %>%
  summarise(n=n(), sent = sum(value)) %>%
  arrange(desc(n))
  # anomalies:

mean_episode_sentiments <- db_afinn %>%
  group_by(seid) %>%
  summarise(mean_sent = round(mean(value),2))

mean_episode_sentiments <- mean_episode_sentiments %>%
  separate(seid, c("season", "episode"), sep = 3) %>%
  mutate(show_number = row_number(), lex = "afinn")

# export episode sentiments and words
write_csv(mean_episode_sentiments, "data/sentiment/03-afinn-episodes.csv")
write_csv(word_check, "data/sentiment/03-word-check.csv")
