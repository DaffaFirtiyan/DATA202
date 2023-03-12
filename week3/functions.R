#functions
#a function is a set of instructions which accepts a set of arguments and then carries out that set of instructions - often creating a value which we can display or sotre

#basics of function

#lets say we want to create a function which squares a number
#we call the function square(). it only has 1 arguement: x which is the name of object we want to square
square <- function(x) {
  #returns the squared value
  return(x^2)
}

#if we type square, R prints out the function definition
square

#to call it we need to do
square(2)

#conviniently, our function opearates on vectors and arrays as well as single numbers without any modification

#square a scalar
aa <- 6
square(aa)

#square the elements of a vector
aa <- c(1,4,5)
square(aa)

#square the elements of an array
aa <- array(c(1,4,5,3,3,3), dim=c(3,2))
square(aa)

#defaults values and argument matching
#leaving the argument of square() creates an error
square()

#R tells us that theres no deafult value
#many functions do have deafult values for their arguments
#our function doesn't have a help file but we can sitll find out its arguemnts in a very easy way using the args() function
args(square)

#median() has one default argument: na.rm=FALSE
args(median)

#consider this vector which has one missing value, and where we want to find themedian of the non-missing values
v <- c(3, 4, NA, 10)
v

#if we don't throw out the NA we have two ways we can acll median() - with or without naming the argument x explicity
median(v)
median(x=v)

#any math opeartion involving NA givs NA, we need to get R to ignore the missing value
#if we want R to ignore the missing value we can call median() is various ways

#first we can just get R to work out which argument is which by theorder in which we supply the values
#this is called positional matching
median(v,TRUE)

#we can write more readable code, and be explciity about these arguments by naming them
#this is called explicit matching
#if we're using explicit arguments, names don't need to be in order
median(na.rm=TRUE, x=v)

#in many R functions, there are one or two arguments that are requried, followed by a whole lot of optional arguments
#here we take a look at legend()
args(legend)

#there's only one requried argument, x, everything else is optional

#note - R allows you to be a little lazy when specifying arugment names - you only have to give enought of the name unambigously identify which argument you're talking about
# this is called partial matching but DONT USE this

#the following are all valid
median(v, n=TRUE)
median(v, na=TRUE)
median(v, na.=TRUE)
median(v, na.r=TRUE)
median(v, na.rm=TRUE)

#reserved words and names
#functions and objects can be given any names EXCEPT the following
?reserved

#you can see that R will throw an error
Inf <- 5

#this is fine though
inf <- 5

#scope
# we know that R has a function called sqrt() to compute square roots.
#sqrt isn't a reserved ord, so we can actually redefine it
sqrt <- 6
sqrt

#does this mean that we have lost acess to the function sqrt()?
#no, becuase when we use a faunction we alwyas have the brackets following the name
#this tells R that we're accessing a function
sqrt(4)

#however we cold define a function called sqrt and have it do something else
sqrt <- function(x) {
  return(x+2)
}
sqrt(4)

#does that mean we have destoryed the original sqrt()?
#nope, it still exist, just buried. we have to be a bit more explicit about claling it.