# Reproducibility

<br/><small><a href="javascript:if(window.print)window.print()">Print this chapter</a></small>

According to @gandrud2018reproducible, a quantitative analysis or project can be considered to be **reproducible** if: *"the data and code used to make a finding are available and they are sufficient for an independent researcher to recreate the finding"*. Reproducibility practices are rooted in software engineering, including project design practices (such as [Scrum](https://en.wikipedia.org/wiki/Scrum_(software_development))), software readability principles, testing and versioning.

In GIScience, programming was essential to interact with early GIS software such as [ArcInfo](https://en.wikipedia.org/wiki/ArcInfo) in the 1980s and 1990s, up until the release of the [ArcGIS 8.0](https://en.wikipedia.org/wiki/ArcGIS#ArcMap_8.0) suite in 1999, which included a graphical user interface. The past decade has seen a gradual return to programming and scripting in GIS, especially where languages such as R and Python allowed to combine GIS capabilities with much broader data science and machine learning functionalities. Many disciplines have seen a similar trajectory, and as programming and data science become more integral to science, reproducibility practices become a cornerstone of scientific development. 

Nowadays, many academic journals and conferences require some level of reproducibility when submitting a paper (e.g., see the [AGILE Reproducible Paper Guidelines](https://osf.io/numa5/) from the [Association of Geographic Information Laboratories in Europe](https://agile-online.org/)). Companies are keen on reproducible analysis, which is more reliable and more efficient in the long term. Second, as the amount of data increases, reproducible approaches effectively create reliable analysis that can be more easily verified and reproduced on different or new data. @doi:10.1080/13658816.2015.1137579 have discussed the issue of reproducibility in GIScience, identifying the following best practices:

1. *"Data should be accessible within the public domain and available to researchers"*.
2. *"Software used should have open code and be scrutable"*.
3. *"Workflows should be public and link data, software, methods of analysis and presentation with discursive narrative"*.
4. *"The peer review process and academic publishing should require submission of a workflow model and ideally open archiving of those materials necessary for replication"*.
5. *"Where full reproducibility is not possible (commercial software or sensitive data) aim to adopt aspects attainable within circumstances"*.

The rest of the chapter discusses three tools that can help you improve the reproducibility of your code: [Markdown](https://daringfireball.net/projects/markdown/), [RMarkdown](https://rmarkdown.rstudio.com/) and [Git](https://git-scm.com/).


## Markdown

A essential tool used in creating this book is [RMarkdown](https://rmarkdown.rstudio.com/) That is an R library that allows you to create scripts that mix the [Markdown](https://daringfireball.net/projects/markdown/) mark-up language and R, to create dynamic documents. RMarkdown script can be compiled, at which point, the Markdown notation is interpreted to create the output files, while the R code is executed and the output incorporated in the document.

For instance the following markdown code

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


### R Markdown

R code can be embedded in RMarkdown documents as in the example below. That results in the code chunk be displayed within the document (as *echo=TRUE* is specified), followed by the output from the execution of the same code.

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


## Exercise 224.1

Create a new R project named e.g. *Practical_224* as the directory name. Create an RMarkdown document in RStudio by selecting *File > New File > R Markdown ...* -- this might prompt RStudio to update some packages. On the RMarkdown document creation menu, specify "Practical 224" as title and your name as the author, and select *PDF* as default output format. 

The new document should contain the core document information, as in the example below, plus some additional content that simply explains how RMarkdown works.

```
---
title: "Practical 224"
author: "A. Student"
date: "4 November 2021"
output: pdf_document
---
```

Delete the contents below the document information and copy the following text below the document information. 

````
# Pipe example

This is my first [RMarkdown](https://rmarkdown.rstudio.com/) document.

```{r, echo=TRUE}
library(tidyverse)
```

The code uses the pipe operator:

- takes 2 as input
- calculates the square root
- rounds the value
    - keeping only two digits

```{r, echo=TRUE}
2 %>%
  sqrt() %>%
  round(digits = 2)
```
````

The option `echo=TRUE` tells RStudio to include the code in the output document, along with the output of the computation. If `echo=FALSE` is specified, the code will be omitted. If the option `message=FALSE` and `warning=FALSE` are added, messages and warnings from R are not displayed in the output document.

Save the document by selecting *File > Save* from the main menu. Enter *Square_root* as file name and click *Save*. The file is saved using the *Rmd* (RMarkdown) extension.

Click on the *Knit* button on the bar above the editor panel (top-left area) in RStudio, on the left side. Check the resulting *pdf* document. Try adding some of your own code (e.g., using some of the examples above) and Markdown text, and compile the document again.



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


## How to cite code

The UK's [Software Sustainability Institute](https://www.software.ac.uk/about) provides clear guidance about [how to cite software](https://www.software.ac.uk/how-cite-software) written by others. As outlined in the guidance, you should always cite and credit their work. However, using academic-style citations is not always straightforward when working with libraries, as most of them are not linked to an academic paper nor provide a [DOI](https://www.doi.org/). In such cases, you should at least include a link to the authors' website or repository in the script or final report when using a library. For instance, you can add a link to the Tidyverse's  [website](https://tidyverse.tidyverse.org/), [repository](https://github.com/tidyverse/tidyverse) or [CRAN page](https://cran.r-project.org/web/packages/tidyverse/index.html) when using the library. However, @tidyverse2019 also wrote a paper on their work on the Tidyverse for the [Journal of Open Source Software](https://joss.theoj.org/), so you can also cite their paper [using Bibtex in RMarkdown](https://bookdown.org/yihui/rmarkdown-cookbook/bibliography.html).

<!-- The two following paragraphs contain text adapted from text by Dr. Jorg D. Kaduk, jk61@leicester.ac.uk -->

Appropriate citations are even more important when directly copying or adapting code from others' work. Plagiarism principles apply to code as much as they do to text. The Massachusetts Institute of Technology (MIT)'s [*Academic Integrity at MIT: A Handbook for Students*](https://integrity.mit.edu/) includes a section on [writing code](https://integrity.mit.edu/handbook/writing-code) which provides good guidance on when and how to cite code that you include in your projects or you adapt for your own code properly. 
That also applies to re-using your own code, which you have written before. It is important that you refer to your previous work and fully acknowledge all previous work that has been used in a project so that others can find everything you have used in a project.

It is common practice to follow a particular referencing style for the in-text quotations, references and bibliography, such as the Harvard style (see, e.g., the [Harvard Format Citation Guide](https://www.mendeley.com/guides/harvard-citation-guide/) available [Mendeley](https://www.mendeley.com/)'s help pages). 
Following such guidelines will not only ensure that others can more easily use and reproduce your work but also that you demonstrate academic honesty and integrity.



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


---

<small>by [Stefano De Sabbata](https://sdesabbata.github.io/) -- text licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence), code licensed under the [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.html).</small>
