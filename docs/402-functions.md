# Working with functions

<br/><small><a href="javascript:if(window.print)window.print()">Print this chapter</a></small>


## Function definition

Recall from the first chapter that *an* **algorithm** *or effective procedure is a mechanical rule, or automatic method, or programme for performing some mathematical operation* (Cutland, 1980, p. 7[@cutland_1980]). A **program** is a specific set of instructions that implement an abstract algorithm. The definition of an algorithm (and thus a program) can consist of one or more **function**s, which are sets of instructions that perform a task, possibly using an input, possibly returning an output value.

The code below presents two versions of a simple function with one parameter. The function simply calculates the square root of a number and returns a value with two digits.


```r
library(tidyverse)

sqrt_2digits <- 
  function (input_value) {
    sqrt_value <- sqrt(input_value)
    rounded_value <- round(sqrt_value, digits = 2)
    rounded_value
  }

sqrt_2digits_pipe <- 
  function (input_value) {
    input_value %>% 
      sqrt() %>% 
      round(digits = 2)
  }
```

Once the definition of a function has been executed, the function becomes part of the environment, and it should be visible in the Environment panel in a subsection titled *Functions*. Thereafter, the function can be called from the Console, from other portions of the script, as well as from other scripts.


```r
sqrt_2digits(2)
```

```
## [1] 1.41
```

```r
sqrt_2digits_pipe(2)
```

```
## [1] 1.41
```


### Functions and control structures

One issue when writing functions is making sure that the data that has been given to the data is the right kind. For example, what happens when you try to compute the cube root of a negative number using a function as defined below?


```r
cube_root <- function (input_value) {
   result <- input_value ^ (1 / 3)
   result
}

cube_root(-343)
```

```
## [1] NaN
```

That probably wasn't the answer you wanted, as `NaN` (*Not a Number*) is the value returned when a mathematical expression is numerically indeterminate.  In this case,  this is actually due to a shortcoming with the `^` operator in R,  which only works for positive base values.  In fact $-7$ is a perfectly valid cube root of $-343$,  since $(-7)\times(-7)\times(-7) = -343$.  

To work around this limitation, we can state a conditional rule:

- If `x < 0`
  - calculate the cube root of x 'normally'.
- Otherwise: 
  - work out the cube root of the positive number,  then change it to negative.

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

Remember, `cat` is a printing function that instructs R to display the provided argument (in this case, the phrase within quotes) as output in the Console. The `\n` in `cat` tells R to add a *newline* when printing out the warning.



## Debugging

The term *bug* is commonly used in computer science to refer to an error, failure, or fault in a system. The term ``debugging'' in programming thus refers to the procedure of searching for mistakes in the code. This procedure can be simply done by re-reading and revising the written code, but R provides a useful command called `debug`, that allows you to follow the execution of the code, and more easily identify mistakes.

Try debugging the function - since it is working properly,  you won't (hopefully!) find any errors,  but that will demonstrate the debug facility, by typing `debug(cube_root)` in the RStudio *Console*.  That tells R that you want to run `cube_root` in debug mode.  Next enter `cube_root(-50)` in the RStudio *Console* and see how repeatedly pressing the return key steps you through the function.  Note particularly what happens at the `if` statement.  

At any stage in the process, you can type an R expression to check its value.  For instance, when you get to the `if` statement, you can enter `input_value > 0` in the RStudio *Console* to see whether it is true or false.  Checking the value of expressions at various points when stepping through the code is a good way of identifying potential bugs or glitches in your code.  Try running through the code for a few other cube root calculations,  by replacing -50 above with different numbers,  to get used to using the debugging facility.  

When you are done, enter `undebug(cube_root)`. That tells R that you are ready to return `cube_root` to running in normal mode.  For further details about the debugger,  enter `help(debug)` in the RStudio *Console*.



## Writing functions for dplyr

The functions defined above are base R function, which not designed to work within the Tidyverse. Each one of the input is expected to be a number, although it can be applied to a vector. The functions are not designed to expect a dataframe or tibble as first argument (as Tidyverse functions such as `select` or `mutate`) and they are not designed to use the non-standard evaluation typical of the Tidyverse -- i.e., when column names are provided as variable names, not as strings with quotes.

The [Programming with dplyr](https://dplyr.tidyverse.org/articles/programming.html) article on the `dplyr` pages explains the process in full detail and it was the source of information for this section. To greatly simplify, to design functions for the Tidyverse, functions should expect the first argument to be a tibble (or dataframe). All the parameters that expect column names as argument using the non-standard evaluation need to be used while **embracing** them with doubled braces `{{`. Furthermore, in order to create output column names using the input column names the operator `:=` must be used as illustrated below. Any additional paramenter can be provided as normal.

The example below defines a function named `percentage_of`, which calculates a new column which is the percentage of a column based on another column as total. The first parameter `data` expects a dataframe or tibbe as argument, while the two subsequent parameters expect column names to be used through non-standard evaluation. The function uses a `mutate` to add a new column. The new column is defined using the `:=` operator and the name os `perc_` followed by a column names, followed by `_over_` and the name of the column used as total. The first and total columns are then used embraced with `{{`, dividing one by the other and finally multipled by a hundred.


```r
percentage_of <- 
  function (data, var_col, total_col) {
    data %>%
      mutate(
        "perc_{{var_col}}" :=
          ({{ var_col }} / {{ total_col }}) * 100
      )
  }
```

The function can then be used to calculated the percentage of people in Leicester commuting to work using private transport (`u121` in the 2011 Output Area Classification dataset seen in previous chapters), using the `Total_Pop_No_NI_Students_16_to_74` as total. The first example below shows the procedure without the function. The second example shows the procedure using the function.


```r
leicester_2011OAC <- read_csv("2011_OAC_Raw_uVariables_Leicester.csv")
```




```r
library(knitr)

leicester_2011OAC %>%
  select(
    OA11CD, u121, Total_Pop_No_NI_Students_16_to_74
  ) %>%
  mutate(
    perc_u121 = 
      (u121 / Total_Pop_No_NI_Students_16_to_74) * 100
  ) %>%
  slice_head(n = 5) %>% 
  kable()
```



|OA11CD    | u121| Total_Pop_No_NI_Students_16_to_74| perc_u121|
|:---------|----:|---------------------------------:|---------:|
|E00069517 |  113|                               225|  50.22222|
|E00069514 |  102|                               287|  35.54007|
|E00169516 |   94|                               282|  33.33333|
|E00169048 |  111|                               227|  48.89868|
|E00169044 |  110|                               231|  47.61905|

```r
leicester_2011OAC %>%
  select(
    OA11CD, u121, Total_Pop_No_NI_Students_16_to_74
  ) %>%
  percentage_of(
    u121, Total_Pop_No_NI_Students_16_to_74
  ) %>%
  slice_head(n = 5) %>% 
  kable()
```



|OA11CD    | u121| Total_Pop_No_NI_Students_16_to_74| perc_u121|
|:---------|----:|---------------------------------:|---------:|
|E00069517 |  113|                               225|  50.22222|
|E00069514 |  102|                               287|  35.54007|
|E00169516 |   94|                               282|  33.33333|
|E00169048 |  111|                               227|  48.89868|
|E00169044 |  110|                               231|  47.61905|



## Loading R scripts

A key reason for writing functions is that you can write them once and they use them any time you need them. That is the principle behind the creation of libraries, which are (mostly) collections of functions. To that purpose, it is possible to write functions in an R script and then load that script (and all functions there defined) fromanother script or RMarkdown document -- in a fashion similar to when a library is loaded. Create a new R script named `my_useful_functions.R` (as seen in [this section](reproducible-data-science.html#r-scripts)), copy the code below in that R script and save the file.


```r
library(tidyverse)

percentage_of <- 
  function (data, var_col, total_col) {
    data %>%
      mutate(
        "perc_{{var_col}}" :=
          ({{ var_col }} / {{ total_col }}) * 100
      )
  }
```

Create a new RMarkdown document and copy-paste the code below in the new document.


```r
library(tidyverse)

source("my_useful_functions.R")

leicester_2011OAC <- read_csv("2011_OAC_Raw_uVariables_Leicester.csv")

leicester_2011OAC %>%
  select(
    OA11CD, u121, Total_Pop_No_NI_Students_16_to_74
  ) %>%
  percentage_of(
    u121, Total_Pop_No_NI_Students_16_to_74
  ) %>%
  slice_head(n = 5) %>% 
  kable()
```

When knitted, the new document uses `source` to instruct the interpreter load and run the code in `my_useful_functions.R` script, thus loading the definition of the `percentage_of` function. The rest of the code then load the 2011 OAC data and invokes the function within the pipe. That is a simple example, but this can be an extremely powerful tool to create your own library of functions to be used by different scripts.



---

<small>by [Stefano De Sabbata](https://sdesabbata.github.io/) -- text licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence), code licensed under the [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html).</small>
