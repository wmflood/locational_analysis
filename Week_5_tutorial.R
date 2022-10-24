#Week 5 R tutorial 10/1/2021
#Solving LSCP problems using lpSolveAPI
#want to minimize the number of stations needed, but need to survice everyone

library(lpSolveAPI)

#see the problem in the LSCP slides for the long version of this

n.var = 5
#step 1 crate lp obj
lp = make.lp(0,n.var)
#step 2 set up objfn
set.objfn(lp, c(1,1,1,1,1))
lp
#step 3 add constraint
add.constraint(lp,c(1,1,0,0,0), '>=', 1)
add.constraint(lp,c(1,1,0,1,0), '>=', 1)
add.constraint(lp,c(0,1,1,1,0), '>=', 1)
add.constraint(lp,c(0,0,1,1,1), '>=', 1)
add.constraint(lp,c(0,0,1,0,1), '>=', 1)
#step 4 set integer constraint
set.type(lp, 1:5, 'binary')
#step 5 solve the problem
solve(lp)
#should return 0, means it found a solution
#step 6 extract the results
get.variables(lp)
which(get.variables(lp)==1)
sum(get.variables(lp))
#which and sum are other ways to view the results letting you see which ones were selected, and how many were selected

#what if you had more than just 5 rows?
#short cuts for larger tables
#create a vector of the same values multiple times k

#short cut 1
k=30
a = rep(1,k)
#replace step 2 w/
set.objfn(lp,a)

#create a coverage matrix in R first
#short cut 2
C = matrix(c(1,1,0,0,0,
      1,1,0,1,0,
      0,1,1,1,0,
      0,0,1,1,1,
      0,0,1,0,1),
      nrow=5,ncol=5,
      byrow = T)
C
#replace step 3
add.constraint(lp,C[1,], '>=', 1)
add.constraint(lp,C[2,], '>=', 1)
add.constraint(lp,C[3,], '>=', 1)
#and so on...
#can use a for loop to do this as well, used especially for large tables
for (j in 1:5) {
  add.constraint(lp, C[j,], '>=', 1)
  
}

#assignment 1
#first part is to solve an lp problem like above

#the second part is to solve lp problem with data set provided
#need to know for part 2
#first upload the data following the steps in the assignment
#should be able to follow the steps and remember to use the for loop
#come with questions on Monday or Wednesday, and remember to use office hours
