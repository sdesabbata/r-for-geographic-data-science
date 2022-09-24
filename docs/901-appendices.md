# Appendix 1 {-}

## Basic types {-}

A value in `R` is an instance of one of three basic types, each encoding a fundamentally different type of information: `numeric` encoding numbers; `logical` encoding truth values (also known as Boolean values); and character encoding text. Each type has its characteristics and related operations, as discussed below. 

### Numeric {-}

The *numeric* type represents numbers (both integers and reals).


```r
a_number <- 1.41
is.numeric(a_number)
```

```
## [1] TRUE
```

```r
is.integer(a_number)
```

```
## [1] FALSE
```

```r
is.double(a_number) # i.e., is real
```

```
## [1] TRUE
```

Base numeric operators.

|Operator|Meaning         |Example|Output   |
|--------|----------------|-------|---------|
|+       |Plus            |`5+2`  |7  |
|-       |Minus           |`5-2`  |3  |
|`*`     |Product         |`5*2`  |10  |
|/       |Division        |`5/2`  |2.5  |
|%/%     |Integer division|`5%/%2`|2|
|%%      |Module          |`5%%2` |1 |
|^       |Power           |`5^2`  |25  |


Some pre-defined functions in `R`:


```r
abs(-2) # Absolute value
```

```
## [1] 2
```

```r
ceiling(3.475) # Upper round
```

```
## [1] 4
```

```r
floor(3.475) # Lower round
```

```
## [1] 3
```

```r
trunc(5.99) # Truncate
```

```
## [1] 5
```

```r
log10(100) # Logarithm 10
```

```
## [1] 2
```

```r
log(exp(2)) # Natural logarithm and e
```

```
## [1] 2
```

Use simple brackets to specify the order of execution. If not specified the default order is: rise to power first, then multiplication and division, sum and subtraction last.


```r
a_number <- 1
(a_number + 2) * 3
```

```
## [1] 9
```

```r
a_number + (2 * 3)
```

```
## [1] 7
```

```r
a_number + 2 * 3
```

```
## [1] 7
```

The object `NaN` (*Not a Number*) is returned by `R` when the result of an operation is not a number.


```r
0 / 0
```

```
## [1] NaN
```

```r
is.nan(0 / 0)
```

```
## [1] TRUE
```

That is not to be confused with the object `NA` (*Not Available*), which is returned for missing data.

### Logical {-}

The *logical* type encodes two truth values: True and False.


```r
logical_var <- TRUE
is.logical(logical_var)
```

```
## [1] TRUE
```

```r
isTRUE(logical_var)
```

```
## [1] TRUE
```

```r
as.logical(0) # TRUE if not zero
```

```
## [1] FALSE
```

`R` provides a series of basic logic operators you can use to evaluate *conditions*. For instance, you can use the logic operator `==` to evaluate the condition `5==2`, which tests whether the value `5` is equal to the value `2`. Conditions can be tested on values as well as on variables.


```r
5==2
```

```
## [1] FALSE
```

```r
first_value <- 5
second_value <- 2
first_value == 5
```

```
## [1] TRUE
```

```r
first_value == 2
```

```
## [1] FALSE
```

```r
second_value == 5
```

```
## [1] FALSE
```

```r
second_value == 2
```

```
## [1] TRUE
```

```r
first_value == second_value
```

```
## [1] FALSE
```

|Operator|Meaning          |Example         |Output            |
|--------|-----------------|----------------|------------------|
|==      |Equal            |`5==2`          |FALSE          |
|!=      |Not equal        |`5!=2`          |TRUE          |
|>       |Greater than     |`5>2`           |TRUE           |
|<       |Less than        |`5<2`           |FALSE           |
|>=      |Greater or equal |`5>=2`          |TRUE          |
|<=      |Less or equal    |`5<=2`          |FALSE          |
|!       |Not              |`!TRUE`         |FALSE         |
|&       |And              |`TRUE & FALSE`  |FALSE  |
|\|      |Or               |`TRUE | FALSE`  |TRUE  |



### Character {-}

The *character* type represents text objects, including single characters and character strings (that is text objects longer than one character, commonly referred to simply as *strings* in computer science).


```r
a_string <- "Hello world!"
is.character(a_string)
```

```
## [1] TRUE
```

```r
is.numeric(a_string)
```

```
## [1] FALSE
```

```r
as.character(2) # type conversion  (a.k.a. casting)
```

```
## [1] "2"
```

```r
as.numeric("2")
```

```
## [1] 2
```

```r
as.numeric("Ciao")
```

```
## Warning: NAs introduced by coercion
```

```
## [1] NA
```

### Types and variables {-}

A variable storing a value of a given type is said to have the same type. However, variables in `R` don't have an assigned type themselves. That means that a variable can be assigned a numeric value first and then changed to a character value. 


```r
a_variable <- 1.41
a_variable
```

```
## [1] 1.41
```

```r
is.numeric(a_variable)
```

```
## [1] TRUE
```

```r
a_variable <- "Hello world!"
a_variable
```

```
## [1] "Hello world!"
```

```r
is.character(a_variable)
```

```
## [1] TRUE
```

```r
is.numeric(a_variable)
```

```
## [1] FALSE
```

To be more precise, many programming languages require to *declare* a variable. That is, to state the type of a variable before it can be used. Variable declaration was particularly common in older programming languages such as `C` and `Java`. `R` does not require to declare variables types.



---

<small>by [Stefano De Sabbata](https://sdesabbata.github.io/) -- text licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence), code licensed under the [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html).</small>
