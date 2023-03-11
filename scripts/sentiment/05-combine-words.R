# load data
pacman::p_load(dplyr)

# load data
bing <- readr::read_csv("data/sentiment/01-word-check.csv")
nrc <- readr::read_csv("data/sentiment/02-word-check.csv")
afinn <- readr::read_csv("data/sentiment/03-word-check.csv")

# wrangle data
bing <- bing %>%
  mutate(lex = "bing") %>%
  arrange(desc(n), desc(sent)) %>%
  head(25)

nrc <- nrc %>%
  mutate(lex = "nrc") %>%
  arrange(desc(n), desc(sent)) %>%
  head(25)

afinn <- afinn %>%
  mutate(lex = "affin") %>%
  arrange(desc(n), desc(sent)) %>%
  head(25)

lex_words <- bind_rows(bing, nrc, afinn)

lex_words 

write_csv(lex_words, "data/sentiment/05-lex-words.csv")
