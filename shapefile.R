library(maptools)
library(ggmap)
library(rgdal)
library(RColorBrewer)

colors <- brewer.pal(9, "BuGn")

#reading shapefile .shp
utm <- readOGR(file.choose())
#I need to project from utm to lon lat to see something on my map (the 
#map I will get from google is in lon lat)
#To see if shapefile is already projected, and which projection it has been used,
# str(shapefile)
utmtolat <- spTransform(utm, CRS('+proj=longlat +datum=WGS84'))
#convert shapefile to dataframe
utmtolat <- fortify(utmtolat)
#Getting map from maps.google
milan <-get_map(location = 'Milano', maptype = 'roadmap', zoom=15)
milano_map <- ggmap(milan)
milano_map
#Adding a layer with polygons representing limited traffic zones 
milano_map <- milano_map + geom_polygon(data=utmtolat, aes(x=long, y=lat, group=group),
                                        alpha=0.5, fill='darkred')
milano_map <- milano_map + labs(title='Limited traffic zones in Milan', x='Longitude', y='Latitude')
milano_map
