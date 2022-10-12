# Data manipulation

<br/><small>*This chapter is currently a draft.*</small>

<br/><small><a href="javascript:if(window.print)window.print()">Print this chapter</a></small>


## R workflow

### R Projects

RStudio provides an extremely useful functionality to organise all your code and data, that is **R Projects**. Those are specialised files that RStudio can use to store all the information it has on a specific project that you are working on -- *Environment*, *History*, working directory, and much more, as we will see in the coming weeks.

In RStudio Server, in the *Files* tab of the bottom-left panel, click on *Home* to make sure you are in your home folder -- if you are working on your own computer, create a folder for these practicals wherever most convenient. Click on *New Folder* and enter *Practicals* in the prompt dialogue, to create a folder named *Practicals*. 

Select *File > New Project ...* from the main menu, then from the prompt menu, *New Directory*, and then *New Project*. Insert *Practical_204* as the directory name, and select the *Practicals* folder for the field *Create project as subdirectory of*. Finally, click *Create Project*. 

RStudio has now created the project, and it should have activated it. If that is the case, the *Files* tab in the bottom-right panel should be in the *Practical_204* folder, which contains only the *Practical_204.Rproj* file. The *Practical_204.Rproj* stores all the *Environment* information for the current project and all the project files (e.g., R scripts, data, output files) should be stored within the *Practical_204* folder. Moreover, the *Practical_204* is now your working directory, which means that you can refer to a file in the folder by using only its name and if you save a file that is the default directory where to save it. 

On the top-right corner of RStudio, you should see a blue icon representing an R in a cube, next to the name of the project (*Practical_204*). That also indicates that you are within the *Practical_204* project. Click on *Practical_204* and select *Close Project* to close the project. Next to the R in a cube icon, you should now see *Project: (None)*. Click on *Project: (None)* and select *Practical_204* from the list to reactivate the *Practical_204* project.

With the *Practical_204* project activated, select from the top menu *File > New File > R Script*. That opens the embedded RStudio editor and a new empty R script folder. Copy the two lines below into the file. The first loads the `tidyverse` library, whereas the second loads another library that the code below uses to produce well-formatted tables.


```r
library(tidyverse)
library(knitr)
```

From the top menu, select *File > Save*, type in *My_script_Practical_204.R* (make sure to include the underscore and the *.R* extension) as *File name*, and click *Save*.

### How to cite code

The UK's [Software Sustainability Institute](https://www.software.ac.uk/about) provides clear guidance about [how to cite software](https://www.software.ac.uk/how-cite-software) written by others. As outlined in the guidance, you should always cite and credit their work. However, using academic-style citations is not always straightforward when working with libraries, as most of them are not linked to an academic paper nor provide a [DOI](https://www.doi.org/). In such cases, you should at least include a link to the authors' website or repository in the script or final report when using a library. For instance, you can add a link to the Tidyverse's  [website](https://tidyverse.tidyverse.org/), [repository](https://github.com/tidyverse/tidyverse) or [CRAN page](https://cran.r-project.org/web/packages/tidyverse/index.html) when using the library. However, @tidyverse2019 also wrote a paper on their work on the Tidyverse for the [Journal of Open Source Software](https://joss.theoj.org/), so you can also cite their paper [using Bibtex in RMarkdown](https://bookdown.org/yihui/rmarkdown-cookbook/bibliography.html).

<!-- The two following paragraphs contain text adapted from text by Dr. Jorg D. Kaduk, jk61@leicester.ac.uk -->

Appropriate citations are even more important when directly copying or adapting code from others' work. Plagiarism principles apply to code as much as they do to text. The Massachusetts Institute of Technology (MIT)'s [*Academic Integrity at MIT: A Handbook for Students*](https://integrity.mit.edu/) includes a section on [writing code](https://integrity.mit.edu/handbook/writing-code) which provides good guidance on when and how to cite code that you include in your projects or you adapt for your own code properly. 
That also applies to re-using your own code, which you have written before. It is important that you refer to your previous work and fully acknowledge all previous work that has been used in a project so that others can find everything you have used in a project.

It is common practice to follow a particular referencing style for the in-text quotations, references and bibliography, such as the Harvard style (see, e.g., the [Harvard Format Citation Guide](https://www.mendeley.com/guides/harvard-citation-guide/) available [Mendeley](https://www.mendeley.com/)'s help pages). 
Following such guidelines will not only ensure that others can more easily use and reproduce your work but also that you demonstrate academic honesty and integrity.


## Data manipulation

The analysis below uses the [`dplyr`](https://dplyr.tidyverse.org/) library (also part of the Tidyverse), which it offers a grammar for data manipulation.

For instance, the function `count` can be used to count the number rows of a data frame. The code below provides `flights` as input to the function `count` through the pipe operator, thus creating a new [`tibble`](https://tibble.tidyverse.org/) with only one row and one column. 

As discussed in the previous lecture, a [`tibble`](https://tibble.tidyverse.org/) is data type similar to data frames, used by all the Tidyverse libraries. 

All Tidyverse functions output `tibble` rather than `data.frame` objects when representing a table. However, `data.frame` object can be provided as input, as they are automatically converted by Tidyverse functions before proceeding with the processing steps.

In the `tibble` outputted by the `count` function below, the column `n` provides the count. The function `kable` of the library `knitr` is used to produce a well-formatted table.


```r
library(tidyverse)
library(knitr)
library(nycflights13)
```


```r
flights %>%
  count() %>%
  kable()
```



|      n|
|------:|
| 336776|

The example above already shows how the **pipe operator** can be used effectively in a multi-step operation.

The function `count` can also be used to count the number rows of a table that have the same value for a given column, usually representing a category. 

In the example below, the column name `origin` is provided as an argument to the function `count`, so rows representing flights from the same origin are counted together -- EWR is the Newark Liberty International Airport, JFK is the John F. Kennedy International Airport, and LGA is LaGuardia Airport.


```r
flights %>%
  count(origin) %>%
  kable()
```



|origin |      n|
|:------|------:|
|EWR    | 120835|
|JFK    | 111279|
|LGA    | 104662|

As you can see, the code above is formatted in a way similar to a code block, although it is not a code block. The code goes to a new line after every `%>%`, and space is added at the beginning of new lines. That is very common in R programming (especially when functions have many parameters) as it makes the code more readable.



### Summarise

To carry out more complex aggregations, the function `summarise` can be used in combination with the function `group_by` to summarise the values of the rows of a data frame. Rows having the same value for a selected column (in the example below, the same origin) are grouped together, then values are aggregated based on the defined function (using one or more columns in the calculation). 

In the example below, the function `sum` is applied to the column `distance` to calculate `distance_traveled_from` (the total distance travelled by flights starting from each airport).


```r
flights %>%
  group_by(origin) %>%
  summarise(
    distance_traveled_from = sum(distance)
  ) %>%
  kable()
```



|origin | distance_traveled_from|
|:------|----------------------:|
|EWR    |              127691515|
|JFK    |              140906931|
|LGA    |               81619161|



### Mutate

The function `mutate` can be used to add a new column to an output table. The `mutate` step in the code below adds a new column `air_time_hours` to the table obtained through the pipe, that is the flight air time in hours, dividing the flight air time in minutes by `60`.


```r
flights %>%
  select(flight, origin, dest, air_time) %>%
  mutate(
    air_time_hours = air_time / 60
  ) %>%
  slice_head(n = 5) %>%
  kable()
```



| flight|origin |dest | air_time| air_time_hours|
|------:|:------|:----|--------:|--------------:|
|   1545|EWR    |IAH  |      227|       3.783333|
|   1714|LGA    |IAH  |      227|       3.783333|
|   1141|JFK    |MIA  |      160|       2.666667|
|    725|JFK    |BQN  |      183|       3.050000|
|    461|LGA    |ATL  |      116|       1.933333|

### Arrange

The function `arrange` can be used to sort a tibble by ascending order of the values in the specified column. If the operator `-` is specified before the column name, the descending order is used. The code below would produce a table showing all the rows when ordered by descending order of air time.


```r
flights %>%
  select(flight, origin, dest, air_time) %>%
  arrange(-air_time) %>%
  kable()
```

In the examples above, we have used `slice_head` to present only the first `n` (in the examples `5`) rows in a table, based on the existing order. The `dplyr` library also provides the functions `slice_max` and `slice_min` which incorporate the sorting functionality (see [`slice` reference page](https://dplyr.tidyverse.org/reference/slice.html)).

As such, the following code uses `slice_max` to produce a table including only the 5 rows with the *highest* air time.


```r
flights %>%
  select(flight, origin, dest, air_time) %>%
  slice_max(air_time, n = 5) %>%
  kable()
```



| flight|origin |dest | air_time|
|------:|:------|:----|--------:|
|     15|EWR    |HNL  |      695|
|     51|JFK    |HNL  |      691|
|     51|JFK    |HNL  |      686|
|     51|JFK    |HNL  |      686|
|     51|JFK    |HNL  |      683|

The following code, instead, uses `slice_min`, thus producing a table including only the 5 rows with the *lowest* air time.


```r
flights %>%
  select(flight, origin, dest, air_time) %>%
  slice_min(air_time, n = 5) %>%
  kable()
```



| flight|origin |dest | air_time|
|------:|:------|:----|--------:|
|   4368|EWR    |BDL  |       20|
|   4631|EWR    |BDL  |       20|
|   4276|EWR    |BDL  |       21|
|   4619|EWR    |PHL  |       21|
|   4368|EWR    |BDL  |       21|
|   4619|EWR    |PHL  |       21|
|   2132|LGA    |BOS  |       21|
|   3650|JFK    |PHL  |       21|
|   4118|EWR    |BDL  |       21|
|   4276|EWR    |BDL  |       21|
|   4276|EWR    |BDL  |       21|
|   4276|EWR    |BDL  |       21|
|   4276|EWR    |BDL  |       21|
|   4577|EWR    |BDL  |       21|
|   6062|EWR    |BDL  |       21|
|   3847|EWR    |BDL  |       21|

In both cases, if the table contains ties, all rows containing a value that is present among the maximum or minimum selected values are presented, as it is the case with the rows containing the value `21` in the example above.


### Data manipulation example

Finally, the code below illustrates a more complex, multi-step operation using all the functions discussed above.

1. Start from the `flights` data.
2. Select origin, destination, departure delay, year, month, and day.
3. Filter only rows referring to flights in November.
4. Filter only rows where departure delay is not (notice that the negation operator `!` is used) `NA`.
  - That is necessary because the function `mean` would return `NA` as output if any of the values in the column is `NA`.
5. Group by destination.
6. Calculated the average delay per destination.
7. Add a column with the delay calculated in hours (minutes over 60).
8. Sort the table by *descending* delay (note that `-` is used before the column name).
9. Only show the first 5 rows.
10. Create a well-formatted table.


```r
flights %>%
  select(origin, dest, year, month, day, dep_delay) %>%
  filter(month == 11) %>%
  filter(!is.na(dep_delay)) %>%
  group_by(dest) %>%
  summarize(
    avg_dep_delay = mean(dep_delay)
  ) %>%
  mutate(
    avg_dep_delay_hours = avg_dep_delay / 60
  ) %>%
  arrange(-avg_dep_delay_hours) %>%
  slice_head(n = 5) %>%
  kable()
```



|dest | avg_dep_delay| avg_dep_delay_hours|
|:----|-------------:|-------------------:|
|SBN  |      67.50000|           1.1250000|
|BDL  |      26.66667|           0.4444444|
|CAK  |      19.70909|           0.3284848|
|BHM  |      19.61905|           0.3269841|
|DSM  |      16.14815|           0.2691358|


## Read and write data

The [`readr` library](https://readr.tidyverse.org/index.html) (also part of the Tidyverse) provides a series of functions that can be used to load from and save data to different file formats. 

Download from Blackboard (or the [data](https://github.com/sdesabbata/granolarr/tree/master/data) folder of the repository) the following files:

- `2011_OAC_Raw_uVariables_Leicester.csv`

Create a *Practical_214* project and make sure it is activated and thus the *Practical_214* showing in the *File* tab in the bottom-right panel. Upload the two files to the *Practical_214* folder by clicking on the *Upload* button and selecting the files from your computer (at the time of writing, Chrome seems to upload the file correctly, whereas it might be necessary to change the names of the files after upload using Microsoft Edge).

Create a new R script named `Data_Wrangling_Example.R` in the *Practical_214* project, and add `library(tidyverse)` as the first line. Use that new script for this and the following sections of this chapter.

The [2011 Output Area Classification](https://github.com/geogale/2011OAC) (2011 OAC) is a geodemographic classification of the census Output Areas (OA) of the UK, which was created by [Gale et al. (2016)](http://josis.org/index.php/josis/article/viewArticle/232) starting from an initial set of 167 prospective variables from the United Kingdom Census 2011: 86 were removed, 41 were retained as they are, and 40 were combined, leading to a final set of 60 variables. [Gale et al. (2016)](http://josis.org/index.php/josis/article/viewArticle/232) finally used the k-means clustering approach to create 8 clusters or supergroups (see [map at datashine.org.uk](https://oac.datashine.org.uk)), as well as 26 groups and 76 subgroups. The dataset in the file `2011_OAC_Raw_uVariables_Leicester.csv` contains all the original 167 variables, as well as the resulting groups, for the city of Leicester. The full variable names can be found in the file `2011_OAC_Raw_uVariables_Lookup.csv`.

<!--
Note that the `~` in the path below indicates the home folder -- a different path might be necessary if you execute this on a windows machine, please see also [file.path](https://stat.ethz.ch/R-manual/R-devel/library/base/html/file.path.html).
-->

The `read_csv` function reads a *Comma Separated Values (CSV)* file from the path provided as the first argument. The code below loads the 2011 OAC dataset. The `read_csv` instruction throws a warning that shows the assumptions about the data types used when loading the data. As illustrated by the output of the last line of code, the data are loaded as a tibble 969 x 190, that is 969 rows -- one for each OA -- and 190 columns, 167 of which represent the input variables used to create the 2011 OAC.


```r
leicester_2011OAC <- 
  read_csv("2011_OAC_Raw_uVariables_Leicester.csv")

leicester_2011OAC %>% 
  select(OA11CD,LSOA11CD, supgrpcode,supgrpname,Total_Population) %>%
  slice_head(n = 3) %>%
  kable()
```


|OA11CD    |LSOA11CD  | supgrpcode|supgrpname                  | Total_Population|
|:---------|:---------|----------:|:---------------------------|----------------:|
|E00069517 |E01013785 |          6|Suburbanites                |              313|
|E00069514 |E01013784 |          2|Cosmopolitans               |              323|
|E00169516 |E01013713 |          4|Multicultural Metropolitans |              341|

The function `write_csv` can be used to save a dataset as a `csv` file. For instance, the code below uses `tidyverse` functions and the pipe operator `%>%` to:

1. **read** the 2011 OAC dataset again directly from the file, but without storing it into a variable;
2. **select** the OA code variable `OA11CD`, and the two variables representing the code and name of the supergroup assigned to each OA by the 2011 OAC (`supgrpcode` and `supgrpname` respectively);
3. **filter** only those OA in the supergroup *Suburbanites* (code `6`);
4. **write** the results to a file named *Leicester_Suburbanites.csv*.


```r
read_csv("2011_OAC_Raw_uVariables_Leicester.csv") %>%
  select(OA11CD, supgrpcode, supgrpname) %>%
  filter(supgrpcode == 6) %>%
  write_csv("Leicester_Suburbanites.csv")
```




### File paths

File paths can be specified in two different ways:

- **Absolute file path**: the full file path, from the *root* folder of your computer to the file. 
  - The absolute file path of a file can be obtained using the `file.choose()` instruction from the *R Console*, which will open an interactive window that will allow you to select a file from your computer. The absolute path to that file will be printed to console.
  - Absolute file paths provide a direct link to a specific file and ensure that you are loading that exact file.
  - However, absolute file paths can be problematic if the file is moved, or if the script is run on a different system, and the file path would then be invalid
- **Relative file path**: a partial path, from the current working folder to the file. 
  - The current *working directory* (current folder) is part of the environment of the `R` session and can be identified using the `getwd()` instruction from the *`*R Console*.
    - When a new R session is started, the current *working directory* is usually the computer user's home folder.
    - When working within an R project, the current *working directory* is the project directory.
    - The current working can be manually set to a specific directory using the function `setwd`.
  - Using a relative path while working within an R project is the option that provides the best overall **consistency**, assuming that all (data) files to be read by scripts of a project are also contained in the project folder (or subfolder).


```r
# Absolute file path
# Note: the fist / indicates the root folder
read_csv("/home/username/GY7702/data/2011_OAC_Raw_uVariables_Leicester.csv")

# Relative file path
# assuming the working directory is the user home folder
# /home/username
# Note: no initial / for relative file paths
read_csv("GY7702/data/2011_OAC_Raw_uVariables_Leicester.csv")


# Relative file path
# assuming you are working within and R project created in the folder
# /home/username/GY7702
# Note: no initial / for relative file paths
read_csv("data/2011_OAC_Raw_uVariables_Leicester.csv")
```



## Loading R scripts

It is furthermore possible to load the function(s) defined in one script from another script -- in a fashion similar to when a library is loaded. Create a new R script named `Practical_204_RS_functions.R`, copy the code below in that R script and save the file 


```r
cube_root <- function (input_value) {
   result <- input_value ^ (1 / 3)
   result
}
```


Create a second R script named `Practical_204_RS_main.R`, copy the code below in that second R script and save the file.


```r
source("Practical_204_RS_functions.R")

cube_root(27)
```

Executing the `Practical_204_RS_main.R` instructs the interpreter first to run the `Practical_204_RS_functions.R` script, thus creating the `cube_root` function, and then invoke the function using `27` as an argument, thus returning again `3`. That is a simple example, but this can be an extremely powerful tool to create your own library of functions to be used by different scripts.



---

<small>by [Stefano De Sabbata](https://sdesabbata.github.io/) -- text licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence), code licensed under the [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html).</small>
