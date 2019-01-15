# Import shapefile into R
library(sf)
ward86 <- st_read("data/ward1986.shp")

# Projecting data
ward86_utm <- st_transform(ward86, 32616)

# Checking projection information
st_crs(ward86)
st_crs(ward86_utm)

# Challenge: prjecting Chicago data into Illinois East State plane projection
ward86_ieap <- st_transform(ward86, 3435)
st_crs(ward86_ieap)

# Using a bd projection for Chicago
ward86_alaska <- st_transform(ward86,3338)

# Plotting original data and projections
plot(ward86)
plot(ward86_utm)
plot(ward86_ieap)
plot(ward86_alaska)