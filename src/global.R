library(shiny)
library(leaflet)
library(dplyr)

## https://blogs.oracle.com/datascience/a-beginner%e2%80%99s-exploration-of-shiny-and-leaflet-for-interactive-mapping


df <- readRDS("../data/sample_data.rds")
#df <- readRDS("../data/data.rds")