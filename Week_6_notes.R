#Week 6 notes
setwd("/Volumes/PATRIOT/GEO482_working")

#Spatial Data in R

library(tmap)
library(sp)
library(rgeos)
library(dplyr)
library(sf)

#Two different data models, vector and raster
#We will be dealing with map projections in R
#starting w/ dataframe, then sp object

p1 = c(1,1)
p2 = c(5,1)
p3 = c(5,6)
p.df = data.frame(rbind(p1,p2,p3))
names(p.df) = c('xcoords', 'ycoords')
p.df

#convert to sp object, staying in sp for this class

p.sp = SpatialPoints(p.df[,c('xcoords','ycoords')])
class(p.sp)

tmap_options(check.and.fix = TRUE)
tm_shape(p.sp)+tm_dots()

?gWithinDistance
#used gDistance instead, more straight forward for this, does the Pythagorean theorem
gDistance(p.sp[1,],p.sp[3,])
gDistance(p.sp[1,],p.sp[2:3,], byid = T)

dist.matrix = gDistance(p.sp, p.sp, byid = T)
#creates a distance matrix between the points
#standard at 4
1*(dist.matrix<=4)
#standard at 5.5
1*(dist.matrix<=5.5)

#create a coverage matrix like in the lab
1*gWithinDistance(p.sp,p.sp, byid = T, dist = 5.5)

#in lab we started w/ the dataframe and imported it
#from there we created the sp object
#then the coverage matrix was created

#using the source() function allows you to import functions like drawSpiderDiagram
#writing functions can eliminate needing to write many codes
#functions are written like in JavaScript

#details about projections in ch 6 in Geocomputation in R

#pipe operator, found in dplyr package
x = rnorm(5)
abs.x = abs(x)
sort(abs.x)

x %>% abs %>% sort
#shortens the amount of coding needed to be done

#need pipe operator for the map projection
st_is_longlat(p.sp)
#returns NA
#need to assign coordinate system
#4326 is the number for longlat coordinate system
