# load packages
pacman::p_load(dplyr,
               tidyr,
               tidytext,
               stringr)

# load data
scripts <- readr::read_csv("data/raw-data/scripts.csv") %>%
  janitor::clean_names()

# wrangle data
script_bigrams <- scripts %>%
  unnest_tokens(bigram, dialogue, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram))

# get counts
script_bigrams %>%
  count(bigram, sort = TRUE)

# separate bigrams
bigrams_separated <- script_bigrams %>%
  separate(bigram, c("word1", "word2"), sep = " ")

stop_words <- stop_words %>%
  filter(word != "now")

# filter out stop words
bigrams_filtered <- bigrams_separated %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word)

# counts
bigram_counts <- bigrams_filtered %>%
  count(word1, word2, sort = TRUE)

# create custom stop words and remove
bigram_stopwords <- c("yeah", "ha", "jerry", "kramer", "george", "elaine", "ah",
                      "hey", "uh", "huh", "wait", "hu", "ho", "la", "heh")

bigram_counts <- bigram_counts %>%
  filter(!word1 %in% bigram_stopwords) %>%
  filter(!word2 %in% bigram_stopwords)

readr::write_csv(bigram_counts, "data/grams/01-bigrams.csv")
