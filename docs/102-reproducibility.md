# Reproducible data science

<br/><small><a href="javascript:if(window.print)window.print()">Print this chapter</a></small>


## Data science

Singleton and Arribas-Bel define "geographic data science" as a space that *"effectively combines the long-standing tradition and epistemologies of Geographic Information Science and Geography with many of the recent advances that have given Data Science its relevance in an emerging 'datafied' world"* (Singleton and Arribas-Bel, 2021, p67[@singleton2021geographic]). In particular, they argue that "data science" emerged as a term to indicate the use of statistical and visual analytics tool to study a world where the digitalisation of everyday life resulted in a "data deluge" commonly referred to as "big data"[@kitchin2014data]. The academic debate about the historical and epistemological background of the term "data science" is quite complex, but the term has now acquired wide-spread usage.

As such, "data science" is commonly used to refer to a set of tools and approaches to analysing data, including statistical analysis, visualisation and (what used to be referred to as) data mining. Data science also overlaps with the field of machine learning, which is a part of artificial intelligence and includes methods normally under the umbrella of statistics. If, at this point, you are confused, don't worry, that's quite normal. These definitions are frequently debated and frequently prone to become [buzzwords](https://en.wikipedia.org/wiki/Buzzword).

This book focuses on an introduction to data science using R and a focus on geographic themes, although not necessarily using spatial analysis (i.e., when spatial relationships are part of the computation), which is covered in another module and wonderful books such as  [*An Introduction to R for Spatial Analysis and Mapping*](https://uk.sagepub.com/en-gb/eur/an-introduction-to-r-for-spatial-analysis-and-mapping/book241031) by Chris Brunsdon and Lex Comber and [*Geocomputation with R*](https://geocompr.robinlovelace.net/) by Robin Lovelace, Jakub Nowosad and Jannes Muenchow.


### R Scripts

The RStudio Console is handy to interacting with the `R` interpreter and obtain results of operations and commands. However, moving from simple instructions to an actual program or script to conduct data analysis, the Console is usually not sufficient anymore. In fact, the Console is not a very comfortable way of providing long and complex instructions to the interpreter. For instance, it doesn't easily allow you to overwrite past instructions when you want to change something in your procedure. A better option to create programs or data analysis scripts of any significant size is to use the RStudio integrated editor to create an `R` script.

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

From the top menu, select *File > Save*, type in `my-first-script.R` (make sure to include the underscore and the `.R` extension) as *File name*, and click *Save*. Finally, click the *Source* button on the top-right of the editor. 

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

Delete the two lines calculating the square root of two and defining the variable `a_variable` from the script, leaving only the line loading the Tidyverse library. In the following sections, add the code to the script to execute it rather than using the Console.

## Complex data types

Create a new empty R script following the procedure above and save it as `practical-102_my-script-001.R`. While reading the rest of this section, copy the new code in the script and use *Run* to execute the single instructions.

### Vectors

Programming languages commonly provide both simple data types, such as those seen in the previous chapter, and more complex objects capable of storing and organising multiple values. The simplest of those complex objects allow storing multiple values of the same type in an ordered list. Such objects take different names in different languages. In `R`, they are referred to as **vectors**^[The term *list* has a specific meaning in `R`. Don't use the term *list* to refer to *vectors*.].

Vectors can be defined in R by using the function `c`, which takes as parameters the items to be stored in the vector. The items are stored in the order in which they are provided. 


```r
east_midlands_cities <- c("Derby", "Leicester", "Lincoln", "Nottingham")
length(east_midlands_cities)
```

```
## [1] 4
```

Once the vector has been created and assigned to an identifier, the elements within the vector can be retrieved by specifying the identifier, followed by square brackets and the *index* (or indices as we will see further below) of the elements to be retrieved. Indices start from `1`, so the index of the first element is `1`, the index of the second element is `2`, and so on and so forth^[That is different from many programming languages, where the index of the first element is `0`.].


```r
# Retrieve the third city
east_midlands_cities[3]
```

```
## [1] "Lincoln"
```

To retrieve any subset of a vector (i.e., more than one element), you can specify an integer vector containing the indices (rather than a single integer value) of the items of interest between square brackets. 


```r
# Retrieve first and third city
east_midlands_cities[c(1, 3)]
```

```
## [1] "Derby"   "Lincoln"
```

The operator `:` can be used to create integer vectors, starting from the number specified before the operator to the number specified after the operator. 


```r
# Create a vector containing integers between 2 and 4
two_to_four <- 2:4
two_to_four
```

```
## [1] 2 3 4
```

```r
# Retrieve cities between the second and the fourth
east_midlands_cities[two_to_four]
```

```
## [1] "Leicester"  "Lincoln"    "Nottingham"
```

```r
# As the second element of two_to_four is 3...
two_to_four[2]
```

```
## [1] 3
```

```r
# the following command will retrieve the third city
east_midlands_cities[two_to_four[2]]
```

```
## [1] "Lincoln"
```

```r
# Create a vector with cities from the previous vector
selected_cities <- c(east_midlands_cities[1], east_midlands_cities[3:4])
```


The functions `seq` and `rep` can also be used to create vectors, as illustrated below.


```r
seq(1, 10, by = 0.5)
```

```
##  [1]  1.0  1.5  2.0  2.5  3.0  3.5  4.0  4.5  5.0  5.5  6.0  6.5  7.0  7.5  8.0
## [16]  8.5  9.0  9.5 10.0
```

```r
seq(1, 10, length.out = 6)
```

```
## [1]  1.0  2.8  4.6  6.4  8.2 10.0
```

```r
rep("Ciao", 4)
```

```
## [1] "Ciao" "Ciao" "Ciao" "Ciao"
```


The logical operators `any` and `all` can be used to test conditions on the vector. The former returns `TRUE` if at least one element satisfies the statement and the second returns `TRUE` if all elements satisfy the condition


```r
any(east_midlands_cities == "Leicester")
```

```
## [1] TRUE
```

```r
my_sequence <- seq(1, 10, length.out = 7)
my_sequence
```

```
## [1]  1.0  2.5  4.0  5.5  7.0  8.5 10.0
```

```r
any(my_sequence > 5)
```

```
## [1] TRUE
```

```r
all(my_sequence > 5)
```

```
## [1] FALSE
```


Functions and operators can be applied to vectors in the same way as they would be applied to simple values. For instance, all built-in numerical functions in R can be used on a vector variable directly. That is, if a vector is specified as input, the selected function is applied to each element of the vector.


```r
one_to_ten <- 1:10
one_to_ten
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

```r
one_to_ten + 1
```

```
##  [1]  2  3  4  5  6  7  8  9 10 11
```

```r
sqrt(one_to_ten)
```

```
##  [1] 1.000000 1.414214 1.732051 2.000000 2.236068 2.449490 2.645751 2.828427
##  [9] 3.000000 3.162278
```

Similarly, string functions can be applied to vectors containing character values. For instance, the code below uses `str_length` to obtain a vector of numeric values representing the lengths of the city names included in the vector of character values `east_midlands_cities`.


```r
str_length(east_midlands_cities)
```

```
## [1]  5  9  7 10
```

#### Selecting and filtering vectors

As seen in the previous chapter, a condition entered in the Console is evaluated for the provided input, and a logical value (`TRUE` or `FALSE`) is provided as output. Similarly, if the provided input is a vector, the condition is evaluated for each element of the vector, and a vector of logical values is returned -- which contains the respective results of the conditions for each element.


```r
minus_three <- -3
minus_three > 0
```

```
## [1] FALSE
```

```r
minus_three_to_three <- -3:3
minus_three_to_three
```

```
## [1] -3 -2 -1  0  1  2  3
```

```r
minus_three_to_three > 0
```

```
## [1] FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE
```

A subset of the elements of a vector can also be selected by providing a vector of logical values between brackets after the identifier. A new vector is returned, containing only the values for which a `TRUE` value has been specified correspondingly.


```r
minus_two_to_two <- -2:2
minus_two_to_two
```

```
## [1] -2 -1  0  1  2
```

```r
minus_two_to_two[c(TRUE, TRUE, FALSE, FALSE, TRUE)]
```

```
## [1] -2 -1  2
```

As the result of evaluating the condition on a vector is a vector of logical values, this can be used to filter vectors based on conditions. If a condition is provided between square brackets (after the vector identifier instead of an index), a new vector is returned, which contains only the elements for which the condition is true. 


```r
minus_two_to_two > 0
```

```
## [1] FALSE FALSE FALSE  TRUE  TRUE
```

```r
minus_two_to_two[minus_two_to_two > 0]
```

```
## [1] 1 2
```




### Factors

A **factor** is a data type similar to a vector. However, the values contained in a factor can only be selected from a set of **levels**.


```r
houses_vector <- c("Bungalow", "Flat", "Flat",
  "Detached", "Flat", "Terrace", "Terrace")
houses_vector
```

```
## [1] "Bungalow" "Flat"     "Flat"     "Detached" "Flat"     "Terrace"  "Terrace"
```

```r
houses_factor <- factor(c("Bungalow", "Flat", "Flat",
  "Detached", "Flat", "Terrace", "Terrace"))
houses_factor
```

```
## [1] Bungalow Flat     Flat     Detached Flat     Terrace  Terrace 
## Levels: Bungalow Detached Flat Terrace
```

The function **table** can be used to obtain a tabulated count for each level.


```r
houses_factor <- factor(c("Bungalow", "Flat", "Flat",
  "Detached", "Flat", "Terrace", "Terrace"))
houses_factor
```

```
## [1] Bungalow Flat     Flat     Detached Flat     Terrace  Terrace 
## Levels: Bungalow Detached Flat Terrace
```

```r
table(houses_factor)
```

```
## houses_factor
## Bungalow Detached     Flat  Terrace 
##        1        1        3        2
```

A specific set of levels can be specified when creating a factor by providing a **levels** argument.


```r
houses_factor_spec <- factor(
  c("People Carrier", "Flat", "Flat", "Hatchback",
      "Flat", "Terrace", "Terrace"),
  levels = c("Bungalow", "Flat", "Detached",
       "Semi", "Terrace"))

table(houses_factor_spec)
```

```
## houses_factor_spec
## Bungalow     Flat Detached     Semi  Terrace 
##        0        3        0        0        2
```

In statistics terminology, (unordered) factors are **categorical** (i.e., binary or nominal) variables. Levels are not ordered.


```r
income_nominal <- factor(
  c("High", "High", "Low", "Low", "Low",
      "Medium", "Low", "Medium"),
  levels = c("Low", "Medium", "High"))
```

The *greater than* operator is not meaningful on the `income_nominal` factor defined above.


```r
income_nominal > "Low"
```

```
## Warning in Ops.factor(income_nominal, "Low"): '>' not meaningful for factors
```

```
## [1] NA NA NA NA NA NA NA NA
```

In statistics terminology, ordered factors are **ordinal** variables. Levels are ordered.


```r
income_ordered <- ordered(
  c("High", "High", "Low", "Low", "Low",
      "Medium", "Low", "Medium"),
  levels = c("Low", "Medium", "High"))

income_ordered > "Low"
```

```
## [1]  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE
```

```r
sort(income_ordered)
```

```
## [1] Low    Low    Low    Low    Medium Medium High   High  
## Levels: Low < Medium < High
```


### Lists

Variables of the type **list** can contain elements of different types (including vectors and matrices), whereas elements of vectors are all of the same type. 


```r
employee <- list("Stef", 2015)
employee
```

```
## [[1]]
## [1] "Stef"
## 
## [[2]]
## [1] 2015
```

```r
employee[[1]] # Note the double square brackets for selection
```

```
## [1] "Stef"
```

In **named lists** each element has a name, and elements can be selected using their name after the symbol `$`. 


```r
employee <- list(employee_name = "Stef", start_year = 2015)
employee
```

```
## $employee_name
## [1] "Stef"
## 
## $start_year
## [1] 2015
```

```r
employee$employee_name
```

```
## [1] "Stef"
```


### Data frames and tibbles

As mentioned in the previous chapter, **data frames** are complex data types which encode the concept of a table in R by combining and arranging together a series of simple objects. Data frames are similar to named lists, where each element of the list is a vector representing a column and all vectors have the same length, thus representing the same number of rows.

#### Example: Flights that Departed NYC in 2013

RStudio and RStudio Server come with a number of libraries already pre-installed. However, you might find yourself in the position of wanting to install additional libraries to work with. The remainder of this chapter requires the library [`nycflights13`](https://cran.r-project.org/package=nycflights13), which contains a table listing all the flights that departed from New York City in 2013, and it is also the dataset used in the examples of your suggested reading ([*R for Data Science*, chapter 5](https://r4ds.had.co.nz/transform.html)) To install it, select *Tools > Install Packages...* from the top menu. Insert `nycflights13` in the *Packages (separate multiple with space or comma)* field and click install. RStudio will automatically execute the command `install.packages("nycflights13")` (so, no need to execute that yourself) and install the required library.

As usual, use the function `library` to load the newly installed library, along with the library `knitr`, which can be used to produce more nicely-formatted outputs.


```r
library(tidyverse)
library(nycflights13)
library(knitr)

flights
```

```
## # A tibble: 336,776 × 19
##     year month   day dep_time sched_de…¹ dep_d…² arr_t…³ sched…⁴ arr_d…⁵ carrier
##    <int> <int> <int>    <int>      <int>   <dbl>   <int>   <int>   <dbl> <chr>  
##  1  2013     1     1      517        515       2     830     819      11 UA     
##  2  2013     1     1      533        529       4     850     830      20 UA     
##  3  2013     1     1      542        540       2     923     850      33 AA     
##  4  2013     1     1      544        545      -1    1004    1022     -18 B6     
##  5  2013     1     1      554        600      -6     812     837     -25 DL     
##  6  2013     1     1      554        558      -4     740     728      12 UA     
##  7  2013     1     1      555        600      -5     913     854      19 B6     
##  8  2013     1     1      557        600      -3     709     723     -14 EV     
##  9  2013     1     1      557        600      -3     838     846      -8 B6     
## 10  2013     1     1      558        600      -2     753     745       8 AA     
## # … with 336,766 more rows, 9 more variables: flight <int>, tailnum <chr>,
## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
## #   minute <dbl>, time_hour <dttm>, and abbreviated variable names
## #   ¹​sched_dep_time, ²​dep_delay, ³​arr_time, ⁴​sched_arr_time, ⁵​arr_delay
```

Create a new empty R script following the procedure above and save it as `practical-102_my-script-002.R`. Start by adding the lines above to the new R script, and continue to add the code snippets provided below while you read.

#### Selecting and filtering tables

The approaches seen above for selecting and filtering data from vectors can be applied to data frames and tibbles. The only difference is that tables are bi-dimensional (rather than one-dimensional), and thus, two pieces of information are necessary. The first index specifies which rows to select or filter, and the second index specifies which columns to select or filter. If no information is provided for either the first or second index, all rows or columns are provided. However, as you can see from the examples below, the more complex the selection and filtering query become, the longer and less readable the code becomes.


```r
# Select the 5th row
flights[5, ]
```

```
## # A tibble: 1 × 19
##    year month   day dep_time sched_dep…¹ dep_d…² arr_t…³ sched…⁴ arr_d…⁵ carrier
##   <int> <int> <int>    <int>       <int>   <dbl>   <int>   <int>   <dbl> <chr>  
## 1  2013     1     1      554         600      -6     812     837     -25 DL     
## # … with 9 more variables: flight <int>, tailnum <chr>, origin <chr>,
## #   dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>, minute <dbl>,
## #   time_hour <dttm>, and abbreviated variable names ¹​sched_dep_time,
## #   ²​dep_delay, ³​arr_time, ⁴​sched_arr_time, ⁵​arr_delay
```

```r
# Select the 3rd column
flights[, 4]
```

```
## # A tibble: 336,776 × 1
##    dep_time
##       <int>
##  1      517
##  2      533
##  3      542
##  4      544
##  5      554
##  6      554
##  7      555
##  8      557
##  9      557
## 10      558
## # … with 336,766 more rows
```

```r
# Select the departure time column
flights[, "dep_time"]
```

```
## # A tibble: 336,776 × 1
##    dep_time
##       <int>
##  1      517
##  2      533
##  3      542
##  4      544
##  5      554
##  6      554
##  7      555
##  8      557
##  9      557
## 10      558
## # … with 336,766 more rows
```

```r
# Select the origin, destination and departure time columns
flights[, c("origin", "dest", "dep_time")]
```

```
## # A tibble: 336,776 × 3
##    origin dest  dep_time
##    <chr>  <chr>    <int>
##  1 EWR    IAH        517
##  2 LGA    IAH        533
##  3 JFK    MIA        542
##  4 JFK    BQN        544
##  5 LGA    ATL        554
##  6 EWR    ORD        554
##  7 EWR    FLL        555
##  8 LGA    IAD        557
##  9 JFK    MCO        557
## 10 LGA    ORD        558
## # … with 336,766 more rows
```

```r
# Select the 5th row and 3rd column
flights[5, 4]
```

```
## # A tibble: 1 × 1
##   dep_time
##      <int>
## 1      554
```

```r
# Select the 5th to 10th rows 
# and origin, destination and departure time columns
flights[5:10, c("origin", "dest", "dep_time")]
```

```
## # A tibble: 6 × 3
##   origin dest  dep_time
##   <chr>  <chr>    <int>
## 1 LGA    ATL        554
## 2 EWR    ORD        554
## 3 EWR    FLL        555
## 4 LGA    IAD        557
## 5 JFK    MCO        557
## 6 LGA    ORD        558
```

```r
# Filter all rows where the flights departed at 5.54am
flights[flights$dep_time == 554, ]
```

```
## # A tibble: 8,932 × 19
##     year month   day dep_time sched_de…¹ dep_d…² arr_t…³ sched…⁴ arr_d…⁵ carrier
##    <int> <int> <int>    <int>      <int>   <dbl>   <int>   <int>   <dbl> <chr>  
##  1  2013     1     1      554        600      -6     812     837     -25 DL     
##  2  2013     1     1      554        558      -4     740     728      12 UA     
##  3    NA    NA    NA       NA         NA      NA      NA      NA      NA <NA>   
##  4    NA    NA    NA       NA         NA      NA      NA      NA      NA <NA>   
##  5    NA    NA    NA       NA         NA      NA      NA      NA      NA <NA>   
##  6    NA    NA    NA       NA         NA      NA      NA      NA      NA <NA>   
##  7  2013     1     2      554        600      -6     845     901     -16 B6     
##  8  2013     1     2      554        600      -6     841     851     -10 B6     
##  9  2013     1     2      554        600      -6     909     858      11 B6     
## 10    NA    NA    NA       NA         NA      NA      NA      NA      NA <NA>   
## # … with 8,922 more rows, 9 more variables: flight <int>, tailnum <chr>,
## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
## #   minute <dbl>, time_hour <dttm>, and abbreviated variable names
## #   ¹​sched_dep_time, ²​dep_delay, ³​arr_time, ⁴​sched_arr_time, ⁵​arr_delay
```

```r
# Filter all rows where the flights departed at 5.54am
# and origin, destination and departure time columns
flights[flights$dep_time == 554, c("origin", "dest", "dep_time")]
```

```
## # A tibble: 8,932 × 3
##    origin dest  dep_time
##    <chr>  <chr>    <int>
##  1 LGA    ATL        554
##  2 EWR    ORD        554
##  3 <NA>   <NA>        NA
##  4 <NA>   <NA>        NA
##  5 <NA>   <NA>        NA
##  6 <NA>   <NA>        NA
##  7 JFK    FLL        554
##  8 JFK    PBI        554
##  9 LGA    FLL        554
## 10 <NA>   <NA>        NA
## # … with 8,922 more rows
```
 
Fortunately, rather than working with base R instructions, we can use the `dplyr` library, which is part of the Tidyverse and offers a grammar for data manipulation. The function `select` can be used to select some **columns** to output. For instance, in the code below, the function `select` is used to select the columns `origin`, `dest`, and `dep_delay`, in combination with the function `slice_head`, which can be used to include only the first `n` rows (`5` in the example below) to output.


```r
flights %>%
  select(origin, dest, dep_delay) %>%
  slice_head(n = 5) %>%
  kable()
```



|origin |dest | dep_delay|
|:------|:----|---------:|
|EWR    |IAH  |         2|
|LGA    |IAH  |         4|
|JFK    |MIA  |         2|
|JFK    |BQN  |        -1|
|LGA    |ATL  |        -6|

The function `filter` can instead be used to filter **rows** based on a specified condition. In the example below, the output of the `filter` step only includes the rows where the value of `month` is `11` (i.e., the eleventh month, November). 


```r
flights %>%
  select(origin, dest, year, month, day, dep_delay) %>%
  filter(month == 11) %>%
  slice_head(n = 5) %>%
  kable()
```



|origin |dest | year| month| day| dep_delay|
|:------|:----|----:|-----:|---:|---------:|
|JFK    |PSE  | 2013|    11|   1|         6|
|JFK    |SYR  | 2013|    11|   1|       105|
|EWR    |CLT  | 2013|    11|   1|        -5|
|LGA    |IAH  | 2013|    11|   1|        -6|
|JFK    |MIA  | 2013|    11|   1|        -3|

Notice how `filter` is used in combination with `select`. All functions in the `dplyr` library can be combined in any other order that makes logical sense. However, if the `select` step didn't include `month`, that same column couldn't have been used in the `filter` step.


## Exercise 102.1

Extend the code in the script `practical-102_my-script-002.R` to include the code necessary to solve the questions below.

**Question 101.1.1:** Write a piece of code using the pipe operator and the `dplyr` library to generate a table showing the air time and the carrier, but only for flights starting from the JFK airport. As in the examples above, use `slice_head` and `kable` to output a nicely-formatted table containing only the first 10 rows.

**Question 102.1.2:** Write a piece of code using the pipe operator and the `dplyr` library to generate a table showing the arrival delay and the overall air time, but only for flights of October 12th. As in the examples above, use `slice_head` and `kable` to output a nicely-formatted table containing only the first 10 rows.

**Question 103.1.3:** Write a piece of code using the pipe operator and the `dplyr` library to generate a table showing the arrival delay, origin and destination, but only for flight leaving between 11am and 2pm. As in the examples above, use `slice_head` and `kable` to output a nicely-formatted table containing only the first 10 rows.



## Reproducibility


According to @gandrud2018reproducible, a quantitative analysis or project can be considered to be **reproducible** if: *"the data and code used to make a finding are available and they are sufficient for an independent researcher to recreate the finding"*. Reproducibility practices are rooted in software engineering, including project design practices (such as [Scrum](https://en.wikipedia.org/wiki/Scrum_(software_development))), software readability principles, testing and versioning.

In GIScience, programming was essential to interact with early GIS software such as [ArcInfo](https://en.wikipedia.org/wiki/ArcInfo) in the 1980s and 1990s, up until the release of the [ArcGIS 8.0](https://en.wikipedia.org/wiki/ArcGIS#ArcMap_8.0) suite in 1999, which included a graphical user interface. The past decade has seen a gradual return to programming and scripting in GIS, especially where languages such as R and Python allowed to combine GIS capabilities with much broader data science and machine learning functionalities. Many disciplines have seen a similar trajectory, and as programming and data science become more integral to science, reproducibility practices become a cornerstone of scientific development. 

Nowadays, many academic journals and conferences require some level of reproducibility when submitting a paper (e.g., see the [AGILE Reproducible Paper Guidelines](https://osf.io/numa5/) from the [Association of Geographic Information Laboratories in Europe](https://agile-online.org/)). Companies are keen on reproducible analysis, which is more reliable and more efficient in the long term. Second, as the amount of data increases, reproducible approaches effectively create reliable analyses that can be more easily verified and reproduced on different or new data. @doi:10.1080/13658816.2015.1137579 have discussed the issue of reproducibility in GIScience, identifying the following best practices:

1. *"Data should be accessible within the public domain and available to researchers"*.
2. *"Software used should have open code and be scrutable"*.
3. *"Workflows should be public and link data, software, methods of analysis and presentation with discursive narrative"*.
4. *"The peer review process and academic publishing should require submission of a workflow model and ideally open archiving of those materials necessary for replication"*.
5. *"Where full reproducibility is not possible (commercial software or sensitive data) aim to adopt aspects attainable within circumstances"*.

The rest of the chapter discusses three tools that can help you improve the reproducibility of your code: [Markdown](https://daringfireball.net/projects/markdown/), [RMarkdown](https://rmarkdown.rstudio.com/) and [Git](https://git-scm.com/).


### Markdown

An essential tool used in creating this book is [RMarkdown](https://rmarkdown.rstudio.com/), an R library that allows you to create scripts that mix the [Markdown](https://daringfireball.net/projects/markdown/) mark-up language and R, to create dynamic documents. RMarkdown script can be compiled, at which point the Markdown notation is interpreted to create the output files, while the R code is executed and the output incorporated in the document.

For instance, the following markdown code

```mark
[This is a link to the University of Leicester](http://le.ac.uk) and **this is in bold**.
```

is rendered as

[This is a link to the University of Leicester](http://le.ac.uk) and **this is in bold**.

The core Markdown notation used in this chapter is presented below. A full RMarkdown *cheatsheet* is available [here](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf).

```mark
# Header 1
## Header 2
### Header 3
#### Header 4
##### Header 5

**bold**
*italics*

[This is a link to the University of Leicester](http://le.ac.uk)

- Example list
    - Main folder
        - Analysis
        - Data
        - Utils
    - Other bullet point
- And so on
    - and so forth

1. These are
    1. Numeric bullet points
    2. Number two
2. Another number two
3. This is number three
```


### RMarkdown

R code can be embedded in RMarkdown documents using code snippets, as in the example below. That results in the code chunk being displayed within the document (as *echo=TRUE* is specified), followed by the output from the execution of the same code.

````
```{r, echo=TRUE}
a_number <- 0
a_number <- a_number + 1
a_number <- a_number + 1
a_number <- a_number + 1
a_number
```
````


```r
a_number <- 0
a_number <- a_number + 1
a_number <- a_number + 1
a_number <- a_number + 1
a_number
```

```
## [1] 3
```

To create an RMarkdown document in RStudio, select *File > New File > R Markdown ...* -- this might prompt RStudio to update some packages. Once the RMarkdown document creation menu appears, specify "Practical 102" as the title and your name as the author, and select *PDF* as the output format. The new document should contain the core document information, plus some additional content that simply explains how RMarkdown works.

Read the document through, inspecting both the R and the Markdown code. Note how the information provided in the previous step is encoded in the first five lines which compose the heading. For each code snippet, the option `echo=TRUE` tells RStudio to include the code in the output document, along with the output of the computation. If `echo=FALSE` is specified, the code will be omitted. If the option `message=FALSE` and `warning=FALSE` are added, messages and warnings from R are not displayed in the output document.

Save the document (*File > Save*) as `my-first-rmarkdown.Rmd` and then click the *Knit* button visible above the file panel in RStudio to compile the source file into a *PDF* file -- if the browser blocks the opening for the new file in a window, please allow the pop-up to open from the top-right of your browser. Read through the compiled document and compare it to the source document to assess how the compiled document is derived from the source.

## Exercise 102.2

Create an RMarkdown document in RStudio and delete all the contents except the first five lines which compose the heading. Save the document as `practical-102_my-report-002.R`. Copy the questions from *Exercise 102.1* as markdown content and your answers as R code, then compile the document to produce your report.

Save the document by selecting *File > Save* from the main menu. Enter *Square_root* as the file name and click *Save*. The file is saved using the *Rmd* (RMarkdown) extension.

Click on the *Knit* button on the bar above the editor panel (top-left area) in RStudio, on the left side. Check the resulting *pdf* document. Try adding some of your own code (e.g., using some of the examples above) and Markdown text, and compile the document again.

<!--

## Exercise 224.2

Create an analysis document based on RMarkdown for each one of the two analyses seen in the chapters [3](200-selection-manipulation) and [4](210-table-operations). For each of the two analyses, within their respective R projects, first, create an RMarkdown document. Then, add the code from the related R script. Finally add additional content such as title, subtitles, and most importantly, some text describing the data used, how the analysis has been done, and the result obtained. Make sure you add appropriate links to the data sources and related license information, as available in the practical session materials.



## Git

Git is a free and opensource version control system. It is commonly used through a server, where a master copy of a project is kept, but it can also be used locally. Git allows storing versions of a project, thus providing file synchronisation, consistency, history browsing, and the creation of multiple branches. For a detailed introduction to Git, please refer to the [Pro Git book, written by Scott Chacon and Ben Straub](https://git-scm.com/book).

As illustrated in the image below, when working with a git repository, the most common approach is to first check-out the latest version from the main repository before start working on any file. Once a series of edits have been made, the edits to stage are selected and then committed in a permanent snapshot. One or more commits can then be pushed to the main repository.

![<a href="https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F">by Scott Chacon and Ben Straub</a>, licensed under <a href="https://creativecommons.org/licenses/by-nc-sa/3.0/">CC BY-NC-SA 3.0</a>](images/git_three_stages.png){width=80%}



### Git and RStudio

In RStudio Server, in the *Files* tab of the bottom-left panel, click on *Home* to make sure you are in your home folder -- if you are working on your own computer, create a folder for GY7702 wherever most convenient. Click on *New Folder* and enter `repos` (short for repositories) in the prompt dialogue, to create a folder named `repos`. 

If you don't have a GitHub account, create one at [github.com](https://github.com/). In RStudio, use `create_github_token` as shown below, and follow the instructions to generate a GitHub personal access token (PAT) that will allow you to synchronise your project to and from GitHub. Alternatively, you can follow GitHub's instructions on how to [create a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).


```r
usethis::create_github_token()
```

In RStudio, use `gitcreds_set` as shown below, and follow the instructions to store the GitHub PAT generated above locally.


```r
gitcreds::gitcreds_set()
```

Create a new repository named *my-GY7702*, following the instructions available on the [GitHub help pages](https://help.github.com/en/articles/creating-a-new-repository). Make sure you select the option to create a **Private** repository and tick the following options under the heading *Initialize this repository with*:

- *Add a README file*, which adds a `README.md` markdown file to your repository, that you can use to describe your repository and its contents;
- *Add .gitignore* selecting the `R` template, which adds a `.gitignore`, that describes which files should not be copied to the repository, such as the `R` working environment;
- optionally *Choose a license* -- that is not crucial if the repository is private, but it is good practice to include one;
    - common open-source licenses for code are the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0), the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) and the [MIT License](https://opensource.org/licenses/MIT).

Once the repository has been created, GitHub will take you to the repository page. Copy the link to the repository `.git` file by clicking on the green *Code* button and copying the `https` URL there available. Back to RStudio Server, select *File > New Project...* from the top menu and select *Version Control* and then *Git* from the *New Project* panel. Paste the copied URL in the *Repository URL* field, select the `repos` folder created above as folder for *Create project as subdirectory of*, and click *Create Project*. RStudio might ask you for your GitHub username and password at this point.

Before continuing, you need to record your identity with the Git system installed on the RStudio Server, for it to be able to communicate with the GitHub's server. Open the *Terminal* tab in RStudio (if not visible, select *Tools > Terminal > New Terminal* from the top menu). First, paste the command below substituting `you@example.com` with your university email (make sure to maintain the double quotes) and press the return button.

```{}
git config --global user.email "you@example.com"
```

Then, paste the command below substituting `Your Name` with your name (make sure to maintain the double quotes) and press the return button.

```{}
git config --global user.name "Your Name"
```

RStudio should have now switched to a new R project linked to you *my-GY7702* repository. In the RStudio *File* tab in the bottom-right panel, navigate to the file created for the exercises above, select the files and copy them in the folder of the new project (in the *File* tab, *More > Copy To...*).

Check the now available *Git* tab on the top-right panel, and you should see at least the newly copied files marked as untracked. Tick the checkboxes in the *Staged* column to stage the files, then click on the *Commit* button. 

In the newly opened panel *Commit* window, the top-left section shows the files, and the bottom section shows the edits. Write `My first commit` in the *Commit message* section in the top-right, and click the *Commit* button. A pop-up should notify the completed commit. Close both the pop-up panel, and click the *Push* button on the top-right of the *Commit* window. Close both the pop-up panel and the *Commit* window.

Congratulations, you have completed your first commit! Check the repository page on GitHub. If you reload the page, the top bar should show *2 commits* on the left and your files should now be visible in the file list below. If you click on *2 commits*, you can see the commit history, including both the initial commit that created the repository and the commit you just completed.

-->


<!--

## Exercise 224.3

Create a new GitHub repository named `GY7702_224_Exercise3`. Clone the repository to RStudio Server as a new an R project from that repository. Create an RMarkdown document exploring the presence of the different living arrangements in Leicester among both the different categories of the 2011 Output Area Classification and deciles of Index of Multiple Deprivations, copying the required data into the project folder. 

Your analysis should include:

- an introduction to the data and the aims of the project;
- a justification of the analysis methods;
- the code and related results;
- and a discussion of the results within the same document.



## Cloning this book

You can follow the steps listed below to clone the this book's repository.

1. Create a folder named `repos` in your home directory. If you are working on RStudio Server, in the *Files* panel, click on the `Home` button (second bar, next to the house icon), then click on `New Folder`, enter the name `repos` and click `Ok`.

2. In RStudio or RStudio Server select `File > New Project...`

3. Select `Version Control` and then `Git` (you might need to set up Git first if you are working on your own computer)

4. Copy `https://github.com/sdesabbata/r-for-geographic-data-science` in the `Repository URL` field and select the `repos` folder for the field `Create project as subdirectory of`, and click on `Create Project`.

5. Have a look around

6. Click on the project name `r-for-geographic-data-science` on the top-left of the interface and select `Close Project` to close the project.

As this book's repository is public, you can clone it, edit it as you wish and push it to your own copy of the repository. However, contributing your edits to the original repository would require a few further steps. Check out the [GitHub help pages](https://help.github.com/en/articles/committing-changes-to-a-pull-request-branch-created-from-a-fork) if you are interested.

-->

---

<small>by [Stefano De Sabbata](https://sdesabbata.github.io/) -- text licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence), code licensed under the [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html).</small>
