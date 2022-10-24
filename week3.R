# R tutorial of week 3, 2021
# task 1. learning about data frame, #import, mapping
setwd('/Users/eunhye/Box Sync/Home/teaching/Courses/Rtutorials/week1_Intro2R/2021')

age <- c(10, 15, 30, 45)
age

name <- c('Bob','John','Jen','Tom');name

gender <- c(TRUE, TRUE, FALSE, TRUE)

class(gender)
class(age)
class(name)

rooster.df <- data.frame(age, gender, name)
rooster.df

rooster.df[,3]
rooster.df[,1]
rooster.df[1,]
rooster.df[c(1,3),]

rooster.df$name
mean(rooster.df$age)
table(rooster.df$gender)


##Task #2. import CSV file
df = read.table(file='./Data/BPD_Camera-Aug2017.csv', header = T, sep=',')
head(df)
dim(df)
str(df)
summary(df$Score)
names(df)

df$Score > 70
df[df$Score == 100,c(1:4)]

## Basic graphics
hist(df$Score, main='my first histogram', xlab='Scores of camera geocoding')
boxplot(df$Score~df$Status)

## mapping
library(sf)
library(tmap)

neighbor.sf <- read_sf('Data/Neighborhoods/neighbr.shp')
pc.sf <- read_sf('Data/PoliceCamera/pcamera.shp')
class(pc.sf)
tm_shape(neighbor.sf)+tm_borders()+tm_shape(pc.sf)+tm_dots(col='red')
