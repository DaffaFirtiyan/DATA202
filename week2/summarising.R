#summarising data

#surf is from stats nz. they created a syntheticset of unit records based on its income survey

surf <- read.csv("surf.csv", header=TRUE)
surf[1:10,]

#names of variables
names(surf)

#we can look at the structure of the dataset
str(surf)

#look at the first few rows
head(surf)

#first three rows
surf[1:3,]

#first five rows and first three cols
surf[1:5,1:3]

#accessing cols by name
surf[1:10, c("Gender", "Age", "Income")]

#lets look at the age col - it contains age in years. we can see from the output of str(surf) that it's an int
#we can refer to the age col in 3 ways

#refer age by its index
copyofages <- surf[,4]

#refer by var name
copyofages <- surf[,"Age"]

#data frams have one more way to refer to cols - using the $ sign
copyofages <- surf$Age

copyofages[1:5]

#the $ notation for referring to cols is very useful
#this shows that this is a highly restricted set of ages - only 15-45
range(surf$Age)

#deleting a column: from the output of str() we can see that there is a col called X that doesn't have any data
#inspect X col
surf$X[1:10]

#check to see that every value is NA
all(is.na(surf$X))

#we can remove a col from a dataset in arous ways, the easiest being to set the col to NULL
names(surf)

surf$X <- NULL
names(surf)

#we can make a brief summary of the characteristics of every col using summary()
summary(surf)


#summarising and displaying continuous numerical variables
#we can use a whole set of familiar functions to get numerical summaries of a numerical col

#mean age
mean(surf$Age)

#median age
median(surf$Age)

#the function mode() doesn't find the statistical mode (the most frequent value)
#instead it tells us something about what kind of variable age is
mode(surf$Age)

#to find the statistical mode
names(sort(table(surf$Age), decreasing = TRUE))[1]

#quartiles - get lower quartile, median and upper quartile
quantile(surf$Age, c(0.25, 0.5, 0.75))

#get the 5th percentile and 95th percentile
quantile(surf$Age, c(0.05, 0.95))

#we may need to remove NA values with na.rm=TRUE when computing these summaries if we want to throw away missing data

#there are two standard graphical displays for continuous data
#boxplot
boxplot(surf$Age)

#this uadorned box plot can be improved by specifying a title (main=) and an axis label (ylab=)
#we can also colour the box with (col=)
#recall that the horizontal axis is called the x-axis, and the verytical axis is caleld the y-axis
boxplot(surf$Age, main="Distribution of Age", ylab="Age(years)", col="pink")

head(surf)
#you can see the hig income outliers plotted separately in the diagram
boxplot(surf$Income, main="Income Distribution", ylab="Weekly income", col="green")

#histogram
#it counts the number of observations in a number of classes, and plots bars to show these numbers
hist(surf$Age, main="Age Distribution", xlab="Age (years)", col="purple")

#factors
#categorical variables aren't numbers (even if, like stress level, they may be recorded on a numerical scale)
#instead, they have a set of possible values
#we can count the number of values in each of the categoreis using the table() function
table(surf$Ethnicity)

#note that the order of the categories is alphabetical. we can take control of this by coding the categorical vairbale as a factor.
#factors allow us to specify a preferred order for the levels of the variable, which assists us in making diagrams and tables in a standard format

#ldt's convert ethnicity into a factor and remake the table.
#let's say we want the ordering of ethnicities to be Maori, Pacific, European, Other
#also let's chage the other category to Other

#identify all elements of surf$Ethnicity that are coded "other" and replace them with "Other"
surf$Ethnicity[surf$Ethnicity=="other"] <- "Other"
table(surf$Ethnicity)

#now we convert ethnicity into a factor, speciying the levels in the order we want
surf$Ethnicity <- factor(surf$Ethnicity,
                         levels = c("Maori","Pacific","European","Other"))
table(surf$Ethnicity)

#to find the levels that a factor has, use levels()
levels(surf$Ethnicity)

#unlike numerical functions like mean(), table() automatically excludes missing value
#we can see if there are any missing values in the col by asking table() not to exclude anything
table(surf$Ethnicity, exclude=NULL)

#now we can convert these totals into percentages
#number of rows in the dataset
n <- nrow(surf)

#counts by ethnic group
tab.eth <- table(surf$Ethnicity)

#convert counts to percentages
perc.eth <- 100*tab.eth/n
perc.eth

#a warning about creating factors, make sure you don't make any spelling mistakes
surf$Gender <- factor(surf$Gender, levels=c("male","Female"))
table(surf$Gender, exclude=NULL)

#all 107 "female" has been converted to missing (NA) because they don't match "Female"


#the best diagram to show a categorical chart is a bar chart
barplot(table(surf$Ethnicity),
        xlab="Ethnic Group", ylab="Frequency",
        main="Ethnicity Distribution", col="brown")

#note that barplot() needs to be given the summarised data from table(). NOT the original raw data from the dataset

#summarising two numercial variables
#say we want to compare Age and Income - we draw a scatter plot using the plot() function

plot(surf$Age, surf$Income,
     xlab="Age (years)", ylab="Weekly Income",
     main="Age-Income Distribution")
#there doesn't seem to be much of a realtionship here

#we can change the plotting points by specifying pch= (see ?points for a list of options) and col= for color
plot(surf$Age, surf$Income,
     pch=16, col="purple",
     xlab="Age (years)", ylab="Weekly Income",
     main="Age-Income Distribution")

#summarising one numerical, one categorical
#say we want to compare income an qualification - we can draw side by side boxplots
#we need to split the income data into separate groups using the Qualification factor
#the functions split() is one way to do this: it takes a vector and divides it into pieces using a factor
splitinc <- split(surf$Income, surf$Qualification)
splitinc

#the result is a list object: it contains four separate vectors, each containing the incomes for the different levels of the Qualifiacation factor
length(splitinc)

#we access each element using double brackets [[]] or by name
splitinc[[4]]

names(splitinc)
splitinc[["school"]]
splitinc$degree

#we can make boxplots of the results
boxplot(split(surf$Income, surf$Qualification),
        xlab="Qualification", ylab="Weekly Income",
        main="Distribution of Qualification & Weekly Income")

#R also provides another interface to boxplot() that achieves the same thing:
#treating Income as an outcome variable and Qualification as an explanatory, it represents the splitting of Income by Qualification as an equation:
#Income ~ Qualification with ~ meaning "is explained by"
#we also have to specify where the data comes from with data=
boxplot(Income ~ Qualification, data=surf,
        xlab="Qualification", ylab="Weekly Income")

#but again, we run into the problem that levels of Qualification aren't in order. so we have to fix that with factors
surf$Qualification <- factor(surf$Qualification,
                             levels=c("none", "school", "vocational", "degree"))
boxplot(Income ~ Qualification, data=surf)

#if we want to know the mean income in each group, we can use the tapply() function, which applies a function to aech part of a vecto which is broken up by a factor

#compute mean income by Qualification group
tapply(surf$Income, surf$Qualification, mean)

#compute median income by gender
tapply(surf$Income, surf$Gender, median)

#compute the range of icomes by gender
#this returns a list object with a vector of two entries
tapply(surf$Income, surf$Gender, range)

#two categorical variables

#if we have two categorical variables we can use table() to create a contingency table or corss tabulation - the numbers of observation in each cross classified cell.
#the distribution of qualification and gender is
table(surf$Qualification, surf$Gender)

#we can display the results as a clustered bar chart
#beside=TRUE stops R from stacking the bars on top of another
#R also automatically coloured the bars
barplot(table(surf$Qualification, surf$Gender), beside=TRUE,
        xlab="Gender", ylab="Frequency")

#a graph like this is uninterpretable without a leged to say what the bars mean.
#we can also choose the colours of the bars ourselves
#we also need to make the y-axis a bit taller to acommodate the legend
barplot(table(surf$Qualification, surf$Gender), beside=TRUE,
              xlab="Gender", ylab="Frequency", ylim=c(0,50),
              col=grey.colors(4))
legend("topright", legend=levels(surf$Qualification),
       fill=grey.colors(4), ncol=4, bty="n")


#artifical satellites
#dataset from kaggle

#read dataset and look at its content
sat <- read.csv("active-satellites.csv")
str(sat)

#find out how many rows and cols it has
dim(sat)

#first few rows
head(sat)

#variable names 
names(sat)

#lets look at a numerical value: the orbital period.
#this is the var Period..Minutes.
#clearly measured in minutes
#side note: R has converted spaces in the variable name in the origial data into .
head(sat$Period..Minutes.)

#the values have " surrounding them. this suggests that R is stroing these values as charaters
#we can check this
is.character(sat$Period..Minutes.)

#we want to treat these values as proper numbers so lets force R to view them as numberers
#we can create a new col called PeriodMin in the data frame by getting R to view each value in sat$Period..Minutes. as a number
sat$PeriodMin <- as.numeric(sat$Period..Minutes.)

#we get an error saying that NAs are introduced
#let's check which ones
sat$Period..Minutes.[is.na(sat$PeriodMin)]

#there are 5 values - 3 NULL - stored as empty strings and 2 are "8 days" showing that the person who enetered the data did so incorrectly
#fixing this kind of error is data cleaning

#numeber of mins in 8 days is 8*24*69
sat$PeriodMin[sat$Period..Minutes.=="8 days"] <- 8*24*60

#check again
sat$Period..Minutes.[is.na(sat$PeriodMin)]

#now lets calculate the mean period
mean(sat$PeriodMin)

#we get NA because of the 3 missing values - any calculations involving an NA gives another NA
#we need to exclude those values

#exclude by removing the NA's before giving the periods to mean()
mean(sat$PeriodMin[!is.na(sat$PeriodMin)])

#alternatively, ask mean() to remove the NA's for us
mean(sat$PeriodMin, na.rm=TRUE)

#some, but not all, functions have this convenient functionality - for example min(), max(), median(), sum() all allow removal of NA values using na.rm=TRUE

#now let's take a look at launch sites
head(sat$Launch.Site)
barplot(table(sat$Launch.Site))

#that didn't look too good
#we only have some labels
#it'd be good to have these in order of increasing number of launches

#get a table of numbers of launches by site
tablaunch <- table(sat$Launch.Site)

#sort it into increasing order
tablaunch <- sort(tablaunch)

#draw barplot, but rotate the names of the bars, and reduce the font size (cex.names=)
barplot(tablaunch, las=2, cex.names=0.4)

#cex.names means character expansion for names: a cex of 1 means the deafult size
#las=2 rotates the orientation of the axis labels, so that they don't overlap each other

#the biggest five launch sites
rev(tablaunch)[1:5]
