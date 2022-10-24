## Assignment 3
#See week 11 notes for more complete descriptions

library(sf)
library(dplyr)
library(raster)
library(tmap)
library(terra)

#loading data
bank.sf = read_sf('Data/bank.shp')
streets.sf = read_sf('Data/streets.shp')
pop.ras <- raster("Data/popden")

plot(pop.ras)

tm_shape(pop.ras) + tm_raster(palette = 'Spectral', n=7)

#re-projecting
crs.prj = crs(pop.ras)
crs.prj

bank.sf2 = bank.sf %>% st_set_crs(4326) %>% st_transform(crs.prj)
street.sf2 = streets.sf %>% st_set_crs(4326) %>% st_transform(crs.prj)

tm_shape(pop.ras)+tm_raster(n=7, palette = 'Spectral')+
  tm_shape(bank.sf2)+tm_dots(col = 'green', size = 0.5)+
  tm_shape(street.sf2)+tm_lines(col = 'black')

#calculating distance
r = raster(extent(pop.ras), resolution = 30, crs = st_crs(pop.ras)$proj4string)
bank.ras = rasterize(bank.sf2,r,field = 1)

dist_bank.ras = distance(bank.ras)
plot(dist_bank.ras)

#set the population to desired size
high_popden.ras = (pop.ras>5000)
tm_shape(high_popden.ras)+tm_raster(style='cat')

out.ras = high_popden.ras*(dist_bank.ras>500)
tm_shape(out.ras)+tm_raster(style = 'cat')

#Question 1 potential candidate sight
tm_shape(out.ras)+tm_raster(style = 'cat')+
  tm_shape(street.sf2)+tm_lines()+
  tm_shape(bank.sf2)+tm_dots(size = 0.5, col = 'green')

#Question 2.1
big_bank = filter(bank.sf2, DEPOSITS94>25000000)
tm_shape(street.sf2)+tm_lines()+
  tm_shape(big_bank)+tm_dots(size = 0.5, col = 'green')

#Question 2.2
highest_popden.ras = (pop.ras>7500)
out2.ras = highest_popden.ras*(dist_bank.ras>250)
tm_shape(out2.ras)+tm_raster(style = 'cat')+
  tm_shape(street.sf2)+tm_lines()+
  tm_shape(bank.sf2)+tm_dots(size = 0.5, col = 'green')

#Question 2.3
tm_shape(out2.ras)+tm_raster(style = 'cat')+
  tm_shape(street.sf2)+tm_lines()+
  tm_shape(big_bank)+tm_dots(size = 0.3, col = 'green')

#Question 3 Bonus
bank_1 = bank.sf2[1,]
bank_1.ras = rasterize(bank_1,r,field = 1)
b.bank_1 = buffer(bank_1.ras, width = 900)
bonus = pop.ras*b.bank_1
cellStats(bonus, sum)

tm_shape(b.bank_1)+tm_raster()+
  tm_shape(street.sf2)+tm_lines()+
  tm_shape(bank.sf2)+tm_dots(size = 0.3, col = 'green')+
  tm_shape(bank_1)+tm_dots(size = 0.5, col = 'red')


