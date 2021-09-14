---
title: "R for Geographic Data Science"
author: "Stefano De Sabbata"
date: "2021-09-14"
site: bookdown::bookdown_site
documentclass: book
cover-image: "images/r-for-geographic-data-science-cover.png"
description: "R for Geographic Data Science"
repo: "https://github.com/sdesabbata/r-for-geographic-data-science"
url: "https://sdesabbata.github.io/r-for-geographic-data-science/"
biblio-style: apalike
csl: chicago-fullnote-bibliography.csl
---


# Welcome {-}

<img src="images/r-for-geographic-data-science-cover.png" class="cover" width="250" height="328"/>This book is an introduction to geographic data science using `R`, which I designed as a companion for the module [GY7702 R for Data Science](https://le.ac.uk/modules/2021/gy7702) of the [MSc in Geographic Information Science](https://le.ac.uk/courses/geographical-information-science-msc/2021) at the [School of Geography, Geology, and the Environment](https://le.ac.uk/gge) of the [University of Leicester](https://le.ac.uk/). As such, it is very much *a work in progress*. [This work and related materials](https://github.com/sdesabbata/r-for-geographic-data-science) are licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html) (except where specified) and they contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence) (further details below). 

The materials included in this book have been designed for a module focusing on the programming language R as an effective tool for data science for geographers. R is one of the most widely used programming languages, and it provides access to a vast repository of programming libraries, which cover all aspects of data science from data wrangling to statistical analysis, from machine learning to data visualisation. That includes a variety of libraries for processing spatial data, perform geographic information analysis, and create maps. As such, R is an extremely versatile, free and opensource tool in geographic information science, which combines the capabilities of traditional GIS software with the advantages of a scripting language, and an interface to a vast array of algorithms. 

The materials aim to cover the necessary skills in basic programming, data wrangling and reproducible research to tackle sophisticated but non-spatial data analyses. The first part of the module will focus on core programming techniques, data wrangling and practices for reproducible research. The second part of the module will focus on non-spatial data analysis approaches, including statistical analysis and machine learning.

The book and lecture slides use `#FFF0E2` as background colour to avoid the use of a pure white background, which can make reading more difficult and slower for people with dyslexia. All colours have also been checked for readability using [Colour Contrast Analyser](https://developer.paciellogroup.com/resources/contrastanalyser/).

## License and acknowledgements {-}

[This work](https://github.com/sdesabbata/r-for-geographic-data-science) is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html) except where specified. Contains public sector information licensed under the [Open Government Licence v3.0](http://www.nationalarchives.gov.uk/doc/open-government-licence), see [`data / README.md`](https://github.com/sdesabbata/r-for-geographic-data-science/blob/master/data/README.md). See [`src / images / README.md`](https://github.com/sdesabbata/r-for-geographic-data-science/blob/master/src/images/README.md) for information regarding the images used in the materials. Some files in the Data folder have been derived from data by sources such as the Office for National Statistics, Ministry of Housing, Communities & Local Government, Ofcom, and other institutions of the UK Government under the [Open Government License v3](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/) -- see linked webpage above on the [National Archives website](http://www.nationalarchives.gov.uk/) or the *LICENSE* file in this folder).

This repository includes teaching materials that were created by [Dr Stefano De Sabbata](https://stefanodesabbata.com) for the module [GY7702 R for Data Science](https://le.ac.uk/modules/2021/gy7702), while working at the [School of Geography, Geology, and the Environment](https://le.ac.uk/gge) of the [University of Leicester](https://le.ac.uk/). Stefano would also like to acknowledge the contributions made to parts of these materials by [Prof Chris Brunsdon](https://www.maynoothuniversity.ie/people/chris-brunsdon) and [Prof Lex Comber](https://environment.leeds.ac.uk/geography/staff/1020/professor-lex-comber) (see also [An Introduction to R for Spatial Analysis and Mapping](https://uk.sagepub.com/en-gb/eur/an-introduction-to-r-for-spatial-analysis-and-mapping/book241031), Sage, 2015), [Dr Marc Padilla](https://scholar.google.com/citations?hl=en&user=NSxM1aEAAAAJ), and [Dr Nick Tate](https://www2.le.ac.uk/departments/geography/people/njt9), who conveened previous versions of the module (GY7022) at the University of Leicester.

Last but not least, I would like to acknowledge the miriad of small contributions by users of the [Stack Exchange Network](https://stackexchange.com/) (e.g., [Stack Overflow](https://stackoverflow.com/)), who have both asked and answered many of the questions I had while coding this book. It would be impossible to trace back all their contributors through the years, but they are there and have been provided under the [Creative Commons Attribution-Share Alike 2.5 Generic License](https://creativecommons.org/licenses/by-sa/2.5/).

This book was created using [R](https://www.r-project.org/), [RStudio](https://www.rstudio.com/), [RMarkdown](https://rmarkdown.rstudio.com/) and [Bookdown](https://bookdown.org/) (with many thanks to [Yihui Xie](https://yihui.org/) for those fantastic tools and related documentation), and [GitHub](https://github.com/sdesabbata).


## About me {-}

Hi there, my name is Stef and I am a [Lecturer in Quantitative Geography](http://www2.le.ac.uk/departments/geography/people/stefano-de-sabbata) at the [School of Geography, Geology and the Environment](http://www2.le.ac.uk/departments/geography) of the [University of Leicester](https://le.ac.uk/) and [Research associate](http://www.oii.ox.ac.uk/people/desabbata/) of the [Oxford Internet Institute](http://www.oii.ox.ac.uk/) of the [University of Oxford](http://www.ox.ac.uk/).

I am a geographic data scientist working at the intersection between human geography, artificial intelligence and internet studies. Most of my research focuses on three intertwined research streams: the development of machine learning approaches to geographic data analysis, the study of the geographies of content created through internet platforms, and the application of both to quantitative urban geography. I teach data science and programming in R, information visualization, geospatial databases and information retrieval, digital geographies and geographic information science. I am the secretary of the [Geographic Information Science Research Group](https://geoinfo.science/) of the [Royal Geographical Society with IBG](https://www.rgs.org/). I am also
part of the steering committee of [GIScience Research UK (GISRUK)](http://gisruk.org/) and I was the chair of the [GISRUK 2018 conference](http://leicester.gisruk.org/). I am a member of the [Commission on Location Based Services](http://lbs.icaci.org/) of the International Cartographic Association.

Earlier in my career, I worked as a Researcher at the [Oxford Internet Institute](http://www.oii.ox.ac.uk/) of the [University of Oxford](http://www.ox.ac.uk/) (2013-2015) and I was Junior Research Fellow at the [Wolfson College](https://www.wolfson.ox.ac.uk/) of the [University of Oxford](http://www.ox.ac.uk/) (2014-2015). I was awarded a PhD from the [Department of Geography](http://www.geo.uzh.ch/) of the [University of Zurich](http://www.uzh.ch/en.html) in 2013, and a BSc and a MSc in computer science from the Department of Mathematics and Computer Science of the [University of Udine](http://www.uniud.it/it).

You can find me on Twitter at [@maps4thought](https://twitter.com/maps4thought) and on GitHub at [sdesabbata](https://github.com/sdesabbata).
