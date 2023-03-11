# load packages
pacman::p_load(tidyverse)

# load data
lex <- read_csv("data/sentiment/04-combined-lex.csv")

# wrangle data
lex_means <- lex %>%
  group_by(lex) %>%
  summarise(mean = mean(mean_sent))

# visualize sentiment
lex %>%
  ggplot(aes(x = show_number, y = mean_sent)) +
  geom_col() +
  facet_wrap(~lex) +
  geom_hline(yintercept = 0) +
  geom_hline(data = lex_means, aes(yintercept = mean), linetype = "dashed",
             color = "red")