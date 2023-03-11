# load packages
pacman::p_load(dplyr,
               tidyr,
               tidytext)

# load data
scripts <- readr::read_csv("scripts.csv") %>%
  janitor::clean_names()

# wrangle data
script_bigrams <- scripts %>%
  unnest_tokens(bigram, dialogue, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram))

# get counts
script_bigrams %>%
  count(bigram, sort = TRUE)

# seperate bigrams
bigrams_separated <- script_bigrams %>%
  separate(bigram, c("word1", "word2"), sep = " ")

# filter out stop words
bigrams_filtered <- bigrams_separated %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word)

bigram_counts <- bigrams_filtered %>%
  count(word1, word2, sort = TRUE)