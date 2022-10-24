## Week 11 Suitability Analysis
# finding the best place to place a bank
# find areas away from other banks and a high population density

library(sf)
library(dplyr)
library(raster)
library(tmap)
library(rgdal)
library(GISTools)
library(spData)
library(spDataLarge)

#need to set criteria on a properly projected map
##Data sets:
# population density
# banks
# streets

##load the data
bank.sf = read_sf('Data/bank.shp')
streets.sf = read_sf('Data/streets.shp')
pop.ras <- raster :: raster("Data/popden/prj.adf")
pop.ras <- raster("Data/popden/prj.adf")

plot(pop.ras)

tm_shape(pop.ras) + tm_raster(palette = 'Spectral', n=7)

#re-projecting, since pop.ras has map projection we will use that data
crs.prj = crs(pop.ras)
crs.prj

bank.sf2 = bank.sf %>% st_set_crs(4326) %>% st_transform(crs.prj)
street.sf2 = streets.sf %>% st_set_crs(4326) %>% st_transform(crs.prj)

tm_shape(pop.ras)+tm_raster(n=7, palette = 'Spectral')+
  tm_shape(bank.sf2)+tm_dots(col = 'green', size = 0.5)+
  tm_shape(street.sf2)+tm_lines(col = 'black')

# calculating distance
# best way to do this is to convert the bank data into a raster
r = raster(extent(pop.ras), resolution = 30, crs = st_crs(pop.ras)$proj4string)
bank.ras = rasterize(bank.sf2,r,field = 1)

dist_bank.ras = distance(bank.ras)
plot(dist_bank.ras)

# now set up the population area that you want to locate in
high_popden.ras = (pop.ras>5000)
tm_shape(high_popden.ras)+tm_raster(style='cat')

out.ras = high_popden.ras*(dist_bank.ras>500)
tm_shape(out.ras)+tm_raster(style = 'cat')
#this identifies the potential candidate sight

tm_shape(out.ras)+tm_raster(style = 'cat')+
  tm_shape(street.sf2)+tm_lines()+
  tm_shape(bank.sf2)+tm_dots(size = 0.5, col = 'green')
