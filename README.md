# Kanye West Sentiment Analysis
The purpose of this project is to lyrically analyze how Kanye West’s albums have changed over time. This project focuses on dissecting the artist’s lyrics by sentiments and examining how such sentiments have individually and holistically altered during the artist’s career; it utilizes text mining and Natural Language Processing techniques.

In this analysis, I primarily used the Genius API to access West’s lyrics, which is retrieved line-by-line along with the track title, and merged in other relevant information. The sentiment analysis was conducted using the sentiments dataset in the tidytext package; I used the afinn and nrc lexicons because they render a numerical and categorical method of measuring a word’s sentiment. The afinn score and nrc sentiment composition for each track and album were calculated then standardized for comparison. In addition, I have examined West’s most commonly used words and phrases. 

**You can read the full project [here](https://github.com/stehuang/Kanye-West-Sentiment-Analysis/blob/master/Kanye_West_Analysis.md)**



## Documents
Here are the different files used for this project:
- [Data](https://github.com/stehuang/Kanye-West-Sentiment-Analysis/tree/master/data): this folder contains the initially scrapped .csv file used for this project; every other dataset used was derived from this dataset
Kanye West Sentiment Analysis: the annotated R Markdown file that documents my entire process during this project
- [Data Processing](https://github.com/stehuang/Kanye-West-Sentiment-Analysis/blob/master/Scrap_and_Tokenize_Lyrics.R): the R code I wrote for retrieving and wrangling the data
- [Data Visualization](https://github.com/stehuang/Kanye-West-Sentiment-Analysis/tree/master/Kanye_West_Analysis_files/figure-markdown_github): the visuals used in the project

## Requirements
R Studio (updated to at least Version 1.1.453)

## Libraries:
* Spotifyr			
* geniusR			
* dplyr
* tidytext
* tidyr
* ggplot2
* radarchart
* devtools
* yarrr
* knitr
* kableExtra
* reshape
* RColorBrewer
* wordcloud
