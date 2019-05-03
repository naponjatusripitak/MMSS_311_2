# Useful resources
# Converting to and from tidy format: https://www.tidytextmining.com/dtm.html
# On sparsity: https://stackoverflow.com/questions/28763389/how-does-the-removesparseterms-in-r-work

# Set wd
setwd("~/Documents/GitHub/MMSS_311_2/Lab Exercises/Week 5")

# Load packages
packages <- c("dplyr", "ggplot2", "lubridate", "stringr", "foreign", "xml2", "rvest", "tm", "tidytext")

load.packages <- function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE)
    library(x, character.only = TRUE)
  }
}

lapply(packages, load.packages)

### For one season

page <- read_html("https://www.imdb.com/title/tt0944947/episodes?season=1")
page %>% html_nodes("#episodes_content strong a") %>% html_text()
page %>% html_nodes("#episodes_content strong a") %>% html_attr("href") %>% gsub(".*ep", "", .) %>% as.numeric()
page %>% html_nodes(".item_description") %>% html_text()
page %>% html_nodes(".ipl-rating-star.small .ipl-rating-star__rating") %>% html_text() %>% as.numeric()
page %>% html_nodes(".airdate") %>% html_text() %>% dmy()

### Do this in batch

get_info <- function(x){
  page <- read_html(paste0("https://www.imdb.com/title/tt0944947/episodes?season=",x))
  season <- x
  ep_title <- page %>% html_nodes("#episodes_content strong a") %>% html_text()
  ep_num <- page %>% html_nodes("#episodes_content strong a") %>% html_attr("href") %>% gsub(".*ep", "", .)
  text <- page %>% html_nodes(".item_description") %>% html_text() %>% gsub("\\n ", "", .)
  rating <- page %>% html_nodes(".ipl-rating-star.small .ipl-rating-star__rating") %>% html_text() %>% as.numeric()
  airdate <- page %>% html_nodes(".airdate") %>% html_text() %>% dmy()
  return(data.frame(season, ep_title, ep_num, text, rating, airdate, stringsAsFactors = F))
}

df <- lapply(1:7, get_info) %>% bind_rows()

### Preparing text for analysis

## Using tm
df <- df %>% mutate(doc_id = row_number()) %>% select(doc_id, text, everything())

corpus <- VCorpus(DataframeSource(df))

corpus <- corpus %>% 
  tm_map(removePunctuation) %>%
  tm_map(removeNumbers) %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removeWords, stopwords('english')) %>%
  tm_map(stemDocument) %>%
  tm_map(stripWhitespace)

dtm <- DocumentTermMatrix(corpus)
dtm <- removeSparseTerms(dtm, 0.97)


#in tidy form
tidy_dtm <- tidy(dtm)

#in matrix form
dtm.mat <- as.matrix(dtm)

### Text Analysis

# Option 1: using dtm.mat
# Word frequencies
freq <- sort(colSums(dtm.mat), decreasing=TRUE)
head(freq, 20)

# Plotting
wf <- data.frame(word=names(freq), freq=freq)

wf %>% subset(freq > 15) %>%
  ggplot(aes(x = reorder(word, -freq), y= freq)) +
  geom_bar(stat="identity") +
  theme(axis.text.x = element_text(angle=45, hjust=1)) +
  xlab("word")

# Option 2: using tidy_dtm
# Word frequencies
tidy_dtm %>% group_by(term) %>%
  summarize(freq = sum(count)) %>%
  top_n(20, freq) %>%
  arrange(desc(freq))

# Plotting
tidy_dtm %>% group_by(term) %>%
  summarize(freq = sum(count)) %>%
  top_n(20, freq) %>%
  arrange(desc(freq)) %>%
  ggplot(aes(reorder(term, -freq), freq)) +
  geom_bar(stat="identity") +
  theme(axis.text.x = element_text(angle=45, hjust=1)) +
  xlab("word")

### Preparing texts for analysis with tidy
# (Let's treat seasons instead of episodes as documents)
tidy_df <- df %>% 
  unnest_tokens(word, text) %>%
  anti_join(stop_words) %>%
  mutate(word = stemDocument(word)) %>%
  group_by(season) %>%
  count(word) %>%
  cast_dtm(season, word, n) %>%
  removeSparseTerms(0.97) %>%
  tidy()

tidy_df %>% group_by(term) %>% count()

# Calculate tf_idf
tf_idf <- tidy_df %>%
  bind_tf_idf(term, document, count)

# Plot
tf_idf %>%
  group_by(document) %>% 
  top_n(3, tf_idf) %>%
  ggplot(aes(reorder(term, tf_idf), tf_idf, fill = document)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "tf-idf") +
  facet_wrap(~document, ncol = 2, scales = "free") +
  coord_flip()