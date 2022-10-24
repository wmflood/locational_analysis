## GEO 482 Week 2 Lab

setwd("C:/Users/billf/OneDrive/Desktop/GEO 482/Lab")
getwd()

## R Tutorial week 2 fall 2021

## Task 1) set working directory
## Task 2) creating variables

x = 2
rm(x)
## removes the variable that you set
x = 2
x.multiple = c(2,3,4,5,6,7)
x.multiple*x
y = c("John", "Susan", "Tim")

## Task 3) Vector operation

y2 = c(y , "Laura")
y2[1]
## extracts a value from the variable
y2[c(3,1)]
## etc
(x*3)+4
sum(x.multiple)
a = c(200, 1, -5, -3)
sum(a)
mean(a)
median(a)
max(a)
## vector is a simple data type, can't mix types
b = c(2, 3, "John")
## the numbers are now treated as characters
## can convert them to numbers
as.numeric(b[1])
as.numeric(b[1]) + 2
4:50
## generates numbers between the two points

a < 0
## will show logical answer of true or false for each value

i = a < 0
a[i]
a[a<0]
## will show the value of a < 0

## replacing and adding elements
x.multiple[2] = 8 #replaces
x.multiple = c(x.multiple, 9) #adds

length(x.multiple)
## shows how many elements a variable has

## Matrix

A = matrix(1:9, nrow = 3, ncol = 3)
A
B = matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)
B

A+B #sum the matrix

A[2,1] #find a specific point

A[3,] #shows a row

## next time data frame
