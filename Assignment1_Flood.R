#Assignment 1   William Flood
#Part 1.1
A = matrix(c(1,1,1,0,1,1,0,0,
             1,0,0,0,0,1,0,0,
             1,1,1,0,0,0,1,1,
             0,1,0,0,1,1,0,1,
             0,0,1,0,0,0,1,0,
             0,0,0,0,0,1,1,0,
             0,1,0,0,0,0,1,1,
             0,0,0,1,0,0,0,1,
             1,0,0,1,0,0,0,0,
             0,0,0,1,0,1,1,1),
            nrow = 10, ncol = 8, byrow = T )
n.var = 8
lp = make.lp(0,n.var)
set.objfn(lp, c(1,1,1,1,1,1,1,1))
for (j in 1:8) {
  add.constraint(lp, A[j,], '>=', 2)
}
set.type(lp, 1:8, 'binary')
solve(lp)
get.variables(lp)
which(get.variables(lp)==1)
sum(get.variables(lp))

#Part 1.2
# Column 5 would not make an optimal coverage solution because it only
# covers two zones, and the zones that it covers are covered by other candidate 
# sites better than 5.

#Part 1.3
# 6 sights would be needed to cover each location twice. Sites 1, 3, 4, 6, 7, 8.

#Part 2
dat = read.table('Mapswain.dat', skip=1, col.names = c('id','x','y','pop'))
set.seed(43578)

#Part 2.1
plot(dat$x,dat$y,cex=0.5)

#Part 2.2
#a
xy.sp = SpatialPoints(dat[,c('x','y')])
#b
coverage.mat = (gWithinDistance(xy.sp, xy.sp, byid=T, dist=10))*1
#c
lps.model = make.lp(0,55)
set.objfn(lps.model, rep(1,55))
#d
for (d in 1:55) {
  add.constraint(lps.model, coverage.mat[d,], '>=', 1)
}
#e
set.type(lps.model, 1:55, 'binary')
solve(lps.model)
#f
out = get.variables(lps.model)
which(out==1)
#g
source('drawSpiderDiagram.R')
drawSpiderDiagram(dat, c(2:3,1), out, coverage.mat)

#Bonus Code

#3.1 include site 10

xy.sp = SpatialPoints(dat[,c('x','y')])
cov.mat = (gWithinDistance(xy.sp, xy.sp, byid=T, dist=10))*1
lps.bonus = make.lp(0,55)
set.objfn(lps.bonus, rep(1,55))
add.constraint(lps.bonus, cov.mat[10,], '>=', 1)
for (d in 1:55) {
  add.constraint(lps.bonus, cov.mat[d,], '>=', 1)
}
set.type(lps.bonus, 1:55, 'binary')
solve(lps.bonus)
which(get.variables(lps.bonus) == 1)

out = get.variables(lps.bonus)
which(out==1)
source('drawSpiderDiagram.R')
drawSpiderDiagram(dat, c(2:3,1), out, cov.mat)


#3.2 exclude site 17

xy.sp = SpatialPoints(dat[,c('x','y')])
C.mat = (gWithinDistance(xy.sp, xy.sp, byid=T, dist=10))*1
lps.bonus2 = make.lp(0,55)
set.objfn(lps.bonus2, rep(1,55))
#add.constraint(lps.bonus2, , '>=', 0)
for (d in 1:55) {
  add.constraint(lps.bonus2, C.mat[d,], '>=', 1)
}
set.type(lps.bonus2, 1:55, 'binary')
solve(lps.bonus2)
which(get.variables(lps.bonus2) == 1)

out = get.variables(lps.bonus2)
which(out==1)
source('drawSpiderDiagram.R')
drawSpiderDiagram(dat, c(2:3,1), out, C.mat)