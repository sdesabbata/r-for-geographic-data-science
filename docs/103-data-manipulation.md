# Data manipulation

<br/><small><a href="javascript:if(window.print)window.print()">Print this chapter</a></small>



Programming languages commonly provide both simple data types, such as those seen in the [first chapter](introduction-to-r.html), and more complex objects capable of storing and organising multiple values, such as the tables that we have briefly seen in action in the [second chapter](reproducible-data-science.html). In this chapter we bridge that gap by discussing a series of complex data types and how to manipulate the information they store. In doing so, we discuss the [`dplyr`](https://dplyr.tidyverse.org/) library (also part of the Tidyverse), which it offers a grammar for data manipulation.

Before continuing, create a new R project named *GY7702-practical-103* and create a new R script named `complex-data-types.R`. Follow along with the examples below by copy-pasting the code in the script and then running one line at the time.



## Complex data types

### Vectors

The simplest of the complex objects usually allow storing multiple values of the same type in an ordered list. Such objects take different names in different languages. In `R`, they are referred to as **vectors**^[The term *list* has a specific meaning in `R`. Don't use the term *list* to refer to *vectors*.].

Vectors can be defined in R by using the function `c`, which takes as parameters the items to be stored in the vector. The items are stored in the order in which they are provided. 


```r
east_midlands_cities <- c("Derby", "Leicester", "Lincoln", "Nottingham")
length(east_midlands_cities)
```

```
## [1] 4
```

```r
# or using the pipe operator
library(tidyverse)
east_midlands_cities %>% length()
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

Alternatively, the `first`, `last`, or `nth` functions of the `dplyr` library within Tidyverse can be used to extract single values from vectors.


```r
# Retrieve the first city
east_midlands_cities %>% first()
```

```
## [1] "Derby"
```

```r
# Retrieve the first city
east_midlands_cities %>% nth(1)
```

```
## [1] "Derby"
```

```r
# Retrieve the third city
east_midlands_cities %>% nth(3)
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

As seen in the previous chapter, a condition entered in the Console is evaluated for the provided input, and a logical value (`TRUE` or `FALSE`) is provided as output. Similarly, if the provided input is a vector, the condition is evaluated for each element of the vector, and a vector of logical values is returned -- which contains the respective results of the conditions for each element.


```r
-3 > 0
```

```
## [1] FALSE
```

```r
minus_two_to_two <- c(-2, -1, 0, 1, 2) 
minus_two_to_two > 0
```

```
## [1] FALSE FALSE FALSE  TRUE  TRUE
```

A subset of the elements of a vector can also be selected by providing a vector of logical values between brackets after the identifier. A new vector is returned, containing only the values for which a `TRUE` value has been specified correspondingly.


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

A **factor** is a data type similar to a vector. However, the values contained in a factor can only be selected from a set of **levels**. The code below illustrates the difference between vectors and factors.


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

R also provides a data type named **ordered**, which is similar to the data type factor but the levels are considered as ordered categories and respond to operators like `>` (greater then) when filtered. **[Appending 1](appendix-1.html)** provides some more details on vectors for those eager to lear -- or if you get stuck with your code and feel like knowing more about how to work with vectors might help. 😊





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



## Data frames and tibbles

As mentioned in the first chapter, **data frames** are complex data types which encode the concept of a table in R by combining and arranging together a series of simple objects. Data frames are similar to named lists, where each element of the list is a vector representing a column and all vectors have the same length, thus representing the same number of rows.

In the Tidyverse, a [`tibble`](https://tibble.tidyverse.org/) is defined as: "a modern re-imagining of the data frame, keeping what time has proven to be effective, and throwing out what it has not. Tibbles are data.frames that are lazy and surly: they do less and complain more forcing you to confront problems earlier, typically leading to cleaner, more expressive code".

Before continuing, create a *data* subfolder and copy the `2011_OAC_Raw_uVariables_Leicester.csv` file in the *data* subfolder. Then, create a new RMarkdown documemnt to be compiled as a PDF file, using *Data manipulation* as a title and `data-manipulation.Rmd` as file name. Follow along with the examples below by copy-pasting the code in new R chunks, running them one at the time and then compiling the whole document.



### Selecting and filtering tables

The approaches seen above for selecting and filtering data from vectors can be applied to data frames and tibbles. The only difference is that tables are bi-dimensional (rather than one-dimensional), and thus, two pieces of information are necessary. The first index specifies which rows to select or filter, and the second index specifies which columns to select or filter. If no information is provided for either the first or second index, all rows or columns are provided. However, as you can see from the examples below, the more complex the selection and filtering query become, the longer and less readable the code becomes.


```r
library(tidyverse)
library(knitr)

# Read the Leicester 2011 OAC dataset from the csv file
leicester_2011OAC <- 
  read_csv("2011_OAC_Raw_uVariables_Leicester.csv")
```




```r
# Select the 5th row
leicester_2011OAC[5, ]

# Select the 9th column (OAC supergroup name)
leicester_2011OAC[, 9]

# Select the 5th row and 9th column
leicester_2011OAC[5, 9]

# Select the OAC supergroup name column (9th column) of the 5th row
leicester_2011OAC[5, "supgrpname"]

# Select the OA code, OAC supergroup code name columns of the 5th row
leicester_2011OAC[5, c("OA11CD", "supgrpcode", "supgrpname")]

# Select the OA code, OAC supergroup code name columns
# of the 5th to 10th rows 
leicester_2011OAC[5:10, c("OA11CD", "supgrpcode", "supgrpname")]

# Select the OA code, OAC supergroup code name columns
# for all OAs with more than 600 inhabitants
leicester_2011OAC[leicester_2011OAC$Total_Population > 600, c("OA11CD", "supgrpcode", "supgrpname")]
```
 
Fortunately, rather than working with base R instructions, we can use the `dplyr` library, which is part of the Tidyverse and offers a grammar for data manipulation. The function `select` can be used to select some **columns** to output. For instance, in the code below, the function `select` is used to select the columns `OA11CD`, `supgrpcode`, and `supgrpname`, in combination with the function `slice_head`, which can be used to include only the first `n` rows (`5` in the example below) to output.


```r
leicester_2011OAC %>%
  select(OA11CD, supgrpcode, supgrpname) %>%
  slice_head(n = 5) %>%
  kable()
```



|OA11CD    | supgrpcode|supgrpname                  |
|:---------|----------:|:---------------------------|
|E00069517 |          6|Suburbanites                |
|E00069514 |          2|Cosmopolitans               |
|E00169516 |          4|Multicultural Metropolitans |
|E00169048 |          4|Multicultural Metropolitans |
|E00169044 |          4|Multicultural Metropolitans |

The function `filter` can instead be used to filter **rows** based on a specified condition. In the example below, the output of the `filter` step only includes the rows where the value of `grpname` is `"Students Around Campus"` (i.e., OAs classified as part of the Students Around Campus group). Note that the `grpname` needs to be included in the `select` step in order to be able to used it in the subsequent `filter` operation. All functions in the `dplyr` library can be combined in any other order that makes logical sense. However, if the `select` step didn't include `grpname`, that same column couldn't have been used in the `filter` step.


```r
leicester_2011OAC %>%
  select(OA11CD, supgrpname, grpname, Total_Population) %>%
  filter(grpname == "Students Around Campus") %>%
  slice_head(n = 5) %>%
  kable()
```



|OA11CD    |supgrpname    |grpname                | Total_Population|
|:---------|:-------------|:----------------------|----------------:|
|E00069514 |Cosmopolitans |Students Around Campus |              323|
|E00068882 |Cosmopolitans |Students Around Campus |              285|
|E00169553 |Cosmopolitans |Students Around Campus |              714|
|E00068869 |Cosmopolitans |Students Around Campus |              319|
|E00068876 |Cosmopolitans |Students Around Campus |              255|



### Summarise

the function `count` of the [`dplyr`](https://dplyr.tidyverse.org/) library can be used to count the number of rows in a data frame. The code below provides the `leicester_2011OAC` dataframe (as read in input in the section above) as input to the function `count` through the pipe operator, thus creating a new [`tibble`](https://tibble.tidyverse.org/) with only one row and one column, containing the number of rows in that dataframe -- that is, the number of OAs in Leicester. 



```r
leicester_2011OAC %>%
  count() %>%
  kable()
```



|   n|
|---:|
| 969|

As discussed in the previous lecture, a [`tibble`](https://tibble.tidyverse.org/) is a data type similar to data frames, used by all the Tidyverse libraries. All Tidyverse functions output `tibble` rather than `data.frame` objects when representing a table. However, `data.frame` object can be provided as input, as they are automatically converted by Tidyverse functions before proceeding with the processing steps.

The example above already shows how the **pipe operator** can be used effectively in a multi-step operation. In the `tibble` outputted by the `count` function above, the column `n` provides the count. The function `kable` of the library `knitr` is used to produce a well-formatted table.

Note how the code above goes to a new line after every `%>%`, and space is added at the beginning of new lines. That is very common in R programming (especially when functions have many parameters) as it makes the code more readable.

The verb `count` is a special case (a shorthand) of the more general verb `summarise` (`summarize` using the American English spelling is also available with the same functionality), which allows generating tables presenting aggregate values of input data. 

For instance, `summarise` can be used to create a table containing:

- a column presenting the total population of Leicester;
- a column presenting the total number of OAs in Leicester;
- a column presenting the average population per OAs in Leicester;
- a column presenting a logical value stating whether any OA in Leicester contains more than 600 people.

That can be achieved applying different aggregate functions to the same column (`Total_Population`) of the `leicester_2011OAC` as illustrated below.

- `sum` to calculate the total population of Leicester;
- `n` to count the number of rows (as mentioned above `count` is a shorthand for the combination of `summarise` with `n`);
- `mean` to calculate the average population per OAs in Leicester; 
- `any` with a conditional statement comparing `Total_Population` and the value `600` using the numeric operator `>` (greater than) to assess whether any OA in Leicester contains more than 600 people.


```r
leicester_2011OAC %>%
  summarise(
    # Total population in Leicester
    tot_pop = sum(Total_Population),
    # Number of OAs, no input column needed
    num_of_OAs = n(),
    # Average population
    avg_pop = mean(Total_Population), 
    # Is there any OA with over 200 people?
    pop_over_600 = any(Total_Population > 600)
  ) %>% 
  kable()
```



| tot_pop| num_of_OAs|  avg_pop|pop_over_600 |
|-------:|----------:|--------:|:------------|
|  329839|        969| 340.3911|TRUE         |

A set of aggregate functions which are frequently used with `summarise` is available in [the `dplyr` page on `summarise`](https://dplyr.tidyverse.org/reference/summarise.html#useful-functions).

To carry out more complex aggregations, the function `summarise` can be used in combination with the function `group_by` to summarise the values in the data frame based on groups. Rows having the same value for the column specified for the verb `group_by` (in the example below, the 2011 OAC supergroup, `supgrpname`) are grouped together, then values are aggregated based on the functions specified for the verb `summarise` (using one or more columns in the calculation). 


```r
leicester_2011OAC %>%
  group_by(supgrpname) %>% 
  summarise(
    # Total population in Leicester
    tot_pop = sum(Total_Population),
    # Number of OAs, no input column needed
    num_of_OAs = n(),
    # Average population
    avg_pop = mean(Total_Population), 
    # Is there any OA with over 200 people?
    pop_over_600 = any(Total_Population > 600)
  ) %>% 
  kable()
```



|supgrpname                  | tot_pop| num_of_OAs|  avg_pop|pop_over_600 |
|:---------------------------|-------:|----------:|--------:|:------------|
|Constrained City Dwellers   |    9263|         36| 257.3056|FALSE        |
|Cosmopolitans               |   26813|         83| 323.0482|TRUE         |
|Ethnicity Central           |   19137|         57| 335.7368|FALSE        |
|Hard-Pressed Living         |   32069|        101| 317.5149|FALSE        |
|Multicultural Metropolitans |  205007|        573| 357.7784|TRUE         |
|Suburbanites                |   17326|         54| 320.8519|FALSE        |
|Urbanites                   |   20224|         65| 311.1385|FALSE        |

The shorthand function `count` also has the option to specify a column that will be used for an internal grouping. In the example below, the column name `supgrpname` is provided as an argument to the function `count`. As a result, the output shows the number of rows grouped by 2011 OAC supergroup.


```r
leicester_2011OAC %>%
  count(supgrpname) %>%
  kable()
```



|supgrpname                  |   n|
|:---------------------------|---:|
|Constrained City Dwellers   |  36|
|Cosmopolitans               |  83|
|Ethnicity Central           |  57|
|Hard-Pressed Living         | 101|
|Multicultural Metropolitans | 573|
|Suburbanites                |  54|
|Urbanites                   |  65|



### Mutate

The function `mutate` can be used to create a new column by conducting operations on current columns. For instance, in the example below, `summarise` is first used to calculate the total number of people and the number of OAs per 2011 OAC supergroup. The verb `mutate` is then used to calculate the average population per OA per 2011 OAC supergroup, recreating the same `avg_pop` column as above but through a different process.


```r
leicester_2011OAC %>%
  group_by(supgrpname) %>% 
  summarise(
    # Total population in Leicester
    tot_pop = sum(Total_Population),
    # Number of OAs, no input column needed
    num_of_OAs = n(),
    # Is there any OA with over 200 people?
    pop_over_600 = any(Total_Population > 600)
  ) %>% 
  mutate(
    # Average population
    avg_pop = tot_pop / num_of_OAs, 
  ) %>% 
  kable(digits = c(0, 0, 0, 0, 2))
```



|supgrpname                  | tot_pop| num_of_OAs|pop_over_600 | avg_pop|
|:---------------------------|-------:|----------:|:------------|-------:|
|Constrained City Dwellers   |    9263|         36|FALSE        |  257.31|
|Cosmopolitans               |   26813|         83|TRUE         |  323.05|
|Ethnicity Central           |   19137|         57|FALSE        |  335.74|
|Hard-Pressed Living         |   32069|        101|FALSE        |  317.51|
|Multicultural Metropolitans |  205007|        573|TRUE         |  357.78|
|Suburbanites                |   17326|         54|FALSE        |  320.85|
|Urbanites                   |   20224|         65|FALSE        |  311.14|

In this second example, the `u005` column (which represents the area of the OA in [hectares](https://en.wikipedia.org/wiki/Hectare), see `2011_OAC_Raw_uVariables_Lookup.csv`) is used to calculate the population density for each OA.


```r
leicester_2011OAC %>%
  mutate(
    # Population density
    pop_density = Total_Population / u005, 
  ) %>% 
  select(OA11CD, pop_density) %>% 
  slice_head(n = 10) %>% 
  kable(digits = c(0, 2))
```



|OA11CD    | pop_density|
|:---------|-----------:|
|E00069517 |       33.69|
|E00069514 |      131.30|
|E00169516 |      240.14|
|E00169048 |      104.23|
|E00169044 |       99.08|
|E00069041 |       51.31|
|E00169049 |       42.53|
|E00068806 |       57.78|
|E00068886 |      122.87|
|E00068807 |       76.21|



### Arrange

The function `arrange` can be used to sort a tibble by ascending order of the values in the specified column. If the operator `-` is specified before the column name, the descending order is used. The code below would produce a table showing the ten OAs with the largest population in Leicester.


```r
leicester_2011OAC %>%
  select(
    OA11CD,	supgrpname,	
    Total_Population
  ) %>% 
  arrange(
    # Descending delay
    -Total_Population
  ) %>% 
  slice_head(n = 10) %>% 
  kable()
```

In the example above, we have used `slice_head` to present only the first `n` (in the example `10`) rows in a table based on the existing order. The `dplyr` library also provides the functions `slice_max` and `slice_min` which incorporate the sorting functionality (see [`slice` reference page](https://dplyr.tidyverse.org/reference/slice.html)).

As such, the following code uses `slice_max` to produce a table including only the 10 OAs with the *highest* population.


```r
leicester_2011OAC %>%
  select(
    OA11CD,	supgrpname,	
    Total_Population
  ) %>% 
  slice_max(
    Total_Population, 
    n = 10
  ) %>%
  kable()
```



|OA11CD    |supgrpname                  | Total_Population|
|:---------|:---------------------------|----------------:|
|E00169553 |Cosmopolitans               |              714|
|E00168096 |Cosmopolitans               |              708|
|E00069303 |Multicultural Metropolitans |              623|
|E00169458 |Cosmopolitans               |              622|
|E00069304 |Multicultural Metropolitans |              608|
|E00169575 |Cosmopolitans               |              597|
|E00069393 |Ethnicity Central           |              591|
|E00169564 |Cosmopolitans               |              591|
|E00069482 |Multicultural Metropolitans |              590|
|E00069216 |Multicultural Metropolitans |              586|
|E00169446 |Cosmopolitans               |              586|
|E00069439 |Multicultural Metropolitans |              586|

The following code, instead, uses `slice_min`, thus producing a table including only the 10 OAs with the *lowest* population..


```r
leicester_2011OAC %>%
  select(
    OA11CD,	supgrpname,	
    Total_Population
  ) %>% 
  slice_min(
    Total_Population, 
    n = 10
  ) %>%
  kable()
```



|OA11CD    |supgrpname                  | Total_Population|
|:---------|:---------------------------|----------------:|
|E00169530 |Ethnicity Central           |              103|
|E00169528 |Ethnicity Central           |              119|
|E00069382 |Ethnicity Central           |              126|
|E00069149 |Cosmopolitans               |              131|
|E00069332 |Multicultural Metropolitans |              132|
|E00168107 |Multicultural Metropolitans |              133|
|E00168094 |Cosmopolitans               |              141|
|E00169486 |Cosmopolitans               |              150|
|E00069184 |Urbanites                   |              158|
|E00169472 |Constrained City Dwellers   |              160|

In both cases, if the table contains ties, all rows containing a value that is present among the maximum or minimum selected values are presented, as is the case with the rows containing the value `21` in the example above.



### Data manipulation workflow

Finally, the code below illustrates a more complex, multi-step operation using all the functions discussed above. This is a full example of a short analysis using only one series of pipes to read, process and write data using `R` and almost all the `tidyverse` *verbs* seen so far.

The input data are read from the csv file and part of the data are selected and filtered. The data are grouped, aggregated and arranged in order. The percentage of people living in OAs assigned to each 2011 OAC supergroup is calculated. The [Tee pipe](https://magrittr.tidyverse.org/reference/tee.html) (from the `magrittr` library) is used to write the resulting table to a file, while also passing the same input to the subsequent `kable` function to display the data.


```r
library(magrittr)

# Let's start from the filename
"2011_OAC_supgrp_Leicester.csv" %>% 
  # as input to the read_csv function
  read_csv(col_types = "cccci") %>% 
  # Select only the necessary columns
  select(supgrpname,	Total_Population) %>% 
  # Let's say we are not interested in
  # the Suburbanites supergroup
  filter(supgrpname != "Suburbanites") %>% 
  # Group by supergroup
  group_by(supgrpname) %>% 
  # Aggregate population
  summarise(tot_pop = sum(Total_Population)) %>% 
  # Ungroup
  ungroup() %>% 
  # Arrange by descending total population
  arrange(-tot_pop) %>% 
  # Calculate percentage
  mutate(perc_pop = (tot_pop / 329839) * 100) %T>%
  # Then use the Tee pipe %T>% in the line above
  # to write the calculated values to file
  # and pass the same input values to the kable function
  write_csv(
    "2011_Leicester_pop_per_OAC_supgrp_excl_suburb.csv"
  ) %>% 
  # Print to screen nicely
  kable()
```


|supgrpname                  | tot_pop| perc_pop|
|:---------------------------|-------:|--------:|
|Multicultural Metropolitans |  205007|    62.15|
|Hard-Pressed Living         |   32069|     9.72|
|Cosmopolitans               |   26813|     8.13|
|Urbanites                   |   20224|     6.13|
|Ethnicity Central           |   19137|     5.80|
|Constrained City Dwellers   |    9263|     2.81|



## Componentization

It is important to note that in the example above, no information is stored in the local environment. The input is read directly from the computer storage, the whole process is conducted in the `R` internal memory, and the output is saved back to the computer storage. That is the whole purpose of the pipe operator: to avoid creating unnecessary and temporary "mid-products" during the computation (i.e., variables whose only purpose is to store the data before the next step). 

However, it is frequently useful to split the processing into different steps, which allow the data to be inspected mid-way through the analysis or for the data to be used twice in two subsequent steps. Finding a good balance between too long and too short pipe sequences and too many or too few "mid-products" is the programmer's task -- and something that can only be learnt by experience and observing good examples of code.

The following example showcases how the process above can be subdivided into five meaningful steps. 

1. Read the data. This is frequently done as a separate step, as some datasets might require significant time to be read from computer storage, and it is frequently best to read them only once.
2. Calculate the total population per 2011 OAC supergroup, excluding the suburban population. This is a significant transformation of the original data, which might be worth saving and inspecting.
3. Update the new table using mutate and the [assignment pipe operator `%<>%`](https://magrittr.tidyverse.org/reference/compound.html) (from the `magrittr` library).
4. Print the result.
5. Save the result to the computer storage.


```r
leicester_2011OAC <-
  # Let's start from the filename
  "2011_OAC_supgrp_Leicester.csv" %>% 
  # as input to the read_csv function
  read_csv(col_types = "cccci") 
```


```r
leicester_nonsuburb_pop <-
  leicester_2011OAC %>% 
  # Select only the necessary columns
  select(supgrpname,	Total_Population) %>% 
  # Let's say we are not interested in
  # the Suburbanites supergroup
  filter(supgrpname != "Suburbanites") %>% 
  # Group by supergroup
  group_by(supgrpname) %>% 
  # Aggregate population
  summarise(tot_pop = sum(Total_Population)) %>% 
  # Ungroup
  ungroup() %>% 
  # Arrange by descending total population
  arrange(-tot_pop)

leicester_nonsuburb_pop %<>%
  # Calculate percentage
  mutate(perc_pop = (tot_pop / 329839) * 100)
```


```r
leicester_nonsuburb_pop %>% 
  # Print to screen nicely
  kable(digits = c(0, 0, 2))
```



|supgrpname                  | tot_pop| perc_pop|
|:---------------------------|-------:|--------:|
|Multicultural Metropolitans |  205007|    62.15|
|Hard-Pressed Living         |   32069|     9.72|
|Cosmopolitans               |   26813|     8.13|
|Urbanites                   |   20224|     6.13|
|Ethnicity Central           |   19137|     5.80|
|Constrained City Dwellers   |    9263|     2.81|


```r
leicester_nonsuburb_pop %>% 
  # Write the calculated values to file
  write_csv(
    "2011_Leicester_pop_per_OAC_supgrp_excl_suburb.csv"
  ) 
```



## Exercises 103.1

Create an RMarkdown document in RStudio, using *Exercise 103* as title and *PDF* as output. Delete all the contents except the first five lines which compose the heading. Save the document as `practical-103_exercises.Rmd`. Add the libraries and code necessary to read the data from the `2011_OAC_Raw_uVariables_Leicester.csv` file. Create a first section of the document (e.g., adding a second heading *Exercise 103.1*) and add your answers to the questions below.

In order to answer the questions below, inspect the **look-up** table `2011_OAC_Raw_uVariables_Lookup.csv` (e.g., using Microsoft Excel) to identify the columns necessary to complete the task.

**Question 103.1.1:** Identify the five variables which are part of the variable subdomain *Housing Type* and write the code necessary to compute the total number of household spaces in Leicester for each housing type.

**Question 103.1.2:** Write the code necessary to compute the total number of household spaces in Leicester for each housing type grouped by 2011 OAC supergroup.

**Question 103.1.3:** Write the code necessary to compute the percentage of household spaces (i.e., over to the total number of household spaces) in Leicester for each housing type grouped by 2011 OAC supergroup.

**Question 103.1.4:** Modify the code written for *Question 103.1.3*, using [the verb `rename`](https://dplyr.tidyverse.org/reference/rename.html) to change the column names of the columns containing the percentages to names that resemble the related housing type (e.g., `perc_of_detached`).



## Exercises 103.2

**Question 103.2.1:** Explore the **look-up** table `2011_OAC_Raw_uVariables_Lookup.csv` and identify another set of variables that you think might relate to the type of housing and the 2011 OAC supergroups. Create a new section of the document (e.g., adding a second heading) and include a short text (up to 200 words) in the RMarkdown document describing and justifying the set of variables you choose.

**Question 103.2.2:** Write the code necessary to conduct the same analysis conducted for *Question 103.1* but using the variables identified in *Question 103.2.1*.

**Question 103.2.3:** Inspect the table obtained from your answer to *Question 103.1.3* and the table obtained from your answer to *Question 103.2.2*, and compare the results. Write a short text (up to 300 words) in the RMarkdown document reporting and discussing what the results tell you about the socio-demographic structure of Leicester.



---

<small>by [Stefano De Sabbata](https://sdesabbata.github.io/) -- text licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence), code licensed under the [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html).</small>
