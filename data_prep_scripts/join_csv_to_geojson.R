## R Script to join variables in CSV to properties of features within GeoJSON based on a shared variable ##

## Example:
##    - Scenario:
##      A GeoJSON file has been created using our Plotter tool.
##      A CSV dataset has been created with information relating to the spatial data.
##      We want to join the dataset information to the spatial data and display it in our Explore tool.

##    - CSV:
##      featureNum, name, postcode
##      1, building1, M30 4JG
##      2, building2, M40 2WL

##    - GeoJSON:
##      {
##        "type": "Feature",
##        "properties": {
##          "featureNum": 1
##        },
##        "geometry": {
##        .
##        .

##    - RESULT:
##      {
##        "type": "Feature",
##        "properties": {
##          "featureNum": 1,
##          "name": "building1",
##          "postcode": "M30 4JG"
##        },
##        "geometry": {
##        .
##        .

# load libraries ---------------------------
library(tidyverse) ; library(sf)

# load data ---------------------------
df_csv_source <- read_csv("<NAME_OF_FILE>.csv")
sf_geojson_source <- st_read("<NAME_OF_FILE>.geojson")

# join data from CSV to GeoJSON ---------------------------
sf_joined_geojson <- left_join(sf_geojson_source, df_csv_source, by = "featureNum")

# remove unwanted variables from the GeoJSON ---------------------------
sf_geojson_output <- select(sf_joined_geojson, -featureNum, -featureAlias)

# create the new GeoJSON output ---------------------------
st_write(sf_geojson_output, "<NAME_OF_FILE>.geojson", driver = "GeoJSON")
