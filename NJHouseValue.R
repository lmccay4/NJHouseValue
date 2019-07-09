library(tidycensus)
library(mapdeck)
library(tidyverse)


census_api_key("", install = TRUE)

mapDeckToken <- ""

census <- load_variables(2017, "acs5")
view(census)

#B25077_001 median house value
#B20002_001 median earnings past 12 months

housingData <- get_acs(geography = "tract", variables = "B25077_001", state = "NJ", geometry = TRUE) %>%
mutate(elevation = estimate/100)

housingData

mapdeck(token = mapDeckToken, style = 'mapbox://styles/mapbox/dark-v9', pitch = 50, zoom = 15) %>%
  add_polygon(data = housingData, 
              fill_colour = "estimate", 
              tooltip = "estimate", 
              layer = "nj_housing", 
              elevation = "elevation",
              legend = TRUE)
