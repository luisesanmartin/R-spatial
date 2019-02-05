library(ggplot2)
library(dplyr)
library(sf)

# Import and project the 1998 ward data. Calculate the centroids of the data.
ward86 <- st_read("data/ward1986.shp")
ward86_utm <- st_transform(ward86, 32616)
centroids <- st_geometry(st_centroid(ward86_utm))

# Map the centroids using ggplot2
ggplot(centroids)
geom_sf()
geom_sf(centroids)
ggplot(centroids,aes(color=factor(class)))
plot(st_geometry(centroids))