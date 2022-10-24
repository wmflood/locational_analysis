# R tutorial of week 8, 2021
setwd('/Users/eunhye/Box Sync/Home/teaching/Courses/Rtutorials/2021/')

library(dplyr)
library(sf)
library(tmap)

crime.df = read.csv('Data/Crime_incidence.csv')
head(crime.df)

class(crime.df$incident_datetime)

library(lubridate)
out = mdy_hms(crime.df$incident_datetime)
crime.df$date <- mdy_hms(crime.df$incident_datetime)
crime.df$year = year(crime.df$date)
crime.df$month = month(crime.df$date)

head(crime.df)
year(crime.df$date)
month(crime.df$date)

crime20.df <- crime.df %>% filter(year == 2020)

crime20_sep.df = crime20.df[crime20.df$month == '9',]
crime20.df %>% filter(month == 9) -> crime20_sep2.df
crime20.df %>% filter(month == 8) -> crime20_aug.df

dim(crime20_sep.df)
dim(crime20_sep2.df)
nrow(crime20_sep.df)
nrow(crime20_aug.df)

load('Data/Buffalo.RData')


## how many cases occurred per month in 2020?
# a longer version
aggregate(parent_incident_type~month, data=crime20.df, FUN=length)

## a short way
names(crime20.df)
head(crime20.df)
crime20.df %>% group_by(month) %>% summarize(ncases =n()) -> crime20_monthly.df

head(crime20_monthly.df)

## create a new data frame  that has both 'neighborhood' and 'ncases' of crime of 2020
crime20.df %>% 
  group_by(neighborhood) %>% 
  summarize(n.totalcrime = n()) -> nbr_crime20.df

## import nbr map
head(nbr_crime20.df)

tm_shape(nbr.sf)+tm_borders()
head(nbr.sf)

## how to join two tables?
names(nbr.sf)
names(nbr_crime20.df)
joined_nbr.sf <- left_join(nbr.sf, nbr_crime20.df, by=c("nbhdname"="neighborhood"))
names(joined_nbr.sf)


tm_shape(joined_nbr.sf)+tm_polygons('n.totalcrime')
