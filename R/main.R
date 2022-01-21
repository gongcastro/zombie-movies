library(here)
library(readxl)
library(dplyr)
library(tidyr)
library(stringr)
library(janitor)

# import data
df <- read_xlsx(here("data", "raw", "zombies.xlsx")) %>% 
    clean_names() %>% 
    filter(type %in% c("Film", "Series")) %>% 
    mutate(
        author = str_replace(author, "/", ", "), 
        type = str_replace(type, "Series", "TV Show")
    ) %>%
    select(title, type, year, author) %>% 
    arrange(-year) %>% 
    drop_na()
    

write.csv(df, "zombie-movies.csv", row.names = FALSE)
