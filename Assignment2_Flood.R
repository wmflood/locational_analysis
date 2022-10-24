##Assignment 2  William Flood GEO482

#Question 1
setwd("/Volumes/PATRIOT/GEO482_working")
library(GISTools)
library(tbart)
library(tmap)
library(dplyr)
load('EN.RData')
set.seed(12345)


#Question 2
POP.map = tm_shape(en.county) + tm_polygons('pop.den', palette = 'Blues', n=7)
PM25mean.map = tm_shape(en.county) + 
  tm_polygons('pm25.mean', palette = 'Reds', n=7)
PM25std.map = tm_shape(en.county) + 
  tm_polygons('pm25.std', palette = 'Reds', n=7)
tmap_arrange(POP.map, PM25mean.map, nrow = 1)
tmap_arrange(POP.map, PM25std.map, nrow = 1)
tmap_arrange(PM25mean.map, PM25std.map, nrow = 1)

#Question 3
sol.3=allocations(en.county, p=3, verbose = T)
sol.4=allocations(en.county, p=4, verbose = T)
sol.5=allocations(en.county, p=5, verbose = T)
sol.6=allocations(en.county, p=6, verbose = T)
sol.7=allocations(en.county, p=7, verbose = T)
sol.8=allocations(en.county, p=8, verbose = T)
sol.9=allocations(en.county, p=9, verbose = T)
sol.10=allocations(en.county, p=10, verbose = T)
sol.11=allocations(en.county, p=11, verbose = T)
sol.12=allocations(en.county, p=12, verbose = T)
sol.13=allocations(en.county, p=13, verbose = T)
sol.14=allocations(en.county, p=14, verbose = T)
sol.15=allocations(en.county, p=15, verbose = T)

y_coord = c(sol.3$allocdist, sol.4$allocdist, sol.5$allocdist, sol.6$allocdist,
            sol.7$allocdist, sol.8$allocdist, sol.9$allocdist, sol.10$allocdist)

x_coord = c(sol.3$allocation, sol.4$allocation, sol.5$allocation, sol.6$allocation,
            sol.7$allocation, sol.8$allocation, sol.9$allocation, sol.10$allocation)

plot(sol.6$allocation, sol.6$allocdist)

unique(sol.3$allocation)
unique(sol.4$allocation)
unique(sol.5$allocation)
unique(sol.6$allocation)
unique(sol.7$allocation)
unique(sol.8$allocation)
unique(sol.9$allocation)
unique(sol.10$allocation)


unique(sol.6$allocation)
sel.p6 = en.county[c(14,49,292, 167, 159, 183),]

tm_shape(sol.6) + tm_polygons("allocation", style = "cat", palette="Accent")+
  tm_shape(sel.p6) + tm_dots(size = 1)

tm_shape(sol.6) + tm_polygons('allocation', style='cat', palette='Accent') +
  tm_shape(star.6) + tm_lines()

star.6 = plot(sol.6, border = 'grey')+
  plot(star.diagram(sol.6), col='red', lwd=2, add=TRUE)

#Question 4
sol.5=allocations(en.county, p=5, verbose = T)
unique(sol.5$allocation)

sol5.force = allocations(en.county, p=5, force = c(1, 100), verbose = T)
unique(sol5.force$allocation)

sol5.plot = plot(sol.5, border = 'grey')+
  plot(star.diagram(sol.5), col = 'red', lwd=2, add=TRUE)

force.plot = plot(sol5.force, border = 'grey')+
  plot(star.diagram(sol5.force), col = 'red', lwd=2, add=TRUE)

sel.5 = en.county[c(18,49,227,262,149),]
county_minus = en.county - sel.5

sel5.allo = allocations(county_minus, p=5, verbose = T)
unique(sel5.allo$allocation)

#Question 5
D = euc.dists(en.county)
W = replicate(297, en.county$pop.den)
WD = W*D

Wsol.5 = allocations(en.county, p=5, metric = WD, verbose = TRUE)
a.crs = st_crs(Wsol.5)

tm_shape(Wsol.5)+tm_polygons("allocation", style = "cat", palette="Accent")+
  tm_shape(en.county[c(226,9,156,73,281),])+tm_dots(col = 'red', size = 1)

plot(Wsol.5, borders = 'grey')
plot(star.diagram(Wsol.5), col='red', lwd=0.05, add=TRUE)

unique(Wsol.5$allocation)
