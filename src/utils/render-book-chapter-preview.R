##########
# Author: Stefano De Sabbata
# Date: 03 October 2022
# Licensed under the GNU General Public License v3.0 https://www.gnu.org/licenses/gpl-3.0.html
##########

# Un comment the install.packages command below
# if Tidyverse is not installed
#install.packages("tidyverse")

# Load necessary libraries
library(rmarkdown)
library(bookdown)
library(here)
library(stringr)
library(lubridate)

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

cat("\n\n>>> Rendering preview... <<<\n\n")

# Copy images directory to contents folder for local compile of bookdown
file.copy(paste0(Sys.getenv("RGDS_HOME"), "/src/images"), paste0(Sys.getenv("RGDS_HOME"), "/src/book/"), recursive=TRUE)

# Change working directory to the Practicals folder
setwd(paste0(Sys.getenv("RGDS_HOME"), "/src/book"))
# Render preview
#bookdown::preview_chapter("index.Rmd", output_dir = "../../docs_preview")
bookdown::preview_chapter("101-Introduction.Rmd", output_dir = "../../docs_preview")
# Change back working directory
setwd(Sys.getenv("RGDS_HOME"))

# Delete temporary images directory
unlink(paste0(Sys.getenv("RGDS_HOME"), "/src/book/images"), recursive=TRUE)