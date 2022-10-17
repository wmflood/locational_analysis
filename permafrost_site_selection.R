##Project GEO 482 Spring 2021
#Permafrost Monitoring Station Selection

library(sf)
library(dplyr)
library(raster)
library(tmap)
library(rgdal)
library(lpSolveAPI)
library(tbart)
library(stars)
library(inlmisc)
library(nlrx)

soil.sf = read_sf('soil_clip.shp')
LandCover.ras = raster('LC_clip.tif')

#selecting features
soil_filter.sf = filter(soil.sf, Key==1)
LC_grass.ras = (LandCover.ras==71)
LC_wetlands.ras = (LandCover.ras==90)
LC_select.ras = (LC_grass.ras+LC_wetlands.ras)

#converting to raster
r = raster(extent(LandCover.ras), resolution = res(LandCover.ras), 
           crs = st_crs(LandCover.ras)$proj4string)
soil.ras = rasterize(soil_filter.sf, r, field = 1)

#suitability analysis
SA.ras = soil.ras*LC_select.ras

tm_shape(SA.ras)+tm_raster(style = 'cat')

#Need to convert to sp in order to run analysis
#then can run p-median problem

writeRaster(SA.ras, filename = file.path("D:/GEO482_Project", "SA.tif"),
            format = "GTiff", overwrite = TRUE)

SA.sp = Grid2Polygons(SA.ras)

SA.sp2 = as(SA.ras, 'SpatialPolygonsDataFrame')

SA.sf = st_as_sf(SA.sp2)

SA_point = read_sf('SA_point.shp')
SA_point.sp = as_Spatial(SA_point)

sol.3 = allocations(SA_point.sp, p=3)

unique(sol.3$allocation)

sel.3 = SA_point[c(19,12,40),]

tm_shape(SA.ras)+tm_raster(style = 'cat')+
  tm_shape(sel.3)+tm_dots(size = 0.3, col = 'blue')

#sensitivity analysis weighted curve

sol.1 = allocations(SA_point.sp, p=1)
sol.2 = allocations(SA_point.sp, p=2)
sol.4 = allocations(SA_point.sp, p=4)
sol.5 = allocations(SA_point.sp, p=5)
sol.6 = allocations(SA_point.sp, p=6)
sol.7 = allocations(SA_point.sp, p=7)
sol.8 = allocations(SA_point.sp, p=8)
sol.9 = allocations(SA_point.sp, p=9)
sol.10 = allocations(SA_point.sp, p=10)

sum.1 = mean(sol.1$allocdist)
sum.2 = mean(sol.2$allocdist)
sum.3 = mean(sol.3$allocdist)
sum.4 = mean(sol.4$allocdist)
sum.5 = mean(sol.5$allocdist)
sum.6 = mean(sol.6$allocdist)
sum.7 = mean(sol.7$allocdist)
sum.8 = mean(sol.8$allocdist)
sum.9 = mean(sol.9$allocdist)
sum.10 = mean(sol.10$allocdist)
mean.dist = c(sum.1, sum.2, sum.3, sum.4, sum.5, sum.6, sum.7, sum.8, sum.9, sum.10)
plot(1:10, mean.dist)

##Running the analysis with p = 6
unique(sol.6$allocation)
sel.6 = SA_point.sp[c(3,12,20,54,33,29),]

tm_shape(SA.ras)+tm_raster(style = 'cat')+
  tm_shape(sel.6)+tm_dots(size = 0.05, col = 'blue')
