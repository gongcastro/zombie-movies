library(here)
library(readxl)
library(dplyr)
library(stringr)
library(janitor)

# import data
df <- read_xlsx(here("data", "raw", "zombies.xlsx")) %>% 
    clean_names() %>% 
    filter(type %in% c("Film", "Series")) %>% 
    mutate_at(vars(title, author), str_replace, "/", ", ") %>% 
    mutate(type = str_replace(type, "Series", "TV Show")) %>%
    select(title, type, year, author)

write.csv(df, "zombie-movies.csv", row.names = FALSE)
