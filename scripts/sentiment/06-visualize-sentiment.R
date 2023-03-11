# load packages
pacman::p_load(tidyverse,
               tidyquant,
               ggdist,
               ggthemes)

# load data
lex <- read_csv("data/sentiment/04-combined-lex.csv")

# visualize sentiment
lex %>%
  ggplot(aes(x = lex, y = mean_sent, fill = factor(lex), color = factor(lex))) +
  geom_hline(yintercept = 0, color = "gray30", linetype = "dashed") +
  stat_halfeye(
    # adjust bandwidth
    adjust = 0.5,
    # move to the right
    justification = -0.2,
    # remove the slub interval
    .width = 0,
    point_colour = NA
  ) +
  geom_boxplot(
    width = 0.12,
    # removing outliers
    outlier.color = NA,
    alpha = 0.5
  ) +
  stat_dots(
    # ploting on left side
    side = "left",
    # adjusting position
    justification = 1.1
  ) +
  scale_fill_manual(values = c("#000000","#000000","#000000")) +
  scale_color_manual(values = c("#000000","#000000","#000000")) +
  theme_tq() +
  coord_flip() +
  geom_segment(aes(x = 0, y = 0, xend = 0, yend = .25),
               arrow = arrow(length = unit(2,"mm"), type = "closed")) +
  geom_segment(aes(x = 0, y = 0, xend = 0, yend = -.25),
               arrow = arrow(length = unit(2,"mm"), type = "closed")) +
  geom_text(
    aes(x = 0, y = .42),
    label = "More Positive",
    color = "green"
    ) +
  geom_text(
    aes(x = 0, y = -.43),
    label = "More Negative",
    color = "red"
  ) +
  theme(
    legend.position = "none",
    panel.grid = element_blank(),
    panel.border = element_blank(),
    axis.ticks = element_blank()
  )