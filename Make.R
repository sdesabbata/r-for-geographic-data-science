##########
# Make file in R
# Author: Stefano De Sabbata
# Date: 12 July 2019
# Licensed under the GNU General Public License v3.0 https://www.gnu.org/licenses/gpl-3.0.html
##########

cat("\n\n>>> Making granolarr <<<\n\n")

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
source(paste0(Sys.getenv("RGDS_HOME"), "/Make_Clean.R"))

# Step 1: execute the scripts
#

# Step 3-2: Compile the practical files to bookdown

cat("\n\n>>> Rendering Practical sessions bookdown... <<<\n\n")

# Copy images directory to contents folder for local compile of bookdown
file.copy(paste0(Sys.getenv("RGDS_HOME"), "/src/images"), paste0(Sys.getenv("RGDS_HOME"), "/src/book/"), recursive=TRUE)

# Change working directory to the Practicals folder
setwd(paste0(Sys.getenv("RGDS_HOME"), "/src/book"))
# Render the book
bookdown::render_book("index.Rmd", c("bookdown::gitbook", "bookdown::pdf_book", "bookdown::epub_book"), new_session = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/"), quiet = TRUE)
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

cat("\n\n>>> granolarr is ready! <<<\n\n")


# Step 2-1: Compile the lecture files to html slides


# Copy images directory to contents folder for local compile of bookdown
file.copy(paste0(Sys.getenv("RGDS_HOME"), "/src/images"), paste0(Sys.getenv("RGDS_HOME"), "/src/slides/"), recursive=TRUE)

cat("\n\n>>> Rendering 101_L_Introduction.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/101_L_Introduction.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 102_L_CoreConcepts.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/102_L_CoreConcepts.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 103_L_Tidyverse.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/103_L_Tidyverse.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 111_L_DataTypes.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/111_L_DataTypes.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 112_L_ControlStructures.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/112_L_ControlStructures.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 113_L_Functions.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/113_L_Functions.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 201_L_DataFrames.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/201_L_DataFrames.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 202_L_SelectionFiltering.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/202_L_SelectionFiltering.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 203_L_DataManipulation.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/203_L_DataManipulation.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 211_L_DataJoin.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/211_L_DataJoin.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 212_L_TidyData.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/212_L_TidyData.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 213_L_ReadWrite.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/213_L_ReadWrite.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 221_L_Reproducibility.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/221_L_Reproducibility.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 222_L_RMarkdown.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/222_L_RMarkdown.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 223_L_Git.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/223_L_Git.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 301_L_DataVisualisation.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/301_L_DataVisualisation.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 302_L_DescriptiveStats.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/302_L_DescriptiveStats.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 303_L_ExploringAssumptions.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/303_L_ExploringAssumptions.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 311_L_ComparingMeans.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/311_L_ComparingMeans.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 312_L_Correlation.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/312_L_Correlation.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 313_L_DataTransformations.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/313_L_DataTransformations.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 321_L_Regression.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/321_L_Regression.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 322_L_RegressionMultiple.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/322_L_RegressionMultiple.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 323_L_RegressionLogistic.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/323_L_RegressionComparing.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 401_L_MachineLearningIntro.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/401_L_MachineLearningIntro.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 402_L_NeuralNetworks.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/402_L_NeuralNetworks.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 403_L_SupportVectorMachines.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/403_L_SupportVectorMachines.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 411_L_PrincipalComponents.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/411_L_PrincipalComponents.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 412_L_ClusteringCentroid.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/412_L_ClusteringCentroid.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))
cat("\n\n>>> Rendering 413_L_ClusteringHierarchicalDensity.Rmd <<<\n\n")
rmarkdown::render(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/413_L_ClusteringHierarchicalDensity.Rmd"), quiet = TRUE, output_dir = paste0(Sys.getenv("RGDS_HOME"), "/docs/slides"))

# Delete temporary images directory
unlink(paste0(Sys.getenv("RGDS_HOME"), "/src/slides/images"), recursive=TRUE)

