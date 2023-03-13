# load packages
pacman::p_load(tidyverse,
               igraph)

# load data
bigrams <- read_csv("data/grams/01-bigrams.csv")

bigram_graph <- bigrams %>%
  filter(n > 20) %>%
  graph_from_data_frame()
