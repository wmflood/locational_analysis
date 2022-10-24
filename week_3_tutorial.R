#Week 3 Lab
#working directory
setwd("C:/Users/billf/OneDrive/Desktop/GEO 482/Lab")

#creating dataframe
Age = c(30,36,28)
Name = c("John","Jane","Bob")
Female = c(FALSE,TRUE,FALSE)
DF = data.frame(Age,Name,Female)

#Task 1) Learning about dataframes

#finds specific data in a dataframe (indexing)
DF[1,3]
DF[,2]
#finds multiple data poitns in dataframe
DF[c(1,3),]

#can also do it this way
DF$Name
#other things you can do with this
mean(DF$Age)
table(DF$Female)

#rarely going to create own dataframe
#usually download dataframe, and import it to R

#Task 2) import CSV file into R

df = read.table(file = './BPD_Camera-Aug2017.csv', header = T, sep = ',')
head(df)
dim(df)
names(df)
#Show what kind of data is shown (int, num, etc)
str(df)

summary(df$Score)
#How would we extract the scores greater than 70?
#Subsetting the data
df$Score > 70
df[df$Score > 70,]

#Graphing in R
hist(df$Score, main = "Police Camera Score", xlab = "Score")
plot(df$X, df$Y)
boxplot(df$Score~df$Status)

#Mapping
library(GISTools)
data("georgia")
plot(georgia2, col='red')

library(sf)
library(tmap)

PC.sf = read_sf('./PoliceCamera/PoliceCamera/pcamera.shp')
neighbor.sf = read_sf('./Neighborhoods/Neighborhoods/neighbr.shp')

tm_shape(neighbor.sf)+tm_borders()+
  tm_shape(PC.sf)+tm_dots(col = 'red')
