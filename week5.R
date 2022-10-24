# R tutorial of week 5, 2021
## Solving LSCP in R

setwd('/Users/eunhye/Box Sync/Home/teaching/Courses/Rtutorials/2021/')

library(lpSolveAPI)

n.var = 5

# step 1. create lp object
lp = make.lp(0, n.var)

# step 2. set up objective function
set.objfn(lp, c(1,1,1,1,1))

# step 3. add constraints
add.constraint(lp, c(1,1,0,0,0), '>=', 1)
add.constraint(lp, c(1,1,0,1,0), '>=', 1)
add.constraint(lp, c(0,1,1,1,0), '>=', 1)
add.constraint(lp, c(0,0,1,1,1), '>=', 1)
add.constraint(lp, c(0,0,1,0,1), '>=', 1)
lp

# step 4. set integer constraints
set.type(lp, c(1,2,3,4,5), 'binary')

## step 5. Solve the problem
solve(lp)

## step 6. extract results
get.variables(lp)
sum(get.variables(lp) ==1)

## short cuts
# create a vector of the same values multiple times (k)
k = 30
a = rep(1, k)

# #1. replacement of step 2
k = 5
a = rep(1, k)
a
set.objfn(lp, a)

# #2. create a coverage matrix in R
C = matrix(c(1,1,0,0,0,
      1,1,0,1,0,
      0,1,1,1,0,
      0,0,1,1,1,
      0,0,1,0,1),
      nrow= 5,ncol=5,
      byrow=T)
C
# # replacement of step 3
C[3,]
add.constraint(lp, C[1,], '>=', 1)
add.constraint(lp, C[2,], '>=', 1)

# for loop
for (j in 1:5){
  add.constraint(lp, C[j,], '>=', 1)
}
