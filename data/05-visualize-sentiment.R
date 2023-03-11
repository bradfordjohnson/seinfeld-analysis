# load packages
pacman::p_load(dplyr,
               stringr,
               tidytext,
               tidyverse)

# load data
bing <- readr::read_csv("data/01-bing-episode-sentiments.csv")
