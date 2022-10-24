#Week 7 Projections and Transformations
#using ch 6 from geocomputation 
#coordinate referencing system = crs
#Buffalo City Hall coordinates: 42.88659, -78.878116
library(tmap)
library(sp)
library(sf)
library(dplyr)

cityhall.df = data.frame(lon = -78.878116, lat = 42.88659)
cityhall.sf = st_as_sf(cityhall.df, coords=c('lon', 'lat'))

#using pipe operator
data.frame(long=-78.878116, latt=42.88659) %>% 
  st_as_sf(coords=c('long', 'latt'))

#finding crs
st_crs(cityhall.sf)

#Define a map projection, EPSG 4326 = WGS84
cityhall_prj.sf = st_set_crs(cityhall.sf, 4326)
st_crs(cityhall_prj.sf)$proj4string

#determine the ESPG code for Buffalo
lonlat2UTM = function(lonlat) {
  utm = (floor((lonlat[1] + 180) / 6) %% 60) + 1
  if(lonlat[2] > 0) {
    utm + 32600
  } else{
    utm + 32700
  }
}
lonlat2UTM(c(-78.87816,42.88659))

#Changing the map projection to UTM, ESPG code: 32617
cityhall2 = st_transform(cityhall_prj.sf, 32617)
st_crs(cityhall2)$proj4string

#calculating distance, need the same crs, version 1
#import data from week 3
PC.sf = read_sf('./PoliceCamera/PoliceCamera/pcamera.shp')
neighbor.sf = read_sf('./Neighborhoods/Neighborhoods/neighbr.shp')
st_crs(PC.sf)$proj4string
st_crs(neighbor.sf)$proj4string
#projected in WGS84
pc1.sf = PC.sf[1,]
#subset 1 point to calculate the distance
pc1_utm.sf = st_transform(pc1.sf, 32617)
#convert to UTM
st_distance(pc1_utm.sf, cityhall2)
#calculate distance

#Version 2
pc_utm.sf = st_transform(PC.sf, st_crs(cityhall2)$proj4string)
nbrh_utm.sf = st_transform(neighbor.sf, st_crs(cityhall2)$proj4string)

tm_shape(nbrh_utm.sf)+tm_borders()+
  tm_shape(pc_utm.sf)+tm_dots(col = 'red')+
  tm_shape(cityhall2)+tm_dots(col = 'blue', size = 3)
