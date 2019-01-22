# Importing 1986 ward data and priject the correct UTM projection
library(sf)
library(dplyr)
ward86 <- st_read("data/ward1986.shp")
ward86_utm <- st_transform(ward_86, 32616) # 32616: code for UTM zone 16N (Chicago)

# Plotting
plot(ward86)
plot(ward86_utm)
plot(st_geometry(ward86)) # Plotting without colors

# Getting centroids
centroids <- st_centroid(ward86_utm)
plot(st_geometry(centroids), cex = 0.5) # Plot, cex controls size of centroid dots
plot(st_geometry(ward86_utm), add = TRUE) # Plot, add = T keeps the last plot too
# the issue with this plot is that it keeps the "plot boundaries" from the first
# plot, cutting some lines of the wards polygons. To keep the whole polygons in
# the plot, we'd need to plot the wards first, and then the ceontroids
plot(st_geometry(ward86_utm))
plot(st_geometry(centroids), cex = 0.2, add = TRUE)

# Finding the boundaries of a layer
centroids_bbox <- st_bbox(centroids) # Contains the boundaries of the centroids
ward_bbox <- st_bbox(ward86_utm) # Contains the boundaries of the wards

# Subsetting wards
# Notice that we use the dplyr package for this
ward1 <- filter(ward86_utm, WARDNO == "01")
centroid1 <- filter(st_centroid(ward86_utm), WARDNO == "01")

# Setting a "buffer" zone
st_crs(centroids) # Checking projection
buffers <- st_buffer(centroids, 1000)

# Plotting
plot(st_geometry(ward86_utm))
plot(st_geometry(centroids), add = T, cex = 0.1)
plot(st_geometry(buffers), add = T)
# We can also add colors by using the option "col = "yellow""