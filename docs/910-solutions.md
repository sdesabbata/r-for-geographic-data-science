# Solutions {-}

<br/><small><a href="javascript:if(window.print)window.print()">Print this chapter</a></small>

## Solutions 104

Note that you can add sections to your code, such as the "Intro" section below by selecting Code > Insert Section... from the top menu in RStudio. Those will then be visible on a right panel in  the RStudio integrated editor if you select Code > Show Document Outline from the top menu. Code sections can help to visually organise your code and the Document Outline allows you to select a section and jump to it in the code.

The code below deletes all variable and function currently defined in the environment, which is generally good practice, to avoid your script interacting with objects left over from previous sessions.


```r
rm(list = ls())
```

Load the necessary libraries.


```r
# Load the tidyverse
library(tidyverse)

# Load magrittr
# necessary for options 3 and 4 
# of my answer to Question 104.2.4
library(magrittr)
```



### Solutions 104.1

**Question 104.1.1:** Write a piece of code using the pipe operator that takes as input the number `1632`, calculates the logarithm to the base 10, takes the highest integer number lower than the calculated value (lower round), and verifies whether it is an integer.


```r
1632 %>%
  # calculate the logarithm to the base 10
  log10() %>%
  # highest integer number lower than the value
  floor() %>%
  # check whether it is an integer
  is.integer()
  # The answer is FALSE
  # as the value is still of type numeric
  # rather than type integer
```


```r
# The code below replicates the procedure above
# but checking the value data type
1632 %>%
  log10() %>%
  floor() %>%
  class()
```


```r
# The code below replicates the procedure above
# but using as.integer to transfor the value
# to an integer type
1632 %>%
  log10() %>%
  floor() %>%
  as.integer() %>%
  class()
```


```r
# As above but checking whether the value is an integer
1632 %>%
  log10() %>%
  floor() %>%
  as.integer() %>%
  is.integer()
```

**Question 104.1.2:** Write a piece of code using the pipe operator that takes as input the number `1632`, calculates the square root, takes the lowest integer number higher than the calculated value (higher round), and verifies whether it is an integer.


```r
1632 %>%
  # calculate the square root
  sqrt() %>%
  # lowest integer number higher than the value
  ceiling() %>%
  # check whether it is an integer
  is.integer()
```

**Question 104.1.3:** Write a piece of code using the pipe operator that takes as input the string `"1632"`, transforms it into a number, and checks whether the result is *Not a Number*.


```r
"1632" %>%
  # transform it into a number
  as.numeric() %>%
  # check whether the result is Not a Number
  is.nan()
```

**Question 104.1.4:** Write a piece of code using the pipe operator that takes as input the string `"-16.32"`, transforms it into a number, takes the absolute value and truncates it, and finally checks whether the result is *Not Available*.


```r
"-16.32" %>%
  # transform it into a number
  as.numeric() %>%
  # take the absolute value
  abs() %>%
  # truncate
  trunc() %>%
  # check whether the result is Not Available
  is.na()
```



### Solutions 104.2

Answer the question below, consulting the [`stringr` library reference (stringr.tidyverse.org/reference)](https://stringr.tidyverse.org/reference/index.html) as necessary

**Question 104.2.1:** Write a piece of code using the pipe operator and the `stringr` library that takes as input the string `"I like programming in R"`, and transforms it all in uppercase.


```r
"I like programming in R" %>%
  # transforms it all in uppercase
  str_to_upper()
```


**Question 104.2.2:** Write a piece of code using the pipe operator and the `stringr` library that takes as input the string `"I like programming in R"`, and truncates it, leaving only 10 characters.


```r
"I like programming in R" %>%
  # truncate leaving only 10 characters
  str_trunc(10)
```


**Question 104.2.3:** Write a piece of code using the pipe operator and the `stringr` library that takes as input the string `"I like programming in R"`, and truncates it, leaving only 10 characters and using no ellipsis.


```r
"I like programming in R" %>%
  # truncate
  str_trunc(
    # leaving only 10 characters
    10,
    # no ellipsis
    ellipsis = ""
  )
```


**Question 104.2.4:** Write a piece of code using the pipe operator and the `stringr` library that takes as input the string `"I like programming in R"`, and manipulates to leave only the string `"I like R"`.


```r
# Option 1
"I like programming in R" %>%
  # using remove
  str_remove("programming in ")

# Option 2
"I like programming in R" %>%
  # using replace
  str_replace("programming in ", "")

# Option 3
"I like programming in R" %>%
  # create two sub-strings
  str_sub(
    # the first starting from the first character
    # the second starting from the last character
    start = c(1, -1),
    # the first ending at the sixth character
    # the secondending at the last character
    end = c(6, -1)
  ) %>% 
  # join the two strings into one
  # using a single space to separate them
  str_c(collapse = " ")

# Option 4
"I like programming in R" %>%
  # split the string at each space
  str_split(" ") %>% 
  # that will create a list with one element
  # that is the vector of strings resulting
  # from the split
  # to extract that element
  # use extract2 from magrittr
  # equivalent to [[1]]
  # https://magrittr.tidyverse.org/reference/aliases.html
  extract2(1) %>%
  # extract the first, second and fifth elements
  # from the vector
  # use extract2 from magrittr
  # equivalent to [c(1, 2, 5)]
  # https://magrittr.tidyverse.org/reference/aliases.html
  extract(c(1, 2, 5)) %>%
  # join the two strings into one
  # using a single space to separate them
  str_c(collapse = " ")
```



## Solutions 114


```r
# Load the tidyverse
library(tidyverse)
```



### Solutions 114.1

**Question 114.1.1:** Use the modulo operator `%%` to create a conditional statement that prints `"Even"` if a number is even and `"Odd"` if a number is odd.


```r
number_for_test <- 7

# If a number modulo 2 is 0 then the nuber is even
if (number_for_test %% 2 == 0) {
  cat("Even\n")
# otherwise it is odd
} else {
  cat("Odd\n")
}
```


**Question 114.1.2:** Encapsulate the conditional statement written for *Question 114.1.1* into a `for` loop that executes the conditional statement for all numbers from 1 to 10.


```r
for (iterator in 1:10) {
  if (iterator %% 2 == 0) {
    cat("Even\n")
  } else {
    cat("Odd\n")
  }
  
}
# After the loop delete the iterator
# just to be on the safe side :)
rm(iterator)
```


**Question 114.1.3:** Encapsulate the conditional statement written for *Question 114.1.1* into a `for` loop that prints the name of cities in odd positions (i.e., first, third, fifth) in the vector `c("Birmingham", "Derby", "Leicester", "Lincoln", "Nottingham", "Wolverhampton")`.


```r
cities <- c("Birmingham", "Derby", "Leicester", "Lincoln", "Nottingham", "Wolverhampton")

# for each index in the vecotr cities
# i.e., 1 to length of the vector
for (iterator in 1:length(cities)) {
  # Testing for odd number intead of even
  # thus checking if the result is 1 rather than 0
  if (iterator %% 2 == 1) {
    cat(cities[iterator], "\n")
  }
  
}
# After the loop delete the iterator
# just to be on the safe side :)
rm(iterator)
```

**Question 114.1.4:** Write the code necessary to print the name of the cities in the vector `c("Birmingham", "Derby", "Leicester", "Lincoln", "Nottingham", "Wolverhampton")` as many times as their position in the vector (i.e., once for the first city, two times for the second, and so on and so forth).


```r
# for each index in the vecotr cities
# i.e., 1 to length of the vector
for (iterator in 1:length(cities)) {
  # need a second iterator!
  # to print the name of the city as many 
  # times as 1 to the current value if the iterator above
  for (second_iterator in 1:iterator){
    # Let's keep the city name on the sam line
    # just addid a space between occurencies
    cat(cities[iterator], " ")
  }
  # Once we are done printing one city name
  # then go to new line
  cat("\n")
}
# After the loop delete both iterators
# just to be on the safe side :)
rm(iterator)
rm(second_iterator)
```



### Solutions 114.2

**Question 114.2.1:** Write a function that calculates the areas of a circle, taking the radius as the first parameter.


```r
area_of_a_circle <- function (circle_radius) {
  # the area of a circle is equal to
  # pi times radius squared
  circle_area <- pi * (circle_radius^2)
  # return the value
  circle_area
}

# Test
area_of_a_circle(3)
```

**Question 114.2.2:** Write a function that calculates the volume of a cylinder, taking the radius of the base as the first parameter and the height as the second parameter. The function should call the function defined above and multiply the returned value by the height to calculate the result.


```r
volume_of_a_cilinder <- function(base_radius, cilinder_height) {
  # call the function defined above to calculate the area
  base_area <- area_of_a_circle(base_radius)
  # then calculate volume
  cilinder_volume <- base_area * cilinder_height
  # return the value
  cilinder_volume
}

# Test
volume_of_a_cilinder(3, 2)
```



**Question 114.2.3:** Write a function with two parameters, a vector of numbers and a vector of characters (text). The function should check that the input has the correct data type. If all the numbers in the first vector are greater than zero, return the elements of the second vector from the first to the length of the first vector. 


```r
silly_function <- function (num_vector, chr_vector) {
  # Check vector types
  # Note that you can use logic operators
  # to combine conditional statements
  # and the function all
  # to check if the condition is true for all the elements of the vector
  if ( all(is.numeric(num_vector)) & all(is.character(chr_vector)) ) {
    # Check if all numbers greater than zero
    if (all(num_vector > 0)){
      # Subset the vector to return
      chr_vector[1:length(num_vector)]
    } else {
      cat("That's low...\n")
    }
  } else {
    cat("Those values seem highly inappropriate!\n")
  }
}

# Test 1
silly_function(1:3, cities)

# Test 3
silly_function(-1:1, cities)

# Test 3
silly_function(cities, 1:3)
```


---

<small>by [Stefano De Sabbata](https://sdesabbata.github.io/) -- text licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence), code licensed under the [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html).</small>
