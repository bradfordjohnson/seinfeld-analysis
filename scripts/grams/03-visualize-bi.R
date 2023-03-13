# load packages
pacman::p_load(tidyverse,
               igraph,
               ggraph,
               showtext,
               htmltools)

showtext_auto()
# load data
bigrams <- read_csv("data/grams/01-bigrams.csv")

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

# wrangle data
bigram_graph <- bigrams %>%
  filter(n > 10) %>%
  graph_from_data_frame()

set.seed(2017)

ggraph(bigram_graph, layout = "fr") +
  geom_edge_link() +
  geom_node_point() +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)


set.seed(205)

a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

ggraph(bigram_graph, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n), show.legend = TRUE,
                 arrow = a, end_cap = circle(.07, 'inches'), color = "#FFB462") +
  geom_node_point(color = "#A1566E", size = 4) +
  geom_node_text(aes(label = name), color = "#82889B", vjust = 1, hjust = 1,
                 family = font1) +
  theme_void() +
  labs(title = "Seinfeld Bigrams",
       subtitle = "<span style='font-family:Ubuntu;'><span style='color:#FFB462'><b>Bigram</b></span> | <span style='color:#A1566E'>a pair of consecutive written units such as words.</span></span>",
       caption = caption) +
  theme(
    plot.background = element_rect(fill = "#1F2133",
                                   colour = "#1F2133"),
    panel.background = element_rect(fill = "#1F2133",
                                    colour = "#1F2133"),
    plot.title = element_text(color = "#82889B", family = font2, size = 58,
                              margin = margin(0,0,4,0,"mm")),
    plot.subtitle = ggtext::element_textbox_simple(color = "#82889B",
                                                   margin = margin(2,0,6,0,"mm"),
                                                   size = 15),
    plot.margin = unit(c(4,4,4,4),"mm"),
    plot.caption = ggtext::element_textbox_simple(color="#82889B", size = 15, margin = margin(0,2,0,0,"mm")),
    legend.position = c(.90,.05),
    legend.text = element_text(family = font1, color = "#82889B", size = 12),
    legend.title = element_text(family = font1, color = "#83889B", size = 12,
                                margin = margin(0,0,4,0,"mm")),
    legend.direction = "horizontal"
    )
