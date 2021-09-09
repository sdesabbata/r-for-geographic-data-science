---
title: "R for Geographic Data Science"
author: "Stefano De Sabbata"
date: "2021-09-09"
description: "R for Geographic Data Science"
url: 'https://sdesabbata.github.io/granolarr/'
github-repo: "sdesabbata/granolarr"
site: bookdown::bookdown_site
documentclass: book
biblio-style: apalike
output:
  bookdown::gitbook:
    config:
      toc:
        before: |
          <li><a href="https://https://sdesabbata.github.io/r-for-geographic-data-science/">R for Geographic Data Science</a></li>
        after: |
          <li><a href="https://https://sdesabbata.github.io/r-for-geographic-data-science/">R for Geographic Data Science</a></li>
      search: yes
      download:
        - ["DeSabbata_R-for-geographic-data-science.pdf", "PDF"]
        - ["DeSabbata_R-for-geographic-data-science.epub", "EPUB"]
  bookdown::pdf_book:
     latex_engine: xelatex
---

# Preface {-}

*[Stefano De Sabbata](https://stefanodesabbata.com)*

[This work](https://github.com/sdesabbata/GY7702) is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html). Contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence).

This book contains the *practical sessions* component of [granolarr](https://github.com/sdesabbata/granolarr), a repository of reproducible materials to teach geographic information and data science in R. Part of the materials are derived from the practical sessions for the module [GY7702 Practical Programming in R](https://sdesabbata.github.io/GY7702/) of the [MSc in Geographic Information Science](https://le.ac.uk/courses/geographical-information-science-msc/2019) at the [School of Geography, Geology, and the Environment](https://le.ac.uk/gge) of the [University of Leicester](https://le.ac.uk/), by [Dr Stefano De Sabbata](https://stefanodesabbata.com/).

This book was created using [R](https://www.r-project.org/), [RStudio](https://www.rstudio.com/), [RMarkdown](https://rmarkdown.rstudio.com/), [Bookdown](https://bookdown.org/), and [GitHub](https://github.com/sdesabbata).



## Session info {-}

```r
sessionInfo()
```

```
## R version 4.0.2 (2020-06-22)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04 LTS
## 
## Matrix products: default
## BLAS/LAPACK: /usr/lib/x86_64-linux-gnu/openblas-openmp/libopenblasp-r0.3.8.so
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=C             
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## loaded via a namespace (and not attached):
##  [1] compiler_4.0.2  magrittr_1.5    bookdown_0.20   htmltools_0.5.0
##  [5] tools_4.0.2     yaml_2.2.1      stringi_1.4.6   rmarkdown_2.3  
##  [9] knitr_1.29      stringr_1.4.0   digest_0.6.25   xfun_0.16      
## [13] rlang_0.4.7     evaluate_0.14
```
