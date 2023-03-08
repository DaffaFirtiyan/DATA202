#special values

#NA for not avaiable

#for exmple, we might hav ea vector of city popuatoloins, but not know oneof the values
populations <- cities <- c(Auckland=1495000, Wellington=405000,
                           Christchurch=389700, Dunedin=NA)
populations

#any math or logical manipulation of an NA value yields an NA again
#convert to millions
populations/1000

#compare puplations to the size of wellingotn - which cities have more populatoins?
populations>populations["Wellington"]

#we can't use == to find NA values
populations==NA

#we use is.na() instead
is.na(populations)

#to find which cities we don't have values for
populations[is.na(populations)]

#find out which cities we have values for
populations[!is.na(populations)]


#NaN for not a number
sqrt(-1)

is.nan(sqrt(-1))

#Infinity

#r knows that 1/0 is infinite
x <- 1/0
x

#we have both positive and negative infinity
#negative inf
-1/0

#adding or subtracting a finite value from +Inf is still +Inf. same goes for -Inf
Inf + 5
-Inf+5
Inf-5
-Inf-5

#comparison of values
Inf>4
Inf<=27
-Inf<=27
Inf==Inf

#a really big value
2^1000000

#there are some things that R balk on as they don't have proper answers
Inf-Inf
Inf*0

#you can use is.infinite to test of Inf occurrences
x <- c(1, Inf, sqrt(-1))
x

is.infinite(x)
x[is.infinite(x)]
x[!is.infinite(x)]
