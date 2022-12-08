# (PART\*) R scripting {-}



# Control structures

<br/><small><a href="javascript:if(window.print)window.print()">Print this chapter</a></small>



## Conditional statements

Conditional statements are fundamental in (procedural) programming, as they allow to execute or not execute part of a procedure depending on whether a certain condition is true. The condition is tested, and the part of the procedure to execute in the case the condition is true is included in a *code block*.


```r
temperature <- 25

if (temperature > 25) {
  cat("It really warm today!")
}
```

A simple conditional statement can be created using `if` as in the example above. A more complex structure can be created using both `if` and `else` to provide not only a procedure to execute in case the condition is true but also an alternative procedure to be executed when the condition is false.


```r
temperature <- 12

if (temperature > 25) {
  cat("It really warm today!")
} else {
  cat("Today is not warm")
}
```

```
## Today is not warm
```

Finally, conditional statements can be **nested**. That is, a conditional statement can be included as part of the code block to be executed after the condition is tested. For instance, in the example below, a second conditional statement is included in the code block to be executed in the case the condition is false.


```r
temperature <- -5

if (temperature > 25) {
  cat("It really warm today!")
} else {
  if (temperature > 0) {
    cat("There is a nice temperature today")
  } else {
    cat("This is really cold!")
  }
}
```

```
## This is really cold!
```

Similarly, one of the examples seen in the lecture should be coded as follows.


```r
a_value <- -7

if (a_value == 0) {
  cat("Zero")
} else {
  if (a_value < 0) {
    cat("Negative") 
  } else {
    cat("Positive")
  }
}
```

```
## Negative
```

Alternatively, the same set of conditions can be rewritten as follows.


```r
a_value <- -7

if (a_value < 0) {
    cat("Negative") 
} else if (a_value == 0) {
  cat("Zero")
} else {
  cat("Positive")
}
```

```
## Negative
```

The choice of how to structure the conditions depends only on the logic behind the code that you are aiming to execute and the nature and order of the operations that need to be executed.



## Loops

Loops are another core component of (procedural) programming and implement the idea of solving a problem or executing a task by performing the same set of steps a number of times.  There are two main kinds of loops in R - **deterministic** and **conditional** loops.  The former is executed a fixed number of times,  specified at the beginning of the loop.  The latter is executed until a specific condition is met. Both deterministic and conditional loops are extremely important in working with vectors.


### Conditional Loops

In R, conditional loops can be implemented using `while` and `repeat`. The difference between the two is mostly syntactical: the first tests the condition first and then execute the related code block if the condition is true; the second executes the code block until a `break` command is given (usually through a conditional statement).


```r
a_value <- 0
# Keep printing as long as x is smaller than 2
while (a_value < 2) {
  cat(a_value, "\n")
  a_value <- a_value + 1
}
```

```
## 0 
## 1
```


```r
a_value <- 0
# Keep printing, if x is greater or equal than 2 than stop
repeat {
  cat(a_value, "\n")
  a_value <- a_value + 1
  if (a_value >= 2) break
}
```

```
## 0 
## 1
```

Conditional loops can be a source of issues within a script. If they are not accurately designed, they can enter into an infinite loop -- for instance if the `while` condition is always `TRUE` or if the `break` condition within `repeat` always `FALSE`. 


### Deterministic Loops

The deterministic loop executes the subsequent code block iterating through the elements of a provided vector. During each iteration (i.e., execution of the code block), the current element of the vector is assigned to the variable in the statement, and it can be used in the code block.

It is, for instance, possible to iterate over a vector and print each of its elements.


```r
east_midlands_cities <- c("Derby", "Leicester", "Lincoln", "Nottingham")

for (city in east_midlands_cities){
  cat(city, "\n")
}
```

```
## Derby 
## Leicester 
## Lincoln 
## Nottingham
```

It is common practice to create a vector of integers on the spot (e.g., using the `:` operator) to execute a certain sequence of steps a pre-defined number of times.


```r
for (iterator in 1:3) {
  cat("Exectuion number", iterator, ":\n")
  cat("    Step1: Hi!\n")
  cat("    Step2: How is it going?\n")
}
```

```
## Exectuion number 1 :
##     Step1: Hi!
##     Step2: How is it going?
## Exectuion number 2 :
##     Step1: Hi!
##     Step2: How is it going?
## Exectuion number 3 :
##     Step1: Hi!
##     Step2: How is it going?
```


## Example: multiple Shapiro–Wilk tests

As seen during the lecture, it is possible to use control structures to scale up your analysis and design the code in a way so that an analysis step is executed on different data. The code below is a variation on what seen in class, and it illustrates how to conduct a simple analysis of the normal distribution of different sections of the input data.



```r
library(tidyverse)
library(magrittr)
library(knitr)
```


```r
leicester_2011OAC <- read_csv("2011_OAC_Raw_uVariables_Leicester.csv")
```



The chunck below ises the option `results = 'asis'`, which allows to interpret the output as Markdown code. That allows to translate the presence of `###` near the supergroup name into a third-level heading in the output.


```r
for (
  
  current_supgrp in
    # Extract the list of unique supergroup names
    leicester_2011OAC %>% 
      pull(supgrpname) %>% 
      unique()
  
  ) {
  
  # Print supergroup name
  cat("\n\n")
  cat(
    # Use a markdown heading
    # including some space above and blow it
    "###",
    current_supgrp,
    "\n\n"
  )
  
  # Run a Shapiro–Wilk test
  current_shapiro_test <-
    leicester_2011OAC %>% 
    filter(supgrpname == current_supgrp) %>% 
    pull(Total_Population) %>%
    shapiro.test()
  
  # Extract p value
  current_p_value <-
    current_shapiro_test %$% 
    p.value
  
  # Print whether the distribution
  # is significant or not
  if (current_p_value > 0.01){
    cat(
      "\n\n",
      "The total population",
      "of OA in Leicester",
      "in areas classified as",
      current_supgrp,
      "is normally distributed",
      "\n\n"
    )
  } else {
    cat(
      "\n\n",
      "The total population",
      "of OA in Leicester",
      "in areas classified as",
      current_supgrp,
      "is not normally distributed",
      "\n\n"
    )
  }
  
  # Create an histogram
  current_hist <-
    leicester_2011OAC %>% 
    filter(supgrpname == current_supgrp) %>% 
    ggplot(aes(
      x = Total_Population
    )) +
    geom_histogram() +
    ggtitle(current_supgrp) +
    theme_bw() 
  
  # Print the histogram
  print(current_hist)
  
  cat("\n\n")
  
}
```



### Suburbanites 



 The total population of OA in Leicester in areas classified as Suburbanites is normally distributed 

<img src="401-control-structures_files/figure-html/unnamed-chunk-13-1.png" width="672" />



### Cosmopolitans 



 The total population of OA in Leicester in areas classified as Cosmopolitans is not normally distributed 

<img src="401-control-structures_files/figure-html/unnamed-chunk-13-2.png" width="672" />



### Multicultural Metropolitans 



 The total population of OA in Leicester in areas classified as Multicultural Metropolitans is not normally distributed 

<img src="401-control-structures_files/figure-html/unnamed-chunk-13-3.png" width="672" />



### Ethnicity Central 



 The total population of OA in Leicester in areas classified as Ethnicity Central is normally distributed 

<img src="401-control-structures_files/figure-html/unnamed-chunk-13-4.png" width="672" />



### Constrained City Dwellers 



 The total population of OA in Leicester in areas classified as Constrained City Dwellers is normally distributed 

<img src="401-control-structures_files/figure-html/unnamed-chunk-13-5.png" width="672" />



### Hard-Pressed Living 



 The total population of OA in Leicester in areas classified as Hard-Pressed Living is normally distributed 

<img src="401-control-structures_files/figure-html/unnamed-chunk-13-6.png" width="672" />



### Urbanites 



 The total population of OA in Leicester in areas classified as Urbanites is normally distributed 

<img src="401-control-structures_files/figure-html/unnamed-chunk-13-7.png" width="672" />



---

<small>by [Stefano De Sabbata](https://sdesabbata.github.io/) -- text licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence), code licensed under the [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html).</small>
