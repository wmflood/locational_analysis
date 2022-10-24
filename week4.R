# R tutorial of week 4, 2021

library(tmap)
library(raster)
library(sf)

# task 1. learning about mapping (load, boundary, choroplethe map, point map using leaflet)
setwd('/Users/eunhye/Box Sync/Home/teaching/Courses/Rtutorials/2021/')

load('Data/Buffalo.RData')

class(nbr.sf)
class(elev.ras)

## mapping vector data
tm_shape(nbr.sf) + tm_borders()
head(nbr.sf)

tm_shape(nbr.sf) + tm_fill() + tm_borders(col='blue')

map.nbr <- tm_shape(nbr.sf) + tm_polygons(col='green')

## mapping raster data
map.elevation <- tm_shape(elev.ras) + tm_raster() + 
  tm_shape(nbr.sf) + tm_borders(col='brown')

map.elevation
map.nbr

# Put the two maps side by side
map.out <- tmap_arrange(map.nbr, map.elevation)
# save the canvas to the physical files
tmap_save(map.out, filename = 'map.jpg')

## choropleth map
head(nbr.sf)

tm_shape(nbr.sf) + tm_fill('calcacres', palette='PuRd',n=7) +
  tm_shape(nbr.sf) + tm_borders()

tm_shape(nbr.sf) + tm_polygons(col='nbhdname')


## making leaflet map
library(leaflet)

zoo.df = data.frame(lon=-78.85416, lat=42.93765, label='How fun at  buffalo Zoo !!')
zoo.df

place.df = data.frame(lon=c(-78.85416,-79.85416),
                      lat=c(42.93765,42.93765), 
                      label=c('Zoo !!','my home'))

leaflet() %>% 
  addTiles() %>% 
  addMarkers(lng = zoo.df$lon, lat=zoo.df$lat, popup = zoo.df$label)

leaflet() %>% 
  addTiles() %>% 
  addMarkers(lng = place.df$lon, lat=place.df$lat, popup = place.df$label)
