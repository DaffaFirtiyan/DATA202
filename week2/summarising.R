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
