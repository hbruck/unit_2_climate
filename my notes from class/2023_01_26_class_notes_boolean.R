## Heather Bruck 
## 2023-01-26
## MSCI 709-Unit 2-Lesson 2: Boolean Logic 

# Logical subsetting 
  # we can select values with vector of T or F (select just for data you want) 
vec <- c(1, 0, 2, 1)
vec[c(F, F, T, F)]
  # the vector must be the same length as dimension I want to subset  
  # R returns every element that matches T (True)  


### Logical tests
  # logical test= comparison, eg. 1 < 2 
  # can be used to select values within an object 
  # list of R's logical vectors: 
      # >	| a > b	| Is a greater than b?
      # >=	| a >= | b	Is a greater than or equal to b?
      # <	| a < b	| Is a less than b?
      # <=	| a <= b	| Is a less than or equal to b?
      # ==	| a == b	| Is a equal to b?
      # != |	a != b	| Is a not equal to b?
      # %in%	| a %in% c(a, b, c)	| Is a in the group c(a, b, c)?


  # testing out R's logical operators 
  1 > 2 # output is false 
  1 > c(0, 1, 2)
  c(1, 2, 3) == c(3, 2, 1)

  # % 
    # tests whether the value(s) on the left side are in the vector on the right side 
  1 %in% c(3, 4, 5) # is 1 in the list of 3, 4, 5? 
  c(1, 2) %in% c(3, 4, 5)  # is 1 or 2 in the list of 3, 4, 5? 
  c(1, 2, 3, 4) %in% c(3, 4, 5)
  
  # best to compare R objects of same data type with logical operator 
    # if comparing different data types, R will use coercion rules to coerce the objects to the same type 

### Subsetting a data frame
  world_oceans = data.frame(ocean = c("Atlantic", "Pacific", "Indian", "Arctic", "Southern"),
                            area_km2 = c(77e6, 156e6, 69e6, 14e6, 20e6),
                            avg_depth_m = c(3926, 4028, 3963, 3953, 4500))
  world_oceans$avg_depth_m > 4000 # testing the condition is right
  # sum() counts the number of 'TRUE' in the vector 
  sum(world_oceans$avg_depth_m > 4000) # counts the number of oceans with depth > 4000
    # prints the names of oceans with depth > 4000
    world_oceans$ocean[world_oceans$avg_depth_m > 4000] # returns ocean names 
    deep_oceans <- world_oceans[world_oceans$avg_depth_m > 4000, ] # returns all columns, don't forget , at end of line 

### imprecise numerics 
  1 + 2 == 3 # true, 3 = 3
  0.3 - (0.1 + 0.2) # returns with super small number, it doesn't equal to 0 due to computer rounding errors 
     # need to change the logical test: 
     error_threshold <- 0.000001
     abs(0.3 - (0.1 + 0.2)) < error_threshold     
       # returns True, error threshold and abs() help 
## exercise 2 
  my_oceans <- world_oceans[world_oceans$ocean == 'Atlantc' | world_oceans$ocean == 'Pacific']
 
### Boolean Operators 
  # Boolean operators collapse the results of multiple logical tests into a single T or F 
    # & 
    # |
    # xor 
    # ! 
    # any 
    # all 
  # place a Boolean operator between ** 2 complete logical tests ** 
  x <- 5
  x > 3 & x < 15
  x > 10 & x < 15 # returns F even though x<15 true 
  x > 10 | x < 15 # returns T because using 'or' symbol 
  x > 10 & x %in% c(1, 3, 5, 7) # returns F 
  x > 10 | x %in% c(1, 3, 5, 7) # returns T
  x > 10 | !(x %in% c(1, 3, 5, 7)) # returns F
  
  # all oceans with depth > 1000 and area 
  world_oceans[world_oceans$avg_depth_m > 4000 | world_oceans$area_km2 < 50e6, ]

  z <- c(T, T, F)  
  any(z) # are ANY of the values in z True? 
  all(z) # are ALL the values of zin z True? 

  # dealing with NA values 
  is.na(NA)
  vec <- c(1, 2, 3, NA)  
  is.na(vec)
  any(is.na(vec))  
  !is.na(vec) # tells you to not give rows with NA 
  
  ### for HIH: SUBSET THE DATA AT TOP OF DOCUMENT TO FILTER OUT NA BASED ON CATEGORY
# do the exercises in 2.2 lesson 
  
  
##################################################
## MSCI 709 - Unit 2 - 2.3 Conditional Statements

# if statements 
  # if ___ is true, then ____ 
  # if ____ is false, then don't do ____
  num <- -2
  if(num < 0){
    num = num * -1
  } # if my number is less than 0, multiply it by -1 to make it positive 

  num <- 4
  if(num < 0){
    num = num * -1
  }  # since num is positive, it does not get multiplied by -1 
  
  # can include a print statement within if statements 
  num <- -1
  if(num < 0){
    print('Uh-oh! num is negative.')
    num = num * -1
    print('Now num is positive.')
  } # printing a message to yourself can be helpful to keep track of where you got hung up 
  
# EXERCISE 3.1 
# Let’s say you took someone’s temperature and you want to first evaluate whether or not they have a fever. If they DO have a fever, claculate how different their temperature is from the median human temperature of 98.6 and print out the answer. Also, if they DO have a fever, evaluate whether the fever is high > 101 and if it is, print out a warning message. This will require a set of nested if() statements. Test your code with a temperature that is not a fever (temp = 98.4), that is a low fever (temp = 99.5) and that is a high fever (temp = 102.1).
  temp <- 98.9
  if(temp > 98.6){
    print('you are a bit sick')
    if(temp > 101){
      print('go to the doctor')
    }
  }  

# else statements 
  # these tell R what to do if the condition is FALSE 
  # only do else when the if statement is FALSE 
  # else statements always go at the end of an if statement 

  grade <- 50
  
  if(grade > 60){
    print('you passed!')
  }else{
    print('you failed...')
  }  
  
  # how to do else statements with multiple mututally exclusive cases 
  a <- 2
  b <- 2
  
  if(a > b){
    print('A wins')
  } else if(a < b){
    print('B wins') 
  } else{
    print('Tie game')
  }

### do exercise 3.2 