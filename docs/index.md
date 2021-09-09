---
title: "R for Geographic Data Science"
author: "Stefano De Sabbata"
date: "2021-09-09"
site: bookdown::bookdown_site
documentclass: book
description: "R for Geographic Data Science"
url: 'https://sdesabbata.github.io/granolarr/'
biblio-style: apalike
csl: chicago-fullnote-bibliography.csl
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
## R version 4.1.1 (2021-08-10)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.3 LTS
## 
## Matrix products: default
## BLAS/LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.8.so
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
##  [1] knitr_1.33      xml2_1.3.2      magrittr_2.0.1  downlit_0.2.1  
##  [5] R6_2.5.1        rlang_0.4.11    fastmap_1.1.0   fansi_0.5.0    
##  [9] stringr_1.4.0   tools_4.1.1     xfun_0.25       utf8_1.2.2     
## [13] jquerylib_0.1.4 htmltools_0.5.2 ellipsis_0.3.2  yaml_2.2.1     
## [17] digest_0.6.27   tibble_3.1.4    lifecycle_1.0.0 crayon_1.4.1   
## [21] bookdown_0.23   sass_0.4.0      vctrs_0.3.8     fs_1.5.0       
## [25] evaluate_0.14   rmarkdown_2.10  stringi_1.7.4   compiler_4.1.1 
## [29] bslib_0.2.5.1   pillar_1.6.2    jsonlite_1.7.2  pkgconfig_2.0.3
```
