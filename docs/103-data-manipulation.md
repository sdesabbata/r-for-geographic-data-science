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
  kable()
```



|supgrpname                  | tot_pop| num_of_OAs|pop_over_600 |  avg_pop|
|:---------------------------|-------:|----------:|:------------|--------:|
|Constrained City Dwellers   |    9263|         36|FALSE        | 257.3056|
|Cosmopolitans               |   26813|         83|TRUE         | 323.0482|
|Ethnicity Central           |   19137|         57|FALSE        | 335.7368|
|Hard-Pressed Living         |   32069|        101|FALSE        | 317.5149|
|Multicultural Metropolitans |  205007|        573|TRUE         | 357.7784|
|Suburbanites                |   17326|         54|FALSE        | 320.8519|
|Urbanites                   |   20224|         65|FALSE        | 311.1385|

In this second example, the `u005` column (which represents the area of the OA in [hectares](https://en.wikipedia.org/wiki/Hectare), see `2011_OAC_Raw_uVariables_Lookup.csv`) is used to calculate the population density for each OA.


```r
leicester_2011OAC %>%
  mutate(
    # Population density
    pop_density = Total_Population / u005, 
  ) %>% 
  slice_head(n = 10) %>% 
  kable()
```



|OA11CD    |LSOA11CD  |LSO11ANM       |MSOA11CD  |MSOA11NM      |LAD11CD   |LAD11NM   | supgrpcode|supgrpname                  |grpcode |grpname                   |subgrpcode |subgrpname                    | Total_Population| Total_Households| Total_Dwellings| Total_Household_Spaces| Total_Population_16_and_over| Total_Population_16_to_74| Total_Pop_No_NI_Students_16_to_74| Total_Employment_16_to_74| Total_Pop_in_Housesholds_16_and_over| Total_Population_3_and_over| u001| u002| u003| u004| u005|      u006| u007| u008| u009| u010| u011| u012| u013| u014| u015| u016| u017| u018| u019|     u020| u021| u022| u023| u024| u025| u026| u027| u028| u029| u030| u031| u032| u033| u034| u035| u036| u037| u038| u039| u040| u041| u042| u043| u044| u045| u046| u047| u048| u049| u050| u051| u052| u053| u054| u055| u056| u057| u058| u059| u060| u061| u062| u063| u064| u065| u066| u067| u068| u069| u070| u071| u072| u073| u074| u075| u076| u077| u078| u079| u080| u081| u082| u083| u084| u085| u086| u087| u088| u089| u090| u091| u092| u093| u094| u095| u096| u097| u098| u099| u100| u101| u102| u103|      u104| u105| u106| u107| u108| u109| u110| u111| u112| u113| u114| u115| u116| u117| u118| u119| u120| u121| u122| u123| u124| u125| u126| u127| u128| u129| u130| u131| u132| u133| u134| u135| u136| u137| u138| u139| u140| u141| u142| u143| u144| u145| u146| u147| u148| u149| u150| u151| u152| u153| u154| u155| u156| u157| u158| u159| u160| u161| u162| u163| u164| u165| u166| u167| pop_density|
|:---------|:---------|:--------------|:---------|:-------------|:---------|:---------|----------:|:---------------------------|:-------|:-------------------------|:----------|:-----------------------------|----------------:|----------------:|---------------:|----------------------:|----------------------------:|-------------------------:|---------------------------------:|-------------------------:|------------------------------------:|---------------------------:|----:|----:|----:|----:|----:|---------:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|--------:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|---------:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|-----------:|
|E00069517 |E01013785 |Leicester 020D |E02002846 |Leicester 020 |E06000016 |Leicester |          6|Suburbanites                |6a      |Suburban Achievers        |6a1        |Indian Tech Achievers         |              313|              117|             119|                    119|                          242|                       225|                               225|                       160|                                  242|                         302|  150|  163|  313|    0| 9.29|  33.69214|   18|   23|   24|   18|   13|    7|   57|   83|   23|   30|   12|    4|    1| 40.40256| 44.0|   64|  147|    0|    3|   13|   15|  269|    6|   13|   12|    0|    0|    0|    4|    3|    6|  180|   21|   89|   23|  294|    3|    1|    2|   13|  301|    1|    0|    0|  144|   20|    4|   46|    3|    3|    7|   15|   13|    9|   10|   23|   31|    8|    7|    3|    0|    3|    2|    3|    0|    1|    4|    2|   31|    0|    2|    1|   22|   80|    0|   13|    2|  117|    2|   67|   50|    1|    1|    0|  113|    1|    2|    1|  104|   11|    2|    0|    0|   97|   20|    0|    0|  31.10613|  183|  103|   22|    4|    1|   45|   28|   62|   35|  112|   15|    6|   51|   60|   14|   11|  113|   22|   30|   92|   34|    4|    5|   38|   10|   11|    1|    0|    1|    1|    1|    2|   19|   27|   98|   16|    1|    0|   10|    0|    0|    8|   14|    3|    2|    3|   11|    3|   18|    5|   15|   39|   19|    9|   21|   41|   29|   21|   18|   12|    6|    3|    9|    33.69214|
|E00069514 |E01013784 |Leicester 023G |E02002849 |Leicester 023 |E06000016 |Leicester |          2|Cosmopolitans               |2a      |Students Around Campus    |2a3        |Students and Professionals    |              323|              139|             145|                    149|                          306|                       287|                               287|                       192|                                  290|                         316|  180|  143|  307|   16| 2.46| 131.30081|    8|    6|    3|   10|   99|   65|   70|   26|    8|    9|    6|    7|    6| 33.18885| 27.0|  229|   42|    2|    7|    9|   17|  260|   20|   12|   11|    2|    0|    3|    0|   13|    2|  120|   18|  163|   22|  279|    2|    5|   12|   25|  298|   13|    4|    1|   38|   60|    4|  168|    1|    6|    8|    5|    5|   44|    1|   12|    3|    2|   22|    3|    0|    3|    1|    0|   17|    1|   25|    3|   23|    1|    1|    1|   49|   69|    2|    6|   13|  139|   10|    1|    6|  114|   28|    0|   55|    5|   79|    0|   70|   28|   21|   13|    7|   96|   41|    1|    1|  83.56161|  168|  114|   31|    8|    2|   19|   37|   51|   89|  114|   92|   58|   46|   35|    5|   17|  102|   68|   29|  123|   16|   14|   28|    5|   64|    2|    5|    1|    1|    0|    1|    8|   22|   32|  125|   13|    0|    0|   19|    7|    3|    8|   31|    4|   17|    7|    9|    2|   20|   10|   11|   20|   18|    6|   20|   38|   40|   15|   14|   13|   24|   12|   16|   131.30081|
|E00169516 |E01013713 |Leicester 010A |E02002836 |Leicester 010 |E06000016 |Leicester |          4|Multicultural Metropolitans |4b      |Challenged Asian Terraces |4b2        |Pakistani Communities         |              341|              104|             107|                    107|                          294|                       282|                               282|                       161|                                  294|                         334|  177|  164|  341|    0| 1.42| 240.14085|   11|   12|   19|   42|   42|   28|   58|   88|    9|   20|   11|    1|    0| 36.35777| 32.0|   96|  169|    0|    3|   10|   16|   13|    7|    2|  300|    4|    0|    0|   12|    3|    0|   15|  316|    5|    5|  107|    1|    4|    2|  227|  168|   88|   66|   12|  148|    2|    2|   92|   21|    3|   10|   16|    9|    9|    7|   10|   21|   13|    1|    0|    0|    7|    6|   12|    1|    0|    8|    5|   23|    5|    0|    2|   18|   80|    4|    0|    2|  104|    3|    2|    5|   80|   20|    0|   65|   10|   28|    1|   33|   20|   27|   15|    9|   48|   45|    6|    5| 106.82139|  178|  106|   39|   11|    7|   46|   95|   67|   19|   45|   49|   42|   43|   19|    8|   18|   94|   41|   35|  101|   16|   17|   17|   28|   34|   17|    9|    8|    8|    3|    6|    6|   20|   32|  102|    7|    0|    0|   57|    5|    2|    6|   28|    1|   10|    6|    0|    0|    9|    8|    5|    6|   11|    7|    8|   11|   10|    9|   13|   10|   19|   38|   43|   240.14085|
|E00169048 |E01032862 |Leicester 009E |E02002835 |Leicester 009 |E06000016 |Leicester |          4|Multicultural Metropolitans |4b      |Challenged Asian Terraces |4b1        |Asian Terraces and Flats      |              345|              119|             127|                    127|                          230|                       227|                               227|                       146|                                  230|                         317|  170|  175|  345|    0| 3.31| 104.22961|   45|   37|   26|   18|   24|   50|  101|   34|    3|    4|    2|    0|    1| 25.38261| 27.0|   89|  115|    0|   12|    7|    7|  116|   22|    7|  102|   13|    3|    3|   14|   28|   37|   94|  178|   67|    6|  228|    2|    1|   17|   97|  262|   40|   13|    2|  110|   28|    0|   63|    9|    7|    6|    7|    2|   26|    0|   10|   33|    2|    8|    4|    0|   17|    1|    7|    0|    0|    9|   18|   16|    3|    3|   11|   28|   80|    4|    6|    1|  119|    8|   14|   26|   49|   38|    0|   48|   18|   52|    1|   39|   24|   23|   26|    7|   55|   60|    4|    0|  59.04523|  186|  121|   24|    9|    5|   32|   39|   64|   24|   80|   29|   23|   58|   38|    6|   20|  111|    9|   31|   98|   14|   15|    6|    4|   23|   13|   14|    9|    3|    1|    3|    6|   11|   27|   95|   13|    0|    0|   27|    2|    1|    9|   32|    8|    4|    6|   10|    0|    9|    6|    4|    4|   21|    3|   11|   25|   19|   15|   10|   11|   15|   23|   17|   104.22961|
|E00169044 |E01032862 |Leicester 009E |E02002835 |Leicester 009 |E06000016 |Leicester |          4|Multicultural Metropolitans |4c      |Asian Traits              |4c2        |Multicultural New Arrivals    |              322|              112|             116|                    116|                          232|                       231|                               231|                       148|                                  232|                         298|  150|  172|  322|    0| 3.25|  99.07692|   46|   23|   20|   19|   20|   53|   90|   35|    7|    8|    1|    0|    0| 27.37578| 28.0|   82|  125|    0|    5|   16|    4|   92|   13|   17|  127|    6|    3|    3|   18|   34|    9|   80|  168|   59|   15|  212|    0|    4|    8|   98|  258|   26|   11|    3|  120|   18|    4|   65|    5|    4|   12|    4|    2|   20|    0|   15|   26|    4|    5|    5|    0|   16|    3|   13|    0|    0|    3|   11|   10|    6|    3|    7|   22|   71|    8|    8|    3|  112|    4|   19|   32|   34|   31|    0|   69|   16|   27|    0|   37|   29|   33|   10|    3|   58|   49|    5|    0|  76.20880|  152|  114|   38|   12|    6|   31|   29|   83|   35|   67|   27|   22|   62|   28|    7|   25|  110|    6|   32|   98|   13|   16|    9|   12|   21|    9|   15|    6|    6|    3|    3|    9|   12|   29|   93|   14|    0|    0|   12|   10|    0|    9|   27|    4|    5|    5|    5|    1|    6|    8|   14|   13|   21|    8|   14|   26|   16|   26|   11|   15|   17|    6|   17|    99.07692|
|E00069041 |E01013679 |Leicester 035B |E02002861 |Leicester 035 |E06000016 |Leicester |          4|Multicultural Metropolitans |4a      |Rented Family Living      |4a1        |Social Renting Young Families |              334|              115|             120|                    120|                          239|                       229|                               229|                       109|                                  239|                         317|  164|  170|  334|    0| 6.51|  51.30568|   32|   27|   28|   28|   27|   23|   71|   61|   11|   16|    8|    1|    1| 31.63772| 30.0|  112|   66|    2|   15|   31|   13|  253|   14|   30|   11|    4|    0|    0|    3|   19|    0|  117|   28|  167|   22|  290|    3|    5|    6|   30|  308|    7|    1|    1|   60|   34|    0|   91|    8|   12|   23|   11|    9|   18|    1|    5|   14|    9|    2|   12|    1|   20|    8|    6|    1|    0|    9|   21|   26|    5|    1|   14|   27|   68|    6|   11|    3|  115|    5|    4|  102|    4|   10|    0|   28|   74|   12|    1|   41|   35|   26|   11|    2|   60|   50|    5|    0|  91.70296|  146|  118|   47|   16|    7|   32|  110|   73|   23|   18|   27|   43|   49|   23|    0|   16|   79|   14|   34|   56|   12|   28|    9|   15|   18|   25|   24|    8|    7|    4|   11|    9|    8|   31|   57|   13|    0|    0|   15|    6|    0|   11|   25|    6|    2|    3|    1|    1|    2|   10|    2|    4|   18|    3|    5|    7|    5|    8|   15|   12|   14|   19|   24|    51.30568|
|E00169049 |E01032862 |Leicester 009E |E02002835 |Leicester 009 |E06000016 |Leicester |          4|Multicultural Metropolitans |4c      |Asian Traits              |4c3        |Inner City Ethnic Mix         |              336|              119|             121|                    121|                          235|                       235|                               235|                       177|                                  235|                         300|  165|  171|  336|    0| 7.90|  42.53165|   49|   29|   21|    9|   27|   64|   87|   33|    8|    9|    0|    0|    0| 26.37202| 27.5|   78|  132|    2|    6|   11|    6|  113|   25|   17|  136|    8|    0|    5|    8|    9|   15|  114|  169|   44|    9|  228|    0|    3|   17|   88|  254|   36|    7|    3|  122|   40|    4|   44|    9|    3|    7|    6|    0|   21|    0|   12|   30|    6|   15|    4|    0|   14|    2|    8|    0|    0|    7|    8|    6|    5|    3|    6|   21|   82|    4|   12|    0|  119|    2|   38|   31|   23|   29|    0|   63|   14|   42|    0|   55|   25|   22|   13|    4|   67|   46|    5|    1|  36.78563|  182|  124|   25|    3|    2|   21|   30|   72|   32|   82|   17|   12|   56|   51|    8|   13|  151|    5|   31|  124|   20|    6|    2|   12|   15|   16|    4|    5|    1|    0|    1|    3|    7|   33|  110|   27|    0|    0|   21|    2|    1|    9|   32|   14|    4|    5|    9|    0|   13|    9|   12|   18|   22|    6|   22|   40|   21|   28|   13|   14|   11|   18|   10|    42.53165|
|E00068806 |E01013628 |Leicester 006B |E02002832 |Leicester 006 |E06000016 |Leicester |          4|Multicultural Metropolitans |4b      |Challenged Asian Terraces |4b2        |Pakistani Communities         |              312|              111|             113|                    113|                          265|                       219|                               219|                       107|                                  230|                         302|  127|  185|  277|   35| 5.40|  57.77778|   16|   17|   11|   17|   32|   18|   51|   67|   22|   15|   24|   13|    9| 43.07372| 43.0|   78|  100|    0|   12|   26|   49|   40|    8|    7|  215|   13|    4|    0|   14|    6|    5|   37|  242|   14|   19|  132|    0|    2|    0|  178|  180|   57|   43|   22|   88|   10|    0|   69|    6|   11|   23|   23|   10|   24|    0|   11|   11|   11|    2|    1|    1|   17|   14|    7|    0|    0|    2|   12|   35|    4|    2|   11|   34|   66|    6|    3|    2|  111|    2|    8|   24|   44|   36|    1|   45|   58|    6|    2|   37|   20|   33|   15|    6|   71|   38|    2|    0| 218.29172|  104|   81|   58|   54|   15|   44|   94|   65|   18|   28|   20|   48|   44|   19|    1|   29|   63|   14|   33|   55|   12|   20|   10|   16|   13|   14|   35|   11|    8|    4|    3|    8|   14|   27|   60|    6|    1|    0|   19|    2|    0|    7|   27|    3|   11|    3|    3|    2|    3|    7|    3|    7|    6|    3|    4|   12|    3|   14|   11|    6|   22|   14|   21|    57.77778|
|E00068886 |E01013647 |Leicester 040B |E02006850 |Leicester 040 |E06000016 |Leicester |          3|Ethnicity Central           |3a      |Ethnic Family Life        |3a2        |Young Families and Students   |              505|              198|             197|                    200|                          430|                       393|                               393|                       146|                                  402|                         493|  232|  273|  477|   28| 4.11| 122.87105|   18|   20|   31|   67|  150|   35|   74|   42|   13|   18|   13|   14|   10| 31.66337| 22.0|  290|   74|    0|   11|   25|   30|  252|   24|   14|   66|    2|    3|   14|   18|   89|   23|  201|  145|  124|   35|  355|    3|   13|   15|  119|  425|   47|   14|    7|   68|   32|    6|  253|    7|    8|   22|    6|    7|   64|    6|    4|   15|    6|    9|    3|    1|   21|    8|    3|   38|    0|   13|   17|   81|    4|    4|   13|   71|   94|    9|    4|   20|  198|    2|   10|   31|   75|   84|    0|   21|   83|   91|    3|   34|   31|   68|   34|   31|   92|  101|    3|    2| 112.95937|  248|  161|   60|   28|    8|   39|  105|   79|  158|   56|  208|  121|   63|   14|    2|   22|   47|   75|   22|   56|   10|   31|   72|   24|  138|   10|   22|    8|    6|    2|    6|   14|   36|   43|   63|    4|    0|    0|    8|    1|    1|    1|   40|    2|   20|    8|    1|    3|    3|   10|    2|   16|   22|    8|   10|   20|   18|   11|   11|   10|   26|    8|   32|   122.87105|
|E00068807 |E01013624 |Leicester 007A |E02002833 |Leicester 007 |E06000016 |Leicester |          4|Multicultural Metropolitans |4a      |Rented Family Living      |4a1        |Social Renting Young Families |              362|              137|             138|                    138|                          272|                       224|                               224|                       111|                                  272|                         348|  175|  187|  362|    0| 4.75|  76.21053|   24|   33|   28|   31|   11|   20|   68|   51|   17|   31|   37|    6|    5| 39.28729| 39.0|   96|  116|    0|    8|   25|   27|  214|    1|   16|   70|   14|    0|    0|   23|   24|    0|  146|  101|   84|   31|  283|    0|    2|    1|   76|  313|   15|   16|    4|  102|   22|    4|   82|   12|    7|   18|   25|   25|   18|   15|    4|   21|    6|    0|    5|    3|   15|    9|    9|    0|    2|    5|   14|   49|    3|    0|   10|   43|   80|    8|    4|    2|  137|    1|    7|   51|   57|   23|    0|    7|  122|    5|    3|   51|   35|   36|    9|    6|   82|   48|    5|    2| 151.18100|  132|  121|   73|   26|   10|   40|  149|   71|   15|   17|   24|   60|   63|   14|    3|   12|   67|   29|   33|   55|   14|   22|    9|   34|   15|   16|   12|   14|    7|    4|    9|   10|   13|   34|   57|    7|    0|    0|   22|    0|    1|    6|   15|    7|    6|    0|    0|    2|    1|   13|    2|   12|   18|    6|    4|    6|    3|    6|    8|   22|    7|   25|   30|    76.21053|


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
  kable(
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


|supgrpname                  | tot_pop|  perc_pop|
|:---------------------------|-------:|---------:|
|Multicultural Metropolitans |  205007| 62.153657|
|Hard-Pressed Living         |   32069|  9.722622|
|Cosmopolitans               |   26813|  8.129117|
|Urbanites                   |   20224|  6.131476|
|Ethnicity Central           |   19137|  5.801921|
|Constrained City Dwellers   |    9263|  2.808340|

### Saving mid-products

It is important to note that in the example above, no information is stored in the local environment. The input is read directly from the computer storage, the whole process is conducted in the `R` internal memory and the output is saved back to the computer storage. That is the whole purpose of the pipe operator: to avoid creating unnecessary and temporary mid-products during the computation (i.e., variables whose only purpose is to store the data before the next step). However, it is frequently useful to split the processing in different steps, which allow the data to be inspected mid-way through the analysis or for the data to be used twice in two subsequent steps. Finding a good balance between too long and too short pipe sequences and too many or two few mid-products is the programmer's task -- and something that can only be learnt by experience and observing good examples of code.

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
  kable()
```



|supgrpname                  | tot_pop|  perc_pop|
|:---------------------------|-------:|---------:|
|Multicultural Metropolitans |  205007| 62.153657|
|Hard-Pressed Living         |   32069|  9.722622|
|Cosmopolitans               |   26813|  8.129117|
|Urbanites                   |   20224|  6.131476|
|Ethnicity Central           |   19137|  5.801921|
|Constrained City Dwellers   |    9263|  2.808340|


```r
leicester_nonsuburb_pop %>% 
  # Write the calculated values to file
  write_csv(
    "2011_Leicester_pop_per_OAC_supgrp_excl_suburb.csv"
  ) 
```



## How to cite code

The UK's [Software Sustainability Institute](https://www.software.ac.uk/about) provides clear guidance about [how to cite software](https://www.software.ac.uk/how-cite-software) written by others. As outlined in the guidance, you should always cite and credit their work. However, using academic-style citations is not always straightforward when working with libraries, as most of them are not linked to an academic paper nor provide a [DOI](https://www.doi.org/). In such cases, you should at least include a link to the authors' website or repository in the script or final report when using a library. For instance, you can add a link to the Tidyverse's  [website](https://tidyverse.tidyverse.org/), [repository](https://github.com/tidyverse/tidyverse) or [CRAN page](https://cran.r-project.org/web/packages/tidyverse/index.html) when using the library. However, @tidyverse2019 also wrote a paper on their work on the Tidyverse for the [Journal of Open Source Software](https://joss.theoj.org/), so you can also cite their paper [using Bibtex in RMarkdown](https://bookdown.org/yihui/rmarkdown-cookbook/bibliography.html).

<!-- The two following paragraphs contain text adapted from text by Dr. Jorg D. Kaduk, jk61@leicester.ac.uk -->

Appropriate citations are even more important when directly copying or adapting code from others' work. Plagiarism principles apply to code as much as they do to text. The Massachusetts Institute of Technology (MIT)'s [*Academic Integrity at MIT: A Handbook for Students*](https://integrity.mit.edu/) includes a section on [writing code](https://integrity.mit.edu/handbook/writing-code) which provides good guidance on when and how to cite code that you include in your projects or you adapt for your own code properly. 
That also applies to re-using your own code, which you have written before. It is important that you refer to your previous work and fully acknowledge all previous work that has been used in a project so that others can find everything you have used in a project.

It is common practice to follow a particular referencing style for the in-text quotations, references and bibliography, such as the Harvard style (see, e.g., the [Harvard Format Citation Guide](https://www.mendeley.com/guides/harvard-citation-guide/) available [Mendeley](https://www.mendeley.com/)'s help pages). 
Following such guidelines will not only ensure that others can more easily use and reproduce your work but also that you demonstrate academic honesty and integrity.

## Exercises 103.1



---

<small>by [Stefano De Sabbata](https://sdesabbata.github.io/) -- text licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence), code licensed under the [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html).</small>
