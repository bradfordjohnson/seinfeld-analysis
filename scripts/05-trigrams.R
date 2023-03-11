# load packages
pacman::p_load(dplyr,
               tidyr,
               tidytext)

# load data
scripts <- readr::read_csv("scripts.csv") %>%
  janitor::clean_names()

scripts %>%
  unnest_tokens(trigram, dialogue, token = "ngrams", n = 3) %>%
  filter(!is.na(trigram)) %>%
  separate(trigram, c("word1", "word2", "word3"), sep = " ") %>%
  filter(!word1 %in% stop_words$word,
         !word2 %in% stop_words$word,
         !word3 %in% stop_words$word) %>%
  count(word1, word2, word3, sort = TRUE)
