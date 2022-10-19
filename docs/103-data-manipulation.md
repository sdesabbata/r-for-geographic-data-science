# Data manipulation

<br/><small>*This chapter is currently a draft.*</small>

<br/><small><a href="javascript:if(window.print)window.print()">Print this chapter</a></small>


## R workflow

### R Projects

RStudio provides an extremely useful functionality to organise all your code and data, that is **R Projects**. Those are specialised files that RStudio can use to store all the information it has on a specific project that you are working on -- *Environment*, *History*, working directory, and much more, as we will see in the coming weeks.

In RStudio Server, in the *Files* tab of the bottom-left panel, click on *Home* to make sure you are in your home folder -- if you are working on your own computer, create a folder for these practicals wherever most convenient. Click on *New Folder* and enter *Practicals* in the prompt dialogue, to create a folder named *Practicals*. 

Select *File > New Project ...* from the main menu, then from the prompt menu, *New Directory*, and then *New Project*. Insert *Practical_103_example* as the directory name, and select the *Practicals* folder for the field *Create project as subdirectory of*. Finally, click *Create Project*. 

RStudio has now created the project, and it should have activated it. If that is the case, the *Files* tab in the bottom-right panel should be in the *Practical_103_example* folder, which contains only the *Practical_103_example.Rproj* file. The *Practical_103_example.Rproj* stores all the *Environment* information for the current project and all the project files (e.g., R scripts, data, output files) should be stored within the *Practical_103_example* folder. Moreover, the *Practical_103_example* is now your working directory, which means that you can refer to a file in the folder by using only its name and if you save a file that is the default directory where to save it. 

On the top-right corner of RStudio, you should see a blue icon representing an R in a cube, next to the name of the project (*Practical_103_example*). That also indicates that you are within the *Practical_103_example* project. Click on *Practical_103_example* and select *Close Project* to close the project. Next to the R in a cube icon, you should now see *Project: (None)*. Click on *Project: (None)* and select *Practical_103_example* from the list to reactivate the *Practical_103_example* project. In the future, you will thus be able to close and reactivate this or any other project as necessary, depending on what you are working with. Projects can also be activated by clicking on the related `.Rproj` file in the *Files* tab in the bottom-right panel or through the *Open Project...* option in the file menu.

With the *Practical_103_example* project activated, select from the top menu *File > New File > RMarkdown* to create a new RMarkdown document -- you can use the default options in the creation menu, as this is just an example. Save and *knit* the RMarkdown document ([as shown in the previous chapter](reproducible-data-science.html#rmarkdown)). As you can see, both the RMarkdown file and the knitted are saved within the *Practical_103_example* folder.



## Data: 2011 Census and OAC

The [2011 Output Area Classification](https://github.com/geogale/2011OAC) (2011 OAC) is a geodemographic classification of the census Output Areas (OA) of the UK, which was created by [Gale et al. (2016)](http://josis.org/index.php/josis/article/viewArticle/232) starting from an initial set of 167 prospective variables from the United Kingdom Census 2011: 86 were removed, 41 were retained as they are, and 40 were combined, leading to a final set of 60 variables. [Gale et al. (2016)](http://josis.org/index.php/josis/article/viewArticle/232) finally used the k-means clustering approach to create 8 clusters or supergroups (see [map at datashine.org.uk](https://oac.datashine.org.uk)), as well as 26 groups and 76 subgroups. The dataset in the file `2011_OAC_Raw_uVariables_Leicester.csv` contains all the original 167 variables, as well as the resulting groups, for the city of Leicester. 

Before continuing with the reminder of the practical, create a new project named *Leicester_population* and make sure it is activated. Download from Blackboard (or see the [data](https://github.com/sdesabbata/granolarr/tree/master/data) folder of the repository) the `2011_OAC_Raw_uVariables_Leicester.csv` file on your computer. The full variable names can be found in the file `2011_OAC_Raw_uVariables_Lookup.csv`.

Create a new RMarkdown document using *"Exploring population distribution in Leicester"* as title and *PDF* as output file type. Delete the example code after the `setup` chunk. Add a new markdown second-heading section named *Libraries* and a chunk loading the `tidyverse` and `knitr` libraries (see below). Save the file with name `exploring_Leicester_population.Rmd` in the *Leicester_population* project.

````
---
title: "Exploring population distribution in Leicester"
output: pdf_document
date: "2022-10-20"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Libraries

```{r libraries, warning=FALSE, message=FALSE}
library(tidyverse)
library(knitr)
```

````



Upload the `2011_OAC_Raw_uVariables_Leicester.csv` file to the *Leicester_population* folder by clicking on the *Upload* button and selecting the file from your computer.

**Important**: at the time of writing, Chrome seems to upload the file correctly, whereas it might be necessary to change the names of the files after upload using Microsoft Edge. If you are using Microsoft Edge, make sure the uploaded filename is `2011_OAC_Raw_uVariables_Leicester.csv` with not additional text. Otherwise, select the tick next to the file in the *File* tab in the botton-right panel, click *Rename* (on the panel's bar) and rename the file to `2011_OAC_Raw_uVariables_Leicester.csv`.



## Read and write data

The [`readr` library](https://readr.tidyverse.org/index.html) (also part of the Tidyverse) provides a series of functions that can be used to load from and save data to different file formats. 

The `read_csv` function reads a *Comma Separated Values (CSV)* file from the path provided as the first argument. The code below loads the 2011 OAC dataset. The `read_csv` instruction throws a warning that shows the assumptions about the data types used when loading the data. As illustrated by the output of the last line of code, the data are loaded as a tibble 969 x 190, that is 969 rows -- one for each OA -- and 190 columns, 167 of which represent the input variables used to create the 2011 OAC.


```r
# Read the Leicester 2011 OAC dataset from the csv file
leicester_2011OAC <- 
  read_csv("2011_OAC_Raw_uVariables_Leicester.csv")

# Illustrate some of the contents
leicester_2011OAC %>% 
  select(
    OA11CD, LSOA11CD, 
    supgrpcode, supgrpname,
    Total_Population
  ) %>%
  slice_head(n = 3) %>%
  kable()
```


|OA11CD    |LSOA11CD  | supgrpcode|supgrpname                  | Total_Population|
|:---------|:---------|----------:|:---------------------------|----------------:|
|E00069517 |E01013785 |          6|Suburbanites                |              313|
|E00069514 |E01013784 |          2|Cosmopolitans               |              323|
|E00169516 |E01013713 |          4|Multicultural Metropolitans |              341|

The function `write_csv` can be used to save a dataset as a `csv` file. For instance, the code below uses `tidyverse` functions and the pipe operator `%>%` to *reproduce* the `2011_OAC_supgrp_Leicester.csv` dataset used [in the lecture](slides/103-slides-data-manipulation.html):

1. **read** the 2011 OAC dataset firle `2011_OAC_Raw_uVariables_Leicester.csv` directly from the file, but without storing it into a variable;
2. **select** the OA code variable `OA11CD`, and the two variables representing the code and name of the supergroup assigned to each OA by the 2011 OAC (`supgrpcode` and `supgrpname` respectively);
3. **filter** only those OA in the supergroup *Suburbanites* (code `6`);
4. **write** the results to a file named `my--2011_OAC_supgrp_Leicester.csv`, which is your own version of the `2011_OAC_supgrp_Leicester.csv`.


```r
read_csv("2011_OAC_Raw_uVariables_Leicester.csv") %>%
  select(
    OA11CD, LSOA11CD, 
    supgrpcode, supgrpname,
    Total_Population
  ) %>%
  write_csv("my--2011_OAC_supgrp_Leicester.csv")
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




## Data manipulation

The analysis below uses the [`dplyr`](https://dplyr.tidyverse.org/) library (also part of the Tidyverse), which it offers a grammar for data manipulation.

For instance, the function `count` can be used to count the number of rows in a data frame. The code below provides the `leicester_2011OAC` dataframe (as read in input in the section above) as input to the function `count` through the pipe operator, thus creating a new [`tibble`](https://tibble.tidyverse.org/) with only one row and one column, containing the number of rows in that dataframe -- that is, the number of OAs in Leicester. 



```r
leicester_2011OAC %>%
  count() %>%
  kable()
```



|   n|
|---:|
| 969|

As discussed in the previous lecture, a [`tibble`](https://tibble.tidyverse.org/) is data type similar to data frames, used by all the Tidyverse libraries. All Tidyverse functions output `tibble` rather than `data.frame` objects when representing a table. However, `data.frame` object can be provided as input, as they are automatically converted by Tidyverse functions before proceeding with the processing steps.

The example above already shows how the **pipe operator** can be used effectively in a multi-step operation. In the `tibble` outputted by the `count` function above, the column `n` provides the count. The function `kable` of the library `knitr` is used to produce a well-formatted table.

Note how, the code above goes to a new line after every `%>%`, and space is added at the beginning of new lines. That is very common in R programming (especially when functions have many parameters) as it makes the code more readable.


### Summarise

The verb `count` is a special case (a shorthand) of the more general verb `summarise` (`summarize` using the American English spelling is also available with the same functionality), which allows to create generate tables presenting aggregate values of input data. 

For instance, `summarise` can be use to create a table containing:

- a column presenting the total population of Leicester;
- a column presenting the total number of OAs in Leicester;
- a column presenting the average population per OAs in Leicester;
- a column presenting a logical values stating whether any OA in Leicester contains more than 600 people.

That can be achieved applying different aggregate functions to the same column (`Total_Population`) of the `leicester_2011OAC` as illutratete below.

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

The function `mutate` can be used to create a new column by conducting operations on current columns. For instance, in the example below, `summarise` is first used to calculate the total number of people and the number of OAs per 2011 OAC supergroup. The verb `mutate` is then used to calculate the average population per OA per 2011 OAC supergroup, recreating the same `avg_pop` column as above, but through a different process.


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

The function `arrange` can be used to sort a tibble by ascending order of the values in the specified column. If the operator `-` is specified before the column name, the descending order is used. The code below would produce a table showing the ten OAs with the larges population in Leicester.


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

In the example above, we have used `slice_head` to present only the first `n` (in the example `10`) rows in a table, based on the existing order. The `dplyr` library also provides the functions `slice_max` and `slice_min` which incorporate the sorting functionality (see [`slice` reference page](https://dplyr.tidyverse.org/reference/slice.html)).

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

In both cases, if the table contains ties, all rows containing a value that is present among the maximum or minimum selected values are presented, as it is the case with the rows containing the value `21` in the example above.


### Data manipulation example

Finally, the code below illustrates a more complex, multi-step operation using all the functions discussed above. This is a full example of a short analysis using only one series of pipes to read, process and write data using `R` and almost all the `tidyverse` *verbs* seen so far.

The input data are read from the csv file, part of the data are selected and filtered. The data are grouped and aggregate, arranged in order and the percentage of people living in OAs assigned to each 2011 OAC supergroup is calculated. The [Tee pipe](https://magrittr.tidyverse.org/reference/tee.html) (from the `magrittr` library) is used to write the resulting talbe to a file, while also passing the same input to the subsequent `kable` function to display the data.


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
  # and the pass the same input values to the kable function
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

### Componentization

It is important to note that in the example above, no information is stored in the local environment. The input is read directly from the computer storage, the whole process is conducted in the `R` internal memory and the output is saved back to the computer storage. That is the whole purpose of the pipe operator: to avoid creating unnecessary and temporary "mid-products" during the computation (i.e., variables whose only purpose is to store the data before the next step). However, it is frequently useful to split the processing in different steps, which allow the data to be inspected mid-way through the analysis or for the data to be used twice in two subsequent steps. Finding a good balance between too long and too short pipe sequences and too many or two few "mid-products" is the programmer's task -- and something that can only be learnt by experience and observing good examples of code.

The following example showcases how the process above can be subdivided into five meaningful steps. 

1. Read the data. This is frequently done as a separate step, as some dataset might require significant time to be read from computer storage and it is frequently best to read them only once.
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



## How to cite

### References

Academic references can be added to RMarkdown [as illustrated in the R Markdown Cookbook](https://bookdown.org/yihui/rmarkdown-cookbook/bibliography.html) [@xie2020r]. Bibtex references can be added to a separate `.bib` file that can be then linked to in the heading of the RMarkdown document. References can then be cited using the `@` symbol followed by the reference id.

For instance, this documents links to the `references.bib` bibtex file, which contains the academic references, and the `packages.bib` bibtex files, which contains additional reference for the R packages (see also next section), by adding the following line in the heading.

````
bibliography: [references.bib, packages.bib]
````

The `references.bib` contains the following reference for the R Markdown Cookbook book.

````
@book{xie2020r,
  title={R markdown cookbook},
  author={Xie, Yihui and Dervieux, Christophe and Riederer, Emily},
  year={2020},
  publisher={Chapman and Hall/CRC},
  url = {https://bookdown.org/yihui/rmarkdown-cookbook/}
}
````

That allows to write the first sentence of this section as follows.

````
Academic references can be added to RMarkdown [as illustrated in the R Markdown Cookbook](https://bookdown.org/yihui/rmarkdown-cookbook/bibliography.html) [@xie2020r].
````

Bibtex references can be obtained from most journals or by clicking on the *Cite* link under a paper in [Google Scholar](https://scholar.google.com/) and then selecting *Bibtex*.

### Code

The UK's [Software Sustainability Institute](https://www.software.ac.uk/about) provides clear guidance about [how to cite software](https://www.software.ac.uk/how-cite-software) written by others. As outlined in the guidance, you should always cite and credit their work. However, using academic-style citations is not always straightforward when working with libraries, as most of them are not linked to an academic paper nor provide a [DOI](https://www.doi.org/). In such cases, you should at least include a link to the authors' website or repository in the script or final report when using a library. For instance, you can add a link to the Tidyverse's  [website](https://tidyverse.tidyverse.org/), [repository](https://github.com/tidyverse/tidyverse) or [CRAN page](https://cran.r-project.org/web/packages/tidyverse/index.html) when using the library. However, @tidyverse2019 also wrote a paper on their work on the Tidyverse for the [Journal of Open Source Software](https://joss.theoj.org/), so you can also cite their paper [using Bibtex in RMarkdown](https://bookdown.org/yihui/rmarkdown-cookbook/bibliography.html).

<!-- The two following paragraphs contain text adapted from text by Dr. Jorg D. Kaduk, jk61@leicester.ac.uk -->

Appropriate citations are even more important when directly copying or adapting code from others' work. Plagiarism principles apply to code as much as they do to text. The Massachusetts Institute of Technology (MIT)'s [*Academic Integrity at MIT: A Handbook for Students*](https://integrity.mit.edu/) includes a section on [writing code](https://integrity.mit.edu/handbook/writing-code) which provides good guidance on when and how to cite code that you include in your projects or you adapt for your own code properly. 
That also applies to re-using your own code, which you have written before. It is important that you refer to your previous work and fully acknowledge all previous work that has been used in a project so that others can find everything you have used in a project.

It is common practice to follow a particular referencing style for the in-text quotations, references and bibliography, such as the Harvard style (see, e.g., the [Harvard Format Citation Guide](https://www.mendeley.com/guides/harvard-citation-guide/) available [Mendeley](https://www.mendeley.com/)'s help pages). 
Following such guidelines will not only ensure that others can more easily use and reproduce your work but also that you demonstrate academic honesty and integrity.



## Exercises 103.1

Create an RMarkdown document in RStudio, using *Exercise 103* as title and *PDF* as output. Delete all the contents except the first five lines which compose the heading. Save the document as `practical-103_exercises.Rmd`. Add the libraries and code necessary to read the data from the `2011_OAC_Raw_uVariables_Leicester.csv` file. Create a first section of the document (e.g., adding a second heading *Exercise 103.1*) and add your answers to the questions below.

In order to answer the questions below, inspect the **look-up** table `2011_OAC_Raw_uVariables_Lookup.csv` (e.g., using Microsoft Excel) to identify the columns necessary to complete the task.

**Question 103.1.1:** Identify the five variables which are part of the variable subdomain *Housing Type* and write the code necessary to compute the total number of household spaces in Leicester for each housing type.

**Question 103.1.2:** Write the code necessary to compute the total number of household spaces in Leicester for each housing type grouped by 2011 OAC supergroup.

**Question 103.1.3:** Write the code necessary to compute the percentage of household spaces (i.e., over to the total number of household spaces) in Leicester for each housing type grouped by 2011 OAC supergroup.

**Question 103.1.4:** Modify the code written for *Question 103.1.3*, using [the verb `rename`](https://dplyr.tidyverse.org/reference/rename.html) to change the column names of the columns containing the percentages to names that resemble the related housing type (e.g., `perc_of_detached`).



## Exercises 103.2

**Question 103.2.1:** Explore the **look-up** table `2011_OAC_Raw_uVariables_Lookup.csv` and identify another set of variables that you think might relate to the the type of housing and the 2011 OAC supergroups. Create a new section of the document (e.g., adding a second heading) and include a short text (up to 200 words) in the RMarkdown document describing and justifying the set of variables you choose.

**Question 103.2.2:** Write the code necessary to conduct the same analysis conducted for *Question 103.1* but using the variables identified in *Question 103.2.1*.

**Question 103.2.3:** Inspect the table obtained from your answer to *Question 103.1.3* and the table obtained from your answer to *Question 103.2.2*, and compare the results. Write a short text (up to 300 words) in the RMarkdown document reporting and discussing what the results tell you about the socio-demographic structure of Leicester.



---

<small>by [Stefano De Sabbata](https://sdesabbata.github.io/) -- text licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence), code licensed under the [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html).</small>
