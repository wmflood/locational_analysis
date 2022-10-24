# R tutorial of week 6, 2021
## Spatial Data in R

setwd('/Users/eunhye/Box Sync/Home/teaching/Courses/Rtutorials/2021/')

## creating data frame
p1 = c(1,1)
p2 = c(5,1)
p3 = c(5,6)

p.df = data.frame(rbind(p1, p2, p3))
class(p.df)
p.df

names(p.df) = c('xcoords','ycoords')
p.df

library(tmap)
tm_shape(p.df)+tm_dots()

## convert data frame to spatial objects
library(sp)
library(rgeos)

p.sp = SpatialPoints(p.df[,c('xcoords','ycoords')])
class(p.sp)

tm_shape(p.sp)+tm_dots()

gDistance(p.sp[1,],p.sp[2,])
gDistance(p.sp[1,],p.sp[3,])
gDistance(p.sp[1,],p.sp[2:3,],byid=T)
dist.mat = gDistance(p.sp, p.sp, byid=T)
dist.mat

#standard=4
1*(dist.mat<=4)
#standard=5.5
1*(dist.mat<=5.5)

## create a coverage matrix
1*gWithinDistance(p.sp, p.sp, byid=T, dist=5.5)


## call an existing function to workspace
source('drawSpiderDiagram.R')
