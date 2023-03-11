# Seinfeld text analysis using `R`

## Objectives
- **Sentiment analysis of Seinfeld scripts** - positive and negative sentiments.
- **Identify "catchpharses", common themes, and inside jokes** - word frequency and relationships.
- **Word correlation** - how are certain words related?
- **Wrangle and visualize insightful relationships**...

## Methods
<!--- maybe break down by step and give brief summary, such as data wrangling with tidytext to seperate words grouped by "x" to investigate "y" --->
### Sentiment Analysis
1. `unnest_tokens()` - *Seperate text into rows of single words*
2. `anti_join()` - *Drop uninteresting words (stop words)*
3.  `get_sentiment()` - *Evaluating 3 different lexicons:*
    - Bing
    - NRC
    - AFINN
### Character Bigrams
> **Bigrams:** Pairs of consecutive words grouped by character with counts
1. `unnest_tokens(bigram)` - *Seperate text into rows of two words*
2. `filter()` - *Remove common stop words and selected words, keep only selected show characters*
3. `group_by()` - *Group by character and get counts of bigrams*
## Citations
- [Seinfeld data](https://www.kaggle.com/datasets/thec03u5/seinfeld-chronicles)
- Mohammad, S.M. and Turney, P.D. (2013), CROWDSOURCING A WORD–EMOTION ASSOCIATION LEXICON. Computational Intelligence, 29: 436-465. [https://doi.org/10.1111/j.1467-8640.2012.00460.x](https://doi.org/10.1111/j.1467-8640.2012.00460.x)
