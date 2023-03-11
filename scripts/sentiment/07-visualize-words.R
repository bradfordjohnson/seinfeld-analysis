# load packages
pacman::p_load(tidyverse, ggwordcloud)

# load data
lex_words <- read_csv("data/sentiment/05-lex-words.csv")

# visualize words
# top 25 words by count for each lexicon
wordclouds <- lex_words %>%
  ggplot(aes(label = word, size = n, color = sent)) +
  geom_text_wordcloud_area() +
  scale_size_area(max_size = 26) +
  facet_wrap(~lex) +
  theme_void() +
  theme(
    strip.text = element_blank()
  )