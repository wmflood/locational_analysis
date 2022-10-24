#Week 9: P-Median Problem
library(GISTools)
library(tbart)
library(tmap)
library(dplyr)

data("georgia")

tm_shape(georgia) + tm_polygons('TotPop90', palette = 'Blues', n=7)

## P Median problem using Teit-Bart Hueristics
# Solutions at p = 3, can change p values to see different results
# use 'force' in allocations function for the bonus point

sol.3 = allocations(georgia2, p=3)
names(sol.3)
#now have allocation and allocdist
#allocation shows the optimal solution when used in unique
unique(sol.3$allocation)

sel.p3 = georgia2[c(138, 88, 67),]
#Make a selection of data

tm_shape(georgia2) + tm_borders()+
  tm_shape(sel.p3) + tm_polygons('red')

map.allocation = tm_shape(sol.3) + 
  tm_polygons("allocation", style = "cat", palette="Accent")+
  tm_shape(sol.3[c(138, 88, 67),]) + tm_dots(size = 1)

map.alocdist = tm_shape(sol.3) + tm_polygons('allocdist', palette = 'Reds') +
  tm_shape(sel.p3) + tm_polygons('blue')

georgia.8 = allocations(georgia2, p=8)

#can plot this with star diagram
plot(georgia.8, border='grey')
plot(star.diagram(georgia.8), col='red', lwd=2, add=TRUE)

plot(sol.3, border='grey')
plot(star.diagram(sol.3), col='red', lwd=2, add=TRUE)

#Can also do this using tmap
tm_shape(georgia.8) + tm_polygons('allocation', style='cat', palette='Accent') +
  tm_shape(star.diagram(georgia.8)) + tm_lines()
