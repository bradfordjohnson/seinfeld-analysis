# load packages
pacman::p_load(dplyr)

# load data
bing <- readr::read_csv("data/sentiment/01-bing-episodes.csv")
nrc <- readr::read_csv("data/sentiment/02-nrc-episodes.csv")
afinn <- readr::read_csv("data/sentiment/03-afinn-episodes.csv")

# bind data frames
lex <- bind_rows(bing, nrc, afinn)

readr::write_csv(lex, "data/sentiment/04-combined-lex.csv")
