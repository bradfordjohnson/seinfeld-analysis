# load packages
pacman::p_load(tidyverse,
               tidyquant,
               ggdist,
               ggthemes,
               ggtext)

# load data
lex <- read_csv("data/sentiment/04-combined-lex.csv")

# fix case
lex <- lex %>%
  mutate(lex = case_when(
    lex == "nrc" ~ "NRC",
    lex == "bing" ~ "Bing",
    lex == "afinn" ~ "AFINN"
  ))

# visualize sentiment
lex %>%
  ggplot(
    aes(x = lex,
        y = mean_sent,
        fill = factor(lex),
        color = factor(lex))
    ) +
  geom_hline(
    yintercept = 0,
    color = "#82889B",
    linetype = "dashed"
    ) +
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
  scale_fill_manual(
    values = c(
      "#A1566E",
      "#DF7C6C",
      "#FFB462"
      )
    ) +
  scale_color_manual(
    values = c(
      "#A1566E",
      "#DF7C6C",
      "#FFB462"
      )
    ) +
  scale_y_continuous(
    limits = c(-1.5,1.5)
    ) +
  theme_tq() +
  coord_flip() +
  geom_text(
    aes(x = .01, y = 1),
    label = "Positive",
    color = "#82889B"
    ) +
  geom_text(
    aes(x = .01, y = -1),
    label = "Negative",
    color = "#82889B"
    ) +
  geom_text(
    aes(x = 1, y = -1),
    label = "AFINN",
    color = "#A1566E"
  ) +
  geom_text(
    aes(x = 2, y = -1),
    label = "Bing",
    color = "#DF7C6C"
  ) +
  geom_text(
    aes(x = 3, y = -1),
    label = "NRC",
    color = "#FFB462"
  ) +
  geom_curve(
    aes(
      x = 2, y = .7, xend = 1.87, yend = .49
      ),
    arrow = arrow(length = unit(2,"mm"),
      type = "closed"
      ),
    color = "#82889B",
    curvature = -.5
    ) +
  geom_text(
    aes(x = 2.15, y = .82),
    label = "Single Episode",
    color = "#82889B"
    ) +
  labs(
    y = "Sentiment",
    title = "  
Seinfeld Script Analysis
       ",
    subtitle = "<span style='color:#82889B'>Seinfeld had 180 episodes during the  
    9 seasons it aired on TV. Featuring  
    over 54,000 lines of text in the script.
    ",
  )+
  theme(
    legend.position = "none",
    panel.grid = element_blank(),
    panel.border = element_blank(),
    axis.ticks = element_blank(),
    plot.background = element_rect(fill = "#1F2133",
                                   colour = "#1F2133"),
    panel.background = element_rect(fill = "#1F2133",
                                    colour = "#1F2133"),
    axis.text.y = element_blank(),
    axis.text.x = element_text(color = "#82889B"),
    axis.title.y = element_blank(),
    axis.title.x = element_text(color = "#82889B"),
    axis.line.x = element_line(colour = "#82889B",
                               arrow = arrow(
                                 length = unit(2,"mm"),
                                 type = "closed",
                                 ends = "both"
                                 )
                               ),
    plot.title = element_text(color = "#82889B"),
    plot.subtitle = element_markdown(hjust = 0, size = 9, lineheight = 1)
)

