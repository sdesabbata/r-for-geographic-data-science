# R for Geographic Data Science

<img src="src/images/r-for-geographic-data-science-cover.png" class="cover" width="250" height="328"/>

This book is an introduction to geographic data science using `R`, which I designed as a companion for the module [GY7702 R for Data Science](https://le.ac.uk/modules/2021/gy7702) of the [MSc in Geographic Information Science](https://le.ac.uk/courses/geographical-information-science-msc/2021) at the [School of Geography, Geology, and the Environment](https://le.ac.uk/gge) of the [University of Leicester](https://le.ac.uk/). As such, it is very much *a work in progress*.



## Aims and learning objectives

The materials included in this book have been designed for a module focusing on the programming language R as an effective tool for data science for geographers. R is one of the most widely used programming languages, and it provides access to a vast repository of programming libraries, which cover all aspects of data science from data wrangling to statistical analysis, from machine learning to data visualisation. That includes a variety of libraries for processing spatial data, perform geographic information analysis, and create maps. As such, R is an extremely versatile, free and opensource tool in geographic information science, which combines the capabilities of traditional GIS software with the advantages of a scripting language, and an interface to a vast array of algorithms. 

The materials aim to cover the necessary skills in basic programming, data wrangling and reproducible research to tackle sophisticated but non-spatial data analyses. The first part of the module will focus on core programming techniques, data wrangling and practices for reproducible research. The second part of the module will focus on non-spatial data analysis approaches, including statistical analysis and machine learning.

The book and lecture slides use `#FFF0E2` as background colour to avoid the use of a pure white background, which can make reading more difficult and slower for people with dyslexia. All colours have also been checked for readability using [Colour Contrast Analyser](https://developer.paciellogroup.com/resources/contrastanalyser/).



## License and acknowledgements

[This work](https://github.com/sdesabbata/r-for-geographic-data-science) is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html) except where specified. The text is licensed under [Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)](https://creativecommons.org/licenses/by-sa/4.0/). See the [`src/images` foler](https://github.com/sdesabbata/r-for-geographic-data-science/tree/main/src/images) for information regarding the images used in the materials. Contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/) and information derived from data by sources such as the Office for National Statistics, Ministry of Housing, Communities & Local Government, Ofcom, and other institutions of the UK Government under the [Open Government License v3](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/) (see the [`data` folder](https://github.com/sdesabbata/r-for-geographic-data-science/tree/main/data) for further information).

This repository includes teaching materials that were created by me ([Dr Stefano De Sabbata](https://stefanodesabbata.com)) for the module [GY7702 R for Data Science](https://le.ac.uk/modules/2021/gy7702), while working at the [School of Geography, Geology, and the Environment](https://le.ac.uk/gge) of the [University of Leicester](https://le.ac.uk/). I would also like to acknowledge the contributions made to parts of these materials by [Prof Chris Brunsdon](https://www.maynoothuniversity.ie/people/chris-brunsdon) and [Prof Lex Comber](https://environment.leeds.ac.uk/geography/staff/1020/professor-lex-comber) (see also [An Introduction to R for Spatial Analysis and Mapping](https://uk.sagepub.com/en-gb/eur/an-introduction-to-r-for-spatial-analysis-and-mapping/book241031), Sage, 2015), [Dr Marc Padilla](https://scholar.google.com/citations?hl=en&user=NSxM1aEAAAAJ), and [Dr Nick Tate](https://www2.le.ac.uk/departments/geography/people/njt9), who convened previous versions of the module at the University of Leicester.

Last but not least, I would like to acknowledge the miriad of small contributions by users of many plaftforms, including the [Stack Exchange Network](https://stackexchange.com/) (e.g., [Stack Overflow](https://stackoverflow.com/), provided under [Creative Commons Attribution-Share Alike 2.5 Generic License](https://creativecommons.org/licenses/by-sa/2.5/)), who have both asked and answered many of the questions I had while coding this book. It would be impossible to trace back all their contributors through the pages, scripts and years, but they are there. The learning materials were created using [R](https://www.r-project.org/), [RStudio](https://www.rstudio.com/), [RMarkdown](https://rmarkdown.rstudio.com/) and [Bookdown](https://bookdown.org/) (with many thanks to [Yihui Xie](https://yihui.org/) for those fantastic tools and related documentation), and [GitHub](https://github.com/sdesabbata).



## Reproducibility

### Instructor

You can now reproduce R for Geographic Data Science using [Docker](https://www.docker.com/). First [install Docker](https://docs.docker.com/get-docker/) on your system, [install Git](https://git-scm.com/downloads) if not already installed, and [clone this repository from GitHub](https://github.com/sdesabbata/r-for-geographic-data-science). You can then either build the sdesabbata/r-for-geographic-data-science image running the `src/Docker_Build.sh` script or simply [pull the latest sdesabbata/r-for-geographic-data-science image from the Docker Hub](https://hub.docker.com/repository/docker/sdesabbata/r-for-geographic-data-science).

You should now have all the code and the computational environment to reproduce these materials, which can be done by running the script `src/Docker_Make.sh` (src/`Docker_Make_WinPowerShell.sh` on Windows using PowerShell). The script will instantiate a Docker container for the `sdesabbata/r-for-geographic-data-science` image, bind mount the repository folder to the container and execute `src/Make.R` on the container, clearing and re-making all the materials. The data used in the materials can be re-created from the original open data using the scripts in `src/utils`, as described in `data/README.md`.

For instance, in a unix-based system like Linux or Mac OS, you can reproduce R for Geographic Data Science using the following four commands:

```{bash, echo=TRUE, eval=FALSE}
docker pull sdesabbata/r-for-geographic-data-science:latest
git clone https://github.com/sdesabbata/r-for-geographic-data-science.git
cd r-for-geographic-data-science

# follow the instructions in data/README.md before continuing

./src/Docker_Make.sh
```

This approach should allow not simply to use the materials as they are, but to easily edit and create your own version in the same computational environment. To develop your own materials, simply modify the code in the repository and run the `src/Docker_Make.sh` from the repository folder again to obtain the updated materials. 

The [RMarkdown](https://rmarkdown.rstudio.com/) code used to create the materials for the book and lecture slides can be found in the `src/book` and `src/slides` folders, respectively. The files are used to generate the [Bookdown](https://bookdown.org/) book and [IOSlides](https://bookdown.org/yihui/rmarkdown/ioslides-presentation.html) slides. The `src/utils` folder contains the IOSlides templates and some style classes used in the RMarkdown code.

```{bash, echo=TRUE, eval=FALSE}
.
├── data
├── docs
    └── slides
└── src
    ├── book
    ├── images
    ├── practicals
    ├── slides
    └── utils
        ├── IOSlides
        └── RMarkdown
```

You can edit the materials in the `r-for-geographic-data-science` repository folder using RStudio or another editor on your computer and then compile the new materials using Docker. Alternatively, you can follow the *learner* instructions below to start RStudio Server using Docker, and develop your materials in the same environment in which they will be compiled. The first option might be quicker for minor edits, whereas the latter option might be preferable for substantial modifications, and especially when you might need to test your code.


### Learner

As a learner, you can use [Docker](https://www.docker.com/) to follow the practical sessions instructions and complete the exercises. First [install Docker](https://docs.docker.com/get-docker/) on your system, [install Git](https://git-scm.com/downloads) if not already installed, and [clone this repository from GitHub](https://github.com/sdesabbata/r-for-geographic-data-science). 

You can then either build the `sdesabbata/r-for-geographic-data-science` image running the `src/Docker_Build.sh` script or simply [pull the latest sdesabbata/r-for-geographic-data-science image from the Docker Hub](https://hub.docker.com/repository/docker/sdesabbata/r-for-geographic-data-science).You should now have all the code and the computational environment to reproduce these materials, which can be done by running the script `src/Docker_RStudio_Start.sh` (`src/Docker_RStudio_Start_WinPowerShell.sh` on Windows using PowerShell) from the repository folder. 


For instance, in a unix-based system like Linux or Mac OS, you can set up and start the r-for-geographic-data-science container using the following four commands:

```{bash, echo=TRUE, eval=FALSE}
docker pull sdesabbata/r-for-geographic-data-science:latest
git clone https://github.com/sdesabbata/r-for-geographic-data-science.git
cd r-for-geographic-data-science

# follow the instructions in data/README.md before continuing

./src/Docker_RStudio_Start.sh
```

The `src/Docker_RStudio_Start.sh` script will first create a `my_r-for-geographic-data-science` folder in the parent directory of the root directory of the repository (if it doesn't exitst). The script will then instantiate a Docker container for the `sdesabbata/r-for-geographic-data-science` image, bind mount the `my_r-for-geographic-data-science` folder and the `r-for-geographic-data-science` repository folder to the container and start an RStudio Server.

Using your browser, you can access the RStudio Server running from the Docker container by typing `127.0.0.1:28787` in your address bar, and using `rstudio` as username and `rstudio` as password. As the `my_r-for-geographic-data-science` folder is binded, everything that you will save in the the `my_r-for-geographic-data-science` folder in your home directory on RStudio Server will be saved on your computer. Everything else will be lost when the Docker container is stopped.

To stop the Docker container, running the script `src/Docker_RStudio_Stop.sh` (same on Windows using PowerShell) from the repository folder.

