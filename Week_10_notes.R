##Week 10 Spatial Join

library(dplyr)
library(sf)
library(tmap)

#must have key field in both tables in order to join
## import data
# Police Camera data
pc = read_sf('./PoliceCamera/PoliceCamera/pcamera.shp')

#Census data
census = read_sf('./CensusTracts2010/censustract10.shp')
names(census)

# crime data
crime = read.csv('Crime_incidence.csv')
head(crime)
names(crime)
crime %>% filter(year == 2020, !is.na(longitude)) -> crime20
crime20.sf = st_as_sf(crime20, coords = c('longitude', 'latitude'), crs=4326)


# load data from neighborhoods and elevation
load('./Buffalo.RData')
elev.ras

#Mapping
tm_shape(census) + tm_borders()+
  tm_shape(pc) + tm_dots(size = 0.3, col = 'green')+
  tm_shape(crime20.sf) + tm_dots(size = 0.01, col = 'red')

##reprojection of map data to utm
the.crs = st_crs(nbr.sf)$proj4string
#must spatial join in the same coord system
census.sf = st_transform(census, crs = the.crs)
pc.sf = st_transform(pc, crs = the.crs)
crime.sf = st_transform(crime20.sf, the.crs)
#map
tm_shape(nbr.sf) + tm_borders(lwd = 2)+
  tm_shape(census.sf) + tm_borders(col = 'purple')+
  tm_shape(pc.sf) + tm_dots(size = 0.3, col = 'green')+
  tm_shape(crime.sf) + tm_dots(size = 0.01, col = 'red')

##Spatial Join
# point to point join using the nearest relationship
pc.sf2 = st_join(pc.sf, crime.sf, join = st_nearest_feature)
names(pc.sf2)
pc.sf2$incident_type_primary
table(pc.sf2$incident_type_primary)

# point to area join
tm_shape(census.sf) + tm_borders()+
  tm_shape(pc.sf) + tm_dots(size = 0.03, col = 'green')

pc.sf3 = st_join(pc.sf, census.sf, join = st_within)
names(pc.sf3)
summary(pc.sf3$total_pop)

# point to field
tm_shape(elev.ras) + tm_raster()+
  tm_shape(pc.sf) + tm_dots(size = 0.03, col = 'green')

pc.sf$elevation = raster::extract(elev.ras, pc.sf)
summary(pc.sf$elevation)
