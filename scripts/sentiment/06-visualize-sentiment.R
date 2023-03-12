# load packages
pacman::p_load(tidyverse,
               tidyquant,
               ggdist,
               ggthemes,
               ggtext,
               showtext,
               htmltools)

showtext_auto()
# load data
lex <- read_csv("data/sentiment/04-combined-lex.csv")

# fix case
lex <- lex %>%
  mutate(lex = case_when(
    lex == "nrc" ~ "NRC",
    lex == "bing" ~ "Bing",
    lex == "afinn" ~ "AFINN"
  ))

# load fonts
font_add(family = "fb",
         regular = "data/fonts/Font Awesome 6 Brands-Regular-400.otf")

font_add_google(name = "Hind", family = "Hind")
font1 <- "Hind"

font_add_google(name = "Average", family = "Average")
font2 <- "Average"

font_add_google(name = "Dosis", family = "Dosis")

font_add_google(name = "Ubuntu", family = "Ubuntu")

# load caption
caption = paste0("<span style='font-family:fb;'>&#xf09b;</span>",
                 "<span style='font-family:sans;color:#1F2133;'>.</span>",
                 "<span style='font-family:Dosis;'>bradfordjohnson</span>")

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
    aes(x = .05, y = 1),
    label = "Positive",
    color = "#82889B",
    family = font1,
    size = 4
    ) +
  geom_text(
    aes(x = .05, y = -1),
    label = "Negative",
    color = "#82889B",
    family = font1,
    size = 4
    ) +
  geom_text(
    aes(x = 1, y = -.73),
    label = "AFINN",
    color = "#A1566E",
    family = font1
  ) +
  geom_text(
    aes(x = 2, y = -.62),
    label = "Bing",
    color = "#DF7C6C",
    family = font1
  ) +
  geom_text(
    aes(x = 3, y = -.3),
    label = "NRC",
    color = "#FFB462",
    family = font1
  ) +
  labs(
    y = "Sentiment",
    title = "Seinfeld: Not just a show about nothing",
    subtitle = "<span style='font-family:Ubuntu;'>Seinfeld had 180 episodes during the 9 seasons it aired on TV, featuring over 54,000 lines of text in the  
    scripts. The script sentiments of Jerry, George, Kramer and Elaine are visualized as an average for each  
    episode. Each dot on the raincloud plot represents an episode and the relative average sentiment.  
    <br>
    Three lexicon dictionaries were used to identify the sentiment, shown by different colored features.  
    The <span style='color:#FFB462'>NRC lexicon</span> shows an overall <span style='color:#FFB462'>positive sentiment</span> for Seinfeld episodes, while the <span style='color:#DF7C6C'>Bing lexicon</span>  
    shows epidodes are <span style='color:#DF7C6C'>more negative</span>. Using the <span style='color:#A1566E'>AFINN lexicon</span> the sentiment is shown as <span style='color:#A1566E'>more  
    positive</span>.</span>
    ",
    caption = caption
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
    axis.text.x = element_text(color = "#82889B", family = font1, size = 12),
    axis.title.y = element_blank(),
    axis.title.x = element_text(color = "#82889B", family = font1),
    axis.line.x = element_line(colour = "#82889B",
                               arrow = arrow(
                                 length = unit(2,"mm"),
                                 type = "closed",
                                 ends = "both"
                                 )
                               ),
    plot.title = element_text(color = "#82889B", family = font2, size = 58,
                              margin = margin(0,0,4,0,"mm")),
    plot.subtitle = ggtext::element_textbox_simple(color = "#82889B",
                                                   lineheight = 1,
                                                   size = 20,
                                                   margin = margin(2,0,6,0,"mm")),
    plot.caption = ggtext::element_textbox_simple(color="#82889B", size = 15, margin = margin(0,2,0,0,"mm")),
    plot.margin = unit(c(5,5,5,5),"mm"))

#ggsave("seinfeld-sentiment.png", dpi = 300)
