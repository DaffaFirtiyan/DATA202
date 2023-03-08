#matrices have two dimensions. arrays have two or more dimensions
#we can load data into vectors and arrays by supplying a list of values, and the dimension of the object we're creating

#let's put 1:12 into a vector (length 12)
vec <- array(1:12, dim=12)
vec

#now into a matrix with 6 rows and 2 columns. notice how the data are poured into the array by filling down each col one at a time form left to right
mat1 <- array(1:12, dim=c(6,2))
mat1

#here's a 4 by 3 array
mat2 <- array(1:12, dim=c(4,3))
mat2

#we won't use this in the course, but here's a 3 way array (3 rows, 2 columns, 2 layers)
arr <- array(1:12, dim=c(3,2,2))
arr

#we can access individual elements, whole rows, or blocks of an array using the same indexing methods from vectors

#dimensions of mat2 - the # of rows and columns
dim(mat2)
mat2

#element in the 3rd row and 2col
mat2[3,2]

#all of the first row
mat2[1,]

#all of the third col
mat2[,3]

#the first two rows
mat2[1:2,]

#columns 1 and 3
mat2[,c(1,3)]

# we can name the rows and cols to make accessing them easier. here are some proportions of voter preferences (from eixt polls report by USA Today) from the 2016 US General Election
#load the data
prefs <- array(c(55,37,8, 
                 50,42,8,
                 44,53,3,
                 45,53,2), dim=c(3,4))
prefs

#name the rows and cols
dimnames(prefs) <- list(c("Clinton", "Trump", "Other"),
                        c("18-29","30-44","45-64","65+"))
prefs

#we can puck out just one age group using its col name
prefs[,"18-29"]

#or find by using row
prefs["Trump",]

#to better interpret this table, we better know that the population proportions in the four age groups are
#elementwise arithmetic works with arrays the same way it does with vectors - we can multiple each element of an array by the corresponding value in another array.
#to compute the porportion of people voting for each candidate we first load up a matrix of population proportions
props.vec <- c(0.20, 0.25, 0.40, 0.15)
props.vec

#convert this into a matrix
props.mat <- array(props.vec, dim=c(4,3))
props.mat

#this has age running down the rows. we want them to run down the columns.
#so we transpose using the t() function
props.mat <- t(props.mat)
props.mat

#now that the matrices dimensions matches up , we can multiply the two to give up the proportions we want
pop.prefs <- prefs*props.mat
pop.prefs

#we can add these proportions up to 
sum(pop.prefs)

#add along the rows (dimension 1)
#apply() takes three arguments
#first is the matrix we want to operate on
#second, MARGIN= specifies which row of the matrix we want to operate on
#third FUN= specifies which function to operate on each row. in this case it's sum(), but we can use mean(), max(), min(), median(), sd(), var(), sum(), length()
apply(pop.prefs, MARGIN=1, FUN=sum)

#or you don't have to specify the argument, just as long as you make sure that you get the order of the arguements rgith
apply(pop.prefs, 1, sum)

#add along the columns (dimension 2)
apply(pop.prefs, MARGIN=2, FUN=sum)


#matrix operations
#we don't need it in this course, but we can multiply two matrices using the %*% operator. other matrix operations are avaiable too
m1 <- array(c(2,3,1,3), dim=c(2,2))
m1

m2 <- array(c(1,1,1,3), dim=c(2,2))
m2

#elementwise multiplication
m1*m2

#matrix multiplicatoin
m1%*%m2

#matrix inverse
solve(m1)

#matrix determinant
det(m1)

#putting rows and columns together
#we can form larger array objects from smaller ones using the rbind() and cbind() functions

#make two vectors
x <- 1:4
y <- 2*1:4
dim(x)
dim(y)

#put them together as "rows" in a new object
a <- rbind(x,y)
a
dim(a)

#put them together as "cols" in a new object
b <- cbind(x,y)
b
dim(b)

#we can combine multiple objects together at once
cbind(b,x,x,x,b)

#and R will do its recycling trick
z <- c(8,80)
cbind(x,z,6,b,1:2)

#and will report an error if it can't make that work. but will still do it anyway
e <- rbind(x, 1:3)
e

#logical vectors
#we've covered almost all we need to know about logical vectors, but here are a few other things that might be helpful
#a%in%b gives a logical vector telling us which elements of a may be found in b
x <- c(12,34,11,16)
y <- c(12,12,72,89,90,16,99)

#which elements of x are in y?
x%in%y

#extract those elements
x[x%in%y]

#the reverse is different: elements of y that are in x
y[y%in%x]

#a quicker way to find out the elemetns common to both x and y 
intersect(x, y)

#all() returns a TRUE if all the elements of a vector are TRUE, and is FALSE otherwise. think of AND GATE
x <- seq(from=3,to=9,by=2)
x

#all elements are 9 or less
all(x<=9)

#all elements are more than 5
all(x>5)

#any() returns a TRUE if any of the elemnts of a vector are TRUE, and is FALSE otherwise. think of OR GATE
#any element that is 9 or higher
x
any(x>=9)

#any element that is more than 5
any(x>5)

#any elemetn that is less than 3
any(x<3)

# the ! flips TRUE and FALSE
x
x<6

!(x<6)

# | = OR
# & = AND
x
#which element are less than 4 OR greater than 8
(x<4) | (x>8)

#extract those elements
x[(x<4) | (x>8)]

#which elements are greater than 4 AND less than 8
(x>4) & (x<8)

#extract those elements
x[(x>4) & (x<8)]

# || = OR
# && = AND
#this logical operations will return only a SINGLE value, even when they compare vectors
# best to use only when you are definitely comparing single logical values

#categorical variables
x <- c("cup","plate","fork","knife","spoon")
x

#sort() will sort character strings into alphabetical order. it is case insensitive. 
sort(x)

#it only takes vectors, so you can't do
sort("cup","plate","fork","knife","spoon")

#we can compare them
x=="cup"
x[x=="cup"]

#but they are case sensitive
x=="Cup"

#and also trailing spaces
x=="cup "

#vectors of character variables need some special handling in R thorugh the use of factors.