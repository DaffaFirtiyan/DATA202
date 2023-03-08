#reading data

#data.frame is a table - a set of rows and cols - and al lthe entires in the smale comumn are of the same type, but the cols can be of different types

#method 1 enter data through R
cities <- data.frame(city=c("Auckland","Wellington","Christchurch",
                            "Hamilton","Tauranga","Napier-Hastings",
                            "Dunedin"),
                     pop=c(1495000, 405000, 389700,
                           230000, 134400, 131000,
                           118500),
                     area=c(1086, 444, 608, 877, 178, 375, 255))
cities

#you have to be very exact when making a data.frame. the syntax is: data.frame(name1=c(...), name2=c(...), name3=c(...), ...)

#now we can find out some properties of the dataset we've just created

#number of rows and col
dim(cities)

#numer of rows
nrow(cities)

#number of columns
ncol(cities)

#names of all rows and cols
dimnames(cities)

#col names - these are the variable names
names(cities)

#also get row names by
rownames(cities)

#and col names by
colnames(cities)

#method 2 use a dataset from an installed R package
library(MASS)
Animals

#Animals doesn't appear in the environemnt because it's in workspace associetd with the MASS package, you can't change the dataset in that workspace
#so the best way tois to create a copy in our own environemnt
data(Animals)

dim(Animals)
dimnames(Animals)
nrow(Animals)
ncol(Animals)
names(Animals)
rownames(Animals)
colnames(Animals)

#method 3 read an external file

#csv

#first we need to save the file somewhere, then we can read it in using the menus
#in the Environment window -> Import Dataset -> From Text (base)
#or File -> Import Dataset -> From Text (base)

#alternatively, you can set do it manually
getwd()
setwd("C:/Users/mdaff/Documents/GitHub/DATA202/week2")

titanic <- read.csv("titanic.csv", header = TRUE)
titanic

#excel file
library(readxl)
titanic <- read_excel("titanic.xlsx")
titanic[1:2,]

#excel files can have multiple sheets, and read_excel() can read a specified sheet
dat1 <- read_excel("some-random-data.xlsx", sheet=2)
dat[1:3,]

#we can also find out what the sheets are called
excel_sheets("some-random-data.xlsx")

#then read a sheet specifying its name rather than its index
dat2 <- read_excel("some-random-data.xlsx", sheet="surf")
dat[1:3,]

#reading the surf csv
surf <- read.csv("surf.csv", header = TRUE)
surf[1:10,]

#method 4 extract from database
#this will be covered once we get to SQL

#method 5 webscraping
#here's code to get all the NZ urban center sizes from wikipedia page



#we need to load a couple of packages httr and XML
library(httr)
library(XML)

#we need to specify the web address, the URL, of the page we want
url <- "https://en.wikipedia.org/wiki/List_of_cities_in_New_Zealand"

#then we GET() the URL, convert it to text with rawToChar() and interpret the HTML code with htmlParse
doc <- htmlParse(rawToChar(GET(URL)$content))

#we pull all the tables out of the downlaoded webpage with readHTMLTable() and then select just the first of them
tabs <- readHTMLTable(doc)
urban <- tabs[[1]]

#then we finally do a bit of clearning of the two cols (details explained later)
urban[,3] <- as.numeric(gsub(",","",substring(urban[,3],21)))
urban[,4] <- as.numeric(gsub(",","",substring(urban[,4],21)))
urban[,5] <- as.numeric(gsub(",","",substring(urban[,5],21)))
names(urban)[4] <- "Area (sq km)"
names(urban)[5] <- "Population density (people/sq km)"
urban

#writing out a dataset
#it's a good idea to save to an external file so we can use it later - either in R or elsewhere

#to write cities data frame out to .csv file called cities.csv, we do
write.csv(cities, file="cities.csv", row.names = FALSE)
