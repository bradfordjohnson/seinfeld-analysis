# Seinfeld text analysis using `R`

## Objectives
- **Sentiment analysis of Seinfeld scripts** - positive and negative sentiments.
- **Word correlation** - how are certain words related?
- **Wrangle and visualize insightful relationships**...

## Methods
<!--- maybe break down by step and give brief summary, such as data wrangling with tidytext to seperate words grouped by "x" to investigate "y" --->
### Sentiment Analysis
1. `unnest_tokens()` - *Seperate text into rowes of single words*
2. `anti_join()` - *Drop uninteresting words (stop words)*
3.  `get_sentiment()` - *Evaluating 3 different lexicons:*
    - Bing
    - NRC
    - AFINN
## Citations
- [Seinfeld data](https://www.kaggle.com/datasets/thec03u5/seinfeld-chronicles)
- Mohammad, S.M. and Turney, P.D. (2013), CROWDSOURCING A WORD–EMOTION ASSOCIATION LEXICON. Computational Intelligence, 29: 436-465. [https://doi.org/10.1111/j.1467-8640.2012.00460.x](https://doi.org/10.1111/j.1467-8640.2012.00460.x)
