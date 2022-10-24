#Week 4 Lab
setwd("C:/Users/billf/OneDrive/Desktop/GEO 482/Lab")
library(tmap)
library(GISTools)
library(sf)
library(raster)
library(leaflet)

#Task 1. Mapping

install.packages('leaflet')

#vector mapping

nbr.sf = read_sf('./Neighborhoods/Neighborhoods/neighbr.shp')

tm_shape(nbr.sf) + tm_borders()
#Two ways of presenting the map the same way
tm_shape(nbr.sf)+ tm_fill(col='blue')+ tm_borders()

tm_shape(nbr.sf)+ tm_polygons()

#Playing with raster

?raster
#come back to later or see week4 notes from class

#Choropleth map

tm_shape(nbr.sf)+ tm_fill('calcacres', palette = 'BuGn')+
  tm_borders()
head(nbr.sf)

#Making a map with leaflet

zoo.df = data.frame(lon=-78.85416, lat=42.93765, label= 'Buffalo Zoo')
leaflet()%>%
  addTiles()%>%
  addMarkers(lng=zoo.df$lon, lat=zoo.df$lat, popup=zoo.df$label)

#Bonus Point Map

place.df = data.frame(lon=c(-78.7317198722998, -78.78558476292692), 
                      lat=c(42.79958088891366, 43.008747945421355),
                      label=c('My Place', 'UB North Campus'))

leaflet()%>%
  addTiles()%>%
  addMarkers(lng=place.df$lon, lat=place.df$lat, popup=place.df$label)





