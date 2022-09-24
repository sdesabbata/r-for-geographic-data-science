# Working with functions

<br/><small>*This chapter is currently a draft.*</small>

<br/><small><a href="javascript:if(window.print)window.print()">Print this chapter</a></small>

This chapter discusses some of the fundamental building blocks of programming and how they are implemented in `R`. The sections below introduce **vectors** -- which are complex `R` objects that can hold more than one value -- and how to handle them. ... we start the chapter by introducing **scripts**.


## Function definition

Recall from the previous chapter that *an* **algorithm** *or effective procedure is a mechanical rule, or automatic method, or programme for performing some mathematical operation* (Cutland, 1980, p. 7[@cutland_1980]). A **program** is a specific set of instructions that implement an abstract algorithm. The definition of an algorithm (and thus a program) can consist of one or more **function**s, which are sets of instructions that perform a task, possibly using an input, possibly returning an output value.

The code below is a simple function with one parameter. The function simply calculates the square root of a number. Add the code below to your script and run that portion of the script (or type the code into the Console). 


```r
cube_root <- function (input_value) {
   result <- input_value ^ (1 / 3)
   result
}
```

Once the definition of a function has been executed, the function becomes part of the environment, and it should be visible in the Environment panel in a subsection titled *Functions*. Thereafter, the function can be called from the Console, from other portions of the script, as well as from other scripts.

If you type the instruction below in the *Console*, or add it to the script and run it, the function is called using `27` as an argument, thus returning `3`.


```r
cube_root(27)
```

```
## [1] 3
```


### Functions and control structures

One issue when writing functions is making sure that the data that has been given to the data is the right kind. For example, what happens when you try to compute the cube root of a negative number?


```r
cube_root(-343)
```

```
## [1] NaN
```

That probably wasn't the answer you wanted, as `NaN` (*Not a Number*) is the value returned when a mathematical expression is numerically indeterminate.  In this case,  this is actually due to a shortcoming with the `^` operator in R,  which only works for positive base values.  In fact -7 is a perfectly valid cube root of -343,  since (-7)x(-7)x(-7) = -343.  

To work around this limitation, we can state a conditional rule:

- If `x < 0`: calculate the cube root of x 'normally'.
- Otherwise: work out the cube root of the positive number,  then change it to negative.


Those kinds of situations can be dealt with in an R function by using an `if` statement, as shown below. Note how the operator `-` (i.e., the symbol minus) is here used to obtain the inverse of a number, in the same way as `-1` is the inverse of the number `1`.
 

```r
cube_root <- function (input_value) {
    if (input_value >= 0){
        result <- input_value^(1 / 3) 
    }else{
        result <- -( (-input_value)^(1/3) )
    }
    result
}

cube_root(343)
cube_root(-343)
```

However, other things can go wrong. For example, `cube_root("Leicester")` would cause an error to occur, `Error in x^(1 / 3) : non-numeric argument to binary operator`. That shouldn't be surprising because cube roots only make sense for numbers,  not character variables.  Thus, it might be helpful if the cube root function could spot this and print a warning explaining the problem,  rather than just crashing with a fairly cryptic error message such as the one above,  as it does at the moment.

The function could be re-written to making use of `is.numeric` in a second conditional statement. If the input value is not numeric, the function returns the value `NA` (*Not Available*) instead of a number. Note that here there is an `if` statement inside another `if` statement, as it is always possible to nest code blocks -- and `if` within a `for` within a `while` within an `if` within ... etc.


```r
cube_root <- function (input_value) { 
    if (is.numeric(input_value)) {
        if (input_value >= 0){
            result <- input_value^(1/3) 
        }else{
            result <- -(-input_value)^(1/3)
        }
        result
    }else{
        cat("WARNING: Input variable must be numeric\n") 
        NA
    }
}
```

Finally, `cat` is a printing function that instructs R to display the provided argument (in this case, the phrase within quotes) as output in the Console. The `\n` in `cat` tells R to add a *newline* when printing out the warning.



## Exercise 114.2

**Question 114.2.1:** Write a function that calculates the areas of a circle, taking the radius as the first parameter.

**Question 114.2.2:** Write a function that calculates the volume of a cylinder, taking the radius of the base as the first parameter and the height as the second parameter. The function should call the function defined above and multiply the returned value by the height to calculate the result.

**Question 114.2.3:** Write a function with two parameters, a vector of numbers and a vector of characters (text). The function should check that the input has the correct data type. If all the numbers in the first vector are greater than zero, return the elements of the second vector from the first to the length of the first vector. 

<!--
**Question 6.1.4:** Write a function to compute and print out `gcd(x,60)`  for `x` in the range 1 to `n`.  When this is done,  write another function to compute and print out `gcd(x,y)` for `x` in the range 1 to `n1` and `y` in the range 1 to `n2`.  *Hint:* for this exercise you need to nest one deterministic loop inside another one.  As an additional exercise,  try to modify the `cube_root` function so that it computes the cube root of each element from 0.5 in steps of 0.5 to `n`.
-->

## R Scripts

The RStudio Console is handy to interact with the `R` interpreter and obtain results of operations and commands. However, moving from simple instructions to an actual program or script to conduct data analysis, the Console is usually not sufficient anymore. In fact, the Console is not a very comfortable way of providing long and complex instructions to the interpreter. For instance, it doesn't easily allow you to overwrite past instructions when you want to change something in your procedure. A better option to create programs or data analysis scripts of any significant size is to use the RStudio integrated editor to create an `R` script.

To create an `R` script, select from the top menu *File > New File > R Script*. That opens the embedded RStudio editor and a new empty `R` script folder. Copy the two lines below into the file. The first loads the `tidyverse` library, whereas the second simply calculates the square root of two.


```r
# Load the Tidyverse
library(tidyverse)

# Calculate the square root of two
2 %>% sqrt()
```

```
## [1] 1.414214
```

As you can see, a comment precedes each line, describing what the subsequent command does. Adequately commenting the code is a fundamental practice in programming. As this is a learning resource, the comments in the examples below explain *"what"* the subsequent lines of code do. However, comments should generally focus on *"how"* a procedure (i.e., an algorithm) is implemented in a set of instructions (i.e., a section of the script) and crucially on *"why"* the procedure has been implemented in a specific way. We will see more complex examples in the rest of this book.

From the top menu, select *File > Save*, type in `My_first_script.R` (make sure to include the underscore and the `.R` extension) as *File name*, and click *Save*. Finally, click the *Source* button on the top-right of the editor. 

Congratulations, you have executed your first `R` script! 😊👍

You can then edit the script by adding (for instance) the new lines of code shown below, saving the file, and executing the script's new version.

**Self-test question**: What happens if you click the *Source* button again and thus execute the new version of the script? What happens if you click *Source* a third time?


```r
# First variable in a script:
# the line below uses the Sys.time of the base library 
# to obtain the current time as a character string
current_time <- Sys.time()
```

RStudio also allows to select one or more lines and click *Run* to execute only the selected lines or the line where the cursor currently is.

Delete the two lines calculating the square root of two and defining the variable `a_variable` from the script, leaving only the line loading the Tidyverse library. In the following sections, add the code to the script to execute it, rather than using the Console.



---

<small>by [Stefano De Sabbata](https://sdesabbata.github.io/) -- text licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence), code licensed under the [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html).</small>
