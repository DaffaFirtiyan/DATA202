#vectors are a set of number put together by using the c() function. c stands for concatenate. vector only has one dimension

x <- c(2, 4.3, 6.6, 10, -1)
x

# find length
length(x)

#sort it into ascending order - it doesn't modify the original variable
sort(x)
x

#find max value
max(x)

#find index of the max value
which.max(x)

# add all elements
sum(x)

#multiple all elements
prod(x)

#on top of this we can also use math operations on vectors
#first let's make another vector the same length as x, then add it to x
y <- c(1, 4, 2.2, 7.13, sqrt(7))
y

x+y
x-y
x*y
x/y

x>y

#we'll get an error message if we try to add 5 element vector x to a 2 element vector z
z <- c(3,5)
x+z

#add 1.5 to every element of x
x+1.5

#subtract the min value from every element of x
x-min(x)

#double every element of x, add 4.5, then subtract median of the x values
2*x + 4.5 - median(x)

#append the value 5.5 onto the end of x making a vector of 6 elements
v <- c(x, 5.5)
v

#add z (which has a lenght of 2 - so it z is "recycled" 3 times)
v+z

#some fucntions take vectors as input and give back vectors as outputs

#range of a vector
range(x)

#incidentlaly, this is exactly the same as
c(min(x),max(x))

#diff() subtracts each elemetns in a vactor from the previous element (the difference between this element and the previous). the first element have no previous elemnt so it doesn't change
y
diff(y)

#accessing individual number (subset) of a vector

#the whole vector x
x

#first element - note it doesn't start from 0
x[1]

#4th element
x[4]

#last element
x[length(x)]

#non existing element generate NA
x[10]

#1st and 4th element - this is known as index vector -> x[c(1,4)] isntead of x[1,4] because this means something different when we're using two dimensional arrays
x[c(1,4)]

#get eleemtn 1 3times, elemnt 2, elemnt 1 again, elemtn 5 twice
x[c(1,1,1,2,1,5,5)]

#R allows to generate sequences of consecutive int using the : operator. 1:4 gives us c(1,2,3,4) and we can use this as an index vector so x[1:4] translate to x[c(1,2,3,4)]
x[1:4]

x[c(1,3:5)]

#notice that range(x) and x[idx] produce the same output. this is because range looks for the min and max respectively. x[idx] shows the same output because idx store a vector of where the minimum is and where the maximum is, which is c(5,4). so x[c(5,4)] shows the same output as range
range(x)
idx <- c(which.min(x), which.max(x))
idx
x[idx]

#if you use the : operator as 2:5, it outputs c(2,3,4,5). if you do 5:2, it outputs c(5,4,3,2)
#store the length of x
n <- length(x)

#store the est of integers form n down to 1
idx <- n:1
idx

#get the element in reverse order
x[idx]

#you can do this in one line with
x[c(length(x):1)]

#or the faster way to do it is with
rev(x)

#sometimes you may use negative indices. this outputs all elements except for the 3rd element
x[-3]

#this one outputs the 2nd, 3rd, 4th
x[-c(1,5)]

#this one outputs 3rd and 4th
x[-c(1:2, 5)]

#logical index variables
#first we might want to identfy all positive elements in x
x>0

#then we can use this to subset x which shows all elements that are TRUE
x[x>0]

#lets find all elemnt in x that is less than 4
idx <- x<4
xsmall <- x[idx]
xsmall

#first element in x that is less than 4
xsmall <- x[x<4]
xsmall[1]

#do this in one line
x[x<4][1]

#find the largest element 
max(x[x<4])

#smallest element
min(x[x<4])

#changing values of particular elemnts
x <- c(2,4,3,2,1)
x
 #change the first elelment to 6
x[1] <- 6
x

#we can change several elemetns at once
#set the first 3 elements to 1,3,5
x[1:3] <- c(1,3,5)
x

#we can use logical vector to select elements with a certain property.
#here we set all the negatives elemetns of a vector to 0
x <- c(-2,-3,4,-2,3,4)
x
x[x<0] <- 0
x

#accessign elements by name
#we can name elements. we might create a vector giving names to all the elements
heights <- c(Fred=1.79, Wilma=1.65, Barney=1.62, Betty=1.68)
heights

#now we can access element by their lcoation
heights[1]

#or by their name
heights["Fred"]

#the names are case sensitive
heights["fred"]

#multiple elements by name
heights[c("Fred", "Barney")]

#we can store the names in a vector variable and just call the variable to get the list of names
men <- c("Fred","Barney")
women <- c("Wilma","Betty")
flintstones <- c("Fred","Wilma")
rubbles <- c("Barney","Betty")
heights[women]
heights[rubbles]
