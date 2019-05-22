## Add styling to GeoJSON features ##

# load packages ---------------------------
library(tidyverse) ; library(sf)

# read data ---------------------------
geojson <- st_read("<NAME_OF_FILE>.geojson") %>%
  # Un-comment line below to rename the variable names to make the presentation nicer in the styled GeoJSON
  # rename(<NEW NAME 1> = <OLD NAME 1>, <NEW NAME 2> = <OLD NAME 2>, ...)

# apply styles ---------------------------
geojson_styles <- geojson %>% 
  mutate(stroke = "#fc6721",    # example of setting the same value for everything.
                                # you can make conditional formatting choices based on categorical data, regular expression match etc. by uncommenting one of the examples below
         
           # example using an 'if/else' with a regular expression to find the word 'Parking' within the 'name' property
           #if_else(grepl("\\b.*?Parking", name), "#e5c494", "#fc6721"),
           
           # example using a 'case when' for categorical datasets like green spaces
           #case_when(
           # site_type == "Allotments Or Community Growing Spaces" ~ "#66c2a5",
           # site_type == "Golf Course" ~ "#fc8d62",
           # site_type == "Play Space" ~ "#8da0cb",
           # site_type == "Playing Field" ~ "#e78ac3",
           # site_type == "Public Park Or Garden" ~ "#a6d854",
           # site_type == "Religious Ground and Cemeteries" ~ "#ffd92f",
           # site_type == "Sports" ~ "#e5c494"),
           
         `stroke-width` = 3,
           `stroke-opacity` = 1,
           fill = stroke,
           `fill-opacity` = 0.8)

# write data ---------------------------
st_write(geojson_styles, "<NAME_OF_FILE>.geojson")
