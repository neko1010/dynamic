library(stringr)
library(tidyverse)


df = read.csv('../data/RouteDataCleaned.csv', stringsAsFactors = F)

##  using the separate function from  the tidyr package to separate list of crag location details for leaflet
df <- tidyr::separate(data = df, 
                      col = routes.location,
                      into = c("State", "Area", "Crag", "Wall"), 
                      sep= ",",
                      remove = F)


## Removing unwanted characters from ugly data

df$State <- stringr::str_replace_all(df$State, "[c(]", "")
df$State <- stringr::str_replace_all(df$State, "[\\]", "")
df$Area <- stringr::str_replace_all(df$Area, "[\\]", "")
df$Crag <- stringr::str_replace_all(df$Crag, "[\\]", "")
df$Wall <- stringr::str_replace_all(df$Wall, "[\\]", "")
df$Wall <- stringr::str_replace_all(df$Wall, "[)]", "")

## convert the str lat/lons to numeric 

#df$route.latitude = as.numeric(df$route.latitude)vals
#df$route.longitude = as.numeric(df$route.longitude)

## .rds helps to save processing time
saveRDS(df, "../data/data.rds")

## SUbsetting for ID

## piping a filter using tidyverse; str_detect from stringr
idaho <- df %>%
  filter(str_detect(State, "Idaho"))

## subset of data
#sample_data <- df[c(1:1000),]

sample_data <- idaho
saveRDS(sample_data, "../data/sample_data.rds")
