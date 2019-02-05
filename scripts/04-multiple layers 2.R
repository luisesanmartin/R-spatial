# Load libraries for use
library(sf)
library(ggplot2)
library(dplyr)

# Read in libraries and areas data
libraries <- st_read("https://data.cityofchicago.org/resource/psqp-6rmg.geojson")
areas <- st_read("https://data.cityofchicago.org/resource/igwz-8jzy.geojson")

# Project both
libraries <- st_transform(libraries, 32616)
areas <- st_transform(areas, 32616)

# Make a ggplot with libraries and community areas
ggplot() +
  geom_sf(data = areas) +
  geom_sf(data = libraries)
ggsave("doc/Chicago areas.png")

# Find which areas intersect with libraries and save as a variable called "intersects"
intersects <- st_intersects(areas, libraries) # Note that order matters

# Filter areas by _without_ libraries. Save as a variable called "no_lib"
no_lib <- filter(areas, lengths(intersects) == 0)

# Plot community areas without libraries
ggplot() +
  geom_sf(data = areas) +
  geom_sf(data = no_lib, fill = "red") +
  geom_sf(data = libraries)
ggsave("doc/Chicago areas without libraries.png")

# Adding columns from areas to libraries
lib_join_total <- st_join(libraries, areas) # adds all the attributes in areas to libraries
lib_join <- st_join(libraries, areas["community"]) #adds only the "community" attribute
names(areas) # in case we want to check the names of columns in areas

# Counting the number of libraries in each community area
lib_counts <- count(lib_join, community)
