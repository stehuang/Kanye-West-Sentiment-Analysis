
## Scraping lyrics from all of Kanye West's Albums


# load in libraries and packages
devtools::install_github("josiahparry/geniusR")
library(spotifyr)
library(geniusR)
library(tidytext)
library(tidyverse)
library(ggplot2)


# get access token; replace 'xxxxxxxx' with your own credentials
Sys.setenv(SPOTIFY_CLIENT_ID = 'xxxxxxxx')
Sys.setenv(SPOTIFY_CLIENT_SECRET = 'xxxxxxxx')
access_token <- get_spotify_access_token()


# Filtering out artists to get our desired one, which appears to be the first on the list
artists <- get_artists('Kanye West')
# get all albums and store in a dataframe
album_titles <- get_albums(artists$artist_uri[1])
# Removing alternative versions/titles and renaming "Graduation"
album_titles <- album_titles[-c(1,4,7),]
# album_titles[3,2] <- "Graduation"
album_titles$album_name[album_titles$album_name=="Graduation (Exclusive Edition)"] <- "Graduation"
album_titles$album_name[album_titles$album_name=="808s & Heartbreak"] <- "808s Heartbreak"
album_titles


## scrap lyrics; I created 3 for loops to speed up efficiency, as extracting lyrics from all 8 albums at once made the program much slower
# create 3 data frames. They will be converting into a tibble later
lyrics <- data.frame()
lyrics2 <- data.frame()
lyrics3 <- data.frame()

# albums: The College Dropout, Late Registration, Graduation
for(i in 1:3){
  # get lyrics, given the artist and the album
  sublyrics <- genius_album(artist = "Kanye West", album = album_titles$album_name[i])
  # create column in data frame that indicates album title
  sublyrics <- cbind(album_name = album_titles$album_name[i], sublyrics)
  # add to larger data frame
  lyrics <- rbind(lyrics,sublyrics)
}

# albums: 808s & Heartbreak, My Beautiful Dark Twisted Fantasy, Yeezus
for(i in 4:6){
  sublyrics <- genius_album(artist = "Kanye West", album = album_titles$album_name[i])
  sublyrics <- cbind(album_name = album_titles$album_name[i], sublyrics)
  lyrics2 <- rbind(lyrics2,sublyrics)
}

# albums: The Life of Pablo, ye
for(i in 7:8){
  sublyrics <- genius_album(artist = "Kanye West", album = album_titles$album_name[i])
  sublyrics <- cbind(album_name = album_titles$album_name[i], sublyrics)
  lyrics3 <- rbind(lyrics3,sublyrics)
}

# combine all three data frames and export
lyrics <- rbind(lyrics,lyrics2,lyrics3)
write.csv(lyrics,"lyrics.csv")



--------------------------------------------------

  

### Tokenizing lyrics

# load tibble library because we will use a tibble to store the lyrics
library(tibble)
# import lyrics
lyrics <- read.csv("lyrics.csv", stringsAsFactors = FALSE)
# convert to tibble
lyrics <- as_data_frame(lyrics)
# check data type to confirm the conversion
class(lyrics)


# create list of additional words to remove from the lyrics
redundant_words <- c("ey", "gotta", "wanna", "em", "la", "uh", "ah", "oh", "til", "yeah", "ya", "dem", "chorus", "verse", "ai", "hey", "theres", "gon", "bout", "som", "somethin", "ay", "ayy", "ayyy", "mhm", "cuz", "da", "lah", "ohh", "ooohh")

# convert album names to factor for organization purposes
lyrics$album_name <- as.factor(lyrics$album_name)

# reorder albums by chronological order
lyrics$album_name<- factor(lyrics$album_name, levels=c("The College Dropout", "Late Registration", "Graduation", "808s Heartbreak", "My Beautiful Dark Twisted Fantasy", "Yeezus", "The Life Of Pablo", "ye"))

# segment into singular words, remove common words and "redundant_words", and retain info on album name & track title
refined_lyrics <- lyrics %>% unnest_tokens(word,lyric) %>% filter(!word %in% redundant_words) %>% anti_join(stop_words) %>% group_by(album_name)
refined_lyrics












