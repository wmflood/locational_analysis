#Week 8 10/21/21
#Ch 3 Geocomputation with R
#Vector subsetting and aggregating
#Attribute joining

library(dplyr)
library(sf)
library(tmap)
library(lubridate)

##Subsetting the data
#subset rows ex. world[1:6, ]
#subset columns ex. world[ ,1:6]
#can also subset by names ex. world[ , c('name', 'lifeExp')]
#can also select in dplyr like this:
#world1 = dplyr :: select(world, name, pop)
#this selects specific columns
#world2 = dplyr::select(world, name:pop)
#this selects all colums between two names
#if you want to select several rows:
# slice(world, 3:5) this selects the rows between 3 and 5
#you can also filter by subset of attribute
#world6 = filter(world, lifeExp > 82)
#logic operators:
# == equivilant
# != not equal
# >,< greater than, less than
# >=,<= greater than/less than or equal to
# & and, | or, ! not
#long example:
#world7 = world %>%
# filter(continent == "Asia") %>%
# dplyr::select(name_long, continent) %>%
# slice(1:5)
#easier to find errors using the pipe operator
##Aggregation of data
# aggregate(pop ~ continent, Fun = sum, data = world, na.rm = True)
#can alos aggregate like this:
# world %>% 
#  group_by(continent) %>%
#  summarize(pop = sum(pop, na.rm = True))

#Live coding
crime.csv = read.csv("/Volumes/PATRIOT/GEO482_working/Crime_incidence.csv")
head(crime.csv)
class(crime.csv$incident_datetime)
#need to create new column as date time to subset only 2021
out = mdy_hms(crime.csv$incident_datetime)
crime.csv$date = mdy_hms(crime.csv$incident_datetime)
crime.csv$year = year(crime.csv$date)
crime.csv$month = month(crime.csv$date)

crime20.df = crime.csv %>% filter(year == 2020)

crime20_sep.df = crime20.df[crime20.df$month == '9',]
crime20_aug.df = crime20.df %>% filter(month == 8)

#want to count how many crimes committed per month
##how many cases occured per month in 2020
#long version
aggregate(parent_incident_type~month, data = crime20.df, FUN = length)

#short way
crime20_monthly.df = crime20.df %>% group_by(month) %>% summarize(ncases = n())

##create new dataframe that has neighborhood name and total cases of crime
nbr_crime20.df = crime20.df %>% 
  group_by(neighborhood) %>%
  summarize(n.total = n())

#import nbr map
load('Buffalo.RData')

tm_shape(nbr.sf)+tm_borders()
head(nbr.sf)

##How to join 2 tables
#nbr.sf is the target table
names(nbr.sf)
names(nbr_crime20.df)
joined_nbr.sf = left_join(nbr.sf, nbr_crime20.df, by=c("nbhdname" = "neighborhood"))

tm_shape(joined_nbr.sf)+tm_polygons('n.total')


##Bonus Point
#summarize data for 2019 and 2021, create a map post to UB learns
crime19_21.df = crime.csv %>% filter(year == 2019 & 2021)
nbr_crime19_21.df = crime19_21.df %>% 
  group_by(neighborhood) %>%
  summarize(n.total = n())
joined_nbr2.sf = left_join(nbr.sf, nbr_crime19_21.df, by=c("nbhdname" = "neighborhood"))
tm_shape(joined_nbr2.sf)+tm_polygons('n.total')
