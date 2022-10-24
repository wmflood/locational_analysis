# R tutorial of week 7, 2021
setwd('/Users/eunhye/Box Sync/Home/teaching/Courses/Rtutorials/2021/')

library(sf)
library(dplyr)
library(sp)
library(tmap)


cityhall.df = data.frame(long = -78.87816, latt=42.88659)
cityhall.df
cityhall.sf = st_as_sf(cityhall.df, coords=c('long','latt'))
cityhall.sf

data.frame(long = -78.87816, latt=42.88659) %>% st_as_sf(coords=c('long','latt')) -> buffalo.sf
buffalo.sf

st_crs(buffalo.sf)

# task 1. Define a map projection
buffalo_prj.sf <- st_set_crs(buffalo.sf, 4326)

st_crs(buffalo_prj.sf)$proj4string

# task 2. reproject the map
# task 2.1 determine UTM ESPG code for Buffalo
lonlat2UTM = function(lonlat) {
  utm = (floor((lonlat[1] + 180) / 6) %% 60) + 1
  if(lonlat[2] > 0) {
    utm + 32600
  } else{
    utm + 32700
  }
}
lonlat2UTM(c(-78.87816,42.88659))

# task 2.2 convert from geographic coordinate system to UTM 
buffalo_utm.sf = st_transform(buffalo_prj.sf, 32617)

st_crs(buffalo_utm.sf)$proj4string

## task 3. calculating distance
st_distance(buffalo_utm.sf, buffalo_prj.sf)

# task 3.1. import other data
neighbor.sf <- read_sf('Data/Neighborhoods/neighbr.shp')
pc.sf <- read_sf('Data/PoliceCamera/pcamera.shp')

# class(pc.sf)
tm_shape(neighbor.sf)+tm_borders()+tm_shape(pc.sf[1,])+tm_dots(col='red')

st_crs(buffalo_prj.sf)$proj4string
st_crs(buffalo_utm.sf)$proj4string
st_crs(pc.sf)$proj4string

pc1.sf <- pc.sf[1,]

## problem: mismatch map projections
st_distance(buffalo_utm.sf, pc1.sf)

# version #1. reproject pc data (1 point)
pc1_utm.sf = st_transform(pc1.sf, 32617)
st_distance(buffalo_utm.sf, pc1_utm.sf)

# version #2. reproject pc data 
pc_utm.sf = st_transform(pc.sf, st_crs(buffalo_utm.sf)$proj4string)
neighbor_utm.sf = st_transform(neighbor.sf, st_crs(buffalo_utm.sf)$proj4string)

tm_shape(neighbor_utm.sf)+tm_borders()+
  tm_shape(pc_utm.sf)+tm_dots(col='red')+
  tm_shape(buffalo_utm.sf)+tm_dots(col='blue',size=3)
