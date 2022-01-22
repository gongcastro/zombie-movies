library(here)
library(readxl)
library(dplyr)
library(tidyr)
library(lubridate)
library(stringr)
library(janitor)

# import data
df <- read_xlsx(here("data", "raw", "zombies.xlsx")) %>% 
    clean_names() %>% 
    filter(
        type %in% c("Film", "Series"),
        year <= year(Sys.Date())
        ) %>% 
    mutate(
        author = str_replace(author, "/", ", "), 
        type = str_replace(type, "Series", "TV Show")
    ) %>%
    select(title, type, year, country, author) %>% 
    arrange(-year) %>% 
    drop_na(year)
    

write.csv(df, "zombie-movies.csv", row.names = FALSE)
