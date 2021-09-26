##########
# Make file in R
# Author: Stefano De Sabbata
# Date: 12 July 2019
# Licensed under the GNU General Public License v3.0 https://www.gnu.org/licenses/gpl-3.0.html
##########

cat("\n\n>>> Making R for Geographic Data Science <<<\n\n")

# Un comment the install.packages command below
# if Tidyverse is not installed
#install.packages("tidyverse")

# Load necessary libraries
library(rmarkdown)
library(bookdown)
library(here)
library(stringr)
library(lubridate)

# Step 0:

# Setup
# Set home folder path as environment variable
# to be use as Knitr root dir

# Get Rscript arguments (if any)
args <- commandArgs(trailingOnly = TRUE)

# test if there is at least one argument: if not, return an error
if (length(args) == 0) {
  cat("No arguments, assuming current wd as RGDS_HOME:\n")
  cat(here())
  cat("\n\n")
  Sys.setenv(RGDS_HOME = here())
} else {
  args_RGDS_HOME <- ifelse(
    str_sub(args[1], -1, -1) == "/", 
    str_sub(args[1], 1, -2), 
    args[1]
    )
  cat("Setting RGDS_HOME to:\n")
  cat(args_RGDS_HOME)
  cat("\n\n")
  Sys.setenv(RGDS_HOME = args_RGDS_HOME)
}


# Make clean
source(paste0(Sys.getenv("RGDS_HOME"), "/src/Make_Clean.R"))

# Step 1: Book

cat("\n\n>>> Rendering book... <<<\n\n")

# Copy images directory to contents folder for local compile of bookdown
file.copy(paste0(Sys.getenv("RGDS_HOME"), "/src/images"), paste0(Sys.getenv("RGDS_HOME"), "/src/book/"), recursive=TRUE)

# Change working directory to the Practicals folder
setwd(paste0(Sys.getenv("RGDS_HOME"), "/src/book"))
# Render the book
#bookdown::render_book("index.Rmd", c("bookdown::gitbook", "bookdown::pdf_book", "bookdown::epub_book"), new_session = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/"), quiet = TRUE)
bookdown::render_book("index.Rmd", c("bookdown::bs4_book"), new_session = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/"), quiet = TRUE)
# Change back working directory
setwd(Sys.getenv("RGDS_HOME"))

# Delete temporary images directory
unlink(paste0(Sys.getenv("RGDS_HOME"), "/src/book/images"), recursive=TRUE)

# Rename pdf and epub files

# now_for_filename <- 
#   lubridate::now() %>% 
#   str_replace_all(":", "-")  %>% 
#   str_replace_all(" ", "_")

file.rename(
  paste0(Sys.getenv("RGDS_HOME"), "/docs/_main.pdf"), 
  paste0(Sys.getenv("RGDS_HOME"), "/docs/DeSabbata_R-for-geographic-data-science.pdf")
)
file.rename(
  paste0(Sys.getenv("RGDS_HOME"), "/docs/_main.epub"), 
  paste0(Sys.getenv("RGDS_HOME"), "/docs/DeSabbata_R-for-geographic-data-science.epub")
)

cat("\n\n>>> done. <<<\n\n")


# Step 2: Lecture slides

cat("\n\n>>> Rendering lecture slides... <<<\n\n")

# Copy images directory to contents folder for local compile of bookdown
file.copy(paste0(Sys.getenv("RGDS_HOME"), "/src/images"), paste0(Sys.getenv("RGDS_HOME"), "/src/slides/"), recursive=TRUE)

cat("\n\n>>> Rendering 101-introduction.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/101-introduction.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 102-core-concepts.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/102-core-concepts.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 103-tidyverse.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/103-tidyverse.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 111-data-types.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/111-data-types.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 112-control-structures.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/112-control-structures.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 113-functions.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/113-functions.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 201-data-frames.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/201-data-frames.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 202-selection-filtering.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/202-selection-filtering.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 203-data-manipulation.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/203-data-manipulation.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 211-data-join.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/211-data-join.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 212-tidy-data.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/212-tidy-data.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 213-read-write.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/213-read-write.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 221-reproducibility.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/221-reproducibility.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 222-rmarkdown.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/222-rmarkdown.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 223-git.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/223-git.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 301-data-visualisation.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/301-data-visualisation.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 302-descriptive-stats.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/302-descriptive-stats.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 303-exploring-assumptions.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/303-exploring-assumptions.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 311-comparing-means.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/311-comparing-means.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 312-correlation.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/312-correlation.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 313-data-transformations.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/313-data-transformations.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 321-regression.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/321-regression.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 322-regression-multiple.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/322-regression-multiple.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 323-regression-comparing.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/323-regression-comparing.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 401-machine-learning-intro.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/401-machine-learning-intro.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 402-neural-networks.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/402-neural-networks.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 403-support-vector-machines.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/403-support-vector-machines.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 411-principal-components.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/411-principal-components.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 412-clustering-centroid.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/412-clustering-centroid.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 413-clustering-hierarchical-density.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/413-clustering-hierarchical-density.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))

# Delete temporary images directory
unlink(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/images"), recursive=TRUE)

cat("\n\n>>> done. <<<\n\n")

cat("\n\n>>> R for Geographic Data Science is ready! <<<\n\n\n")