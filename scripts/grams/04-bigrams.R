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

# filter out stop words
bigrams_filtered <- bigrams_separated %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word)


character_filter <- c("Jerry", "Kramer", "George", "Elaine")

bigrams_filtered$character <- str_to_title(bigrams_filtered$character)

# filter for main 4 and group by characters
bigram_counts <- bigrams_filtered %>%
  group_by(character) %>%
  filter(character %in% character_filter) %>%
  count(word1, word2, sort = TRUE)

# create custom stop words and remove
bigram_stopwords <- c("yeah", "ha", "george", "jerry", "elaine", "kramer",
                      "hey", "uh", "huh", "wait", "hu", "ho", "la")

bigram_counts <- bigram_counts %>%
  filter(!word1 %in% bigram_stopwords) %>%
  filter(!word2 %in% bigram_stopwords)

readr::write_csv(bigram_counts, "data/grams/04-character-bigrams.csv")
