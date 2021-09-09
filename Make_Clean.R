##########
# Make clean file in R
# Author: Stefano De Sabbata
# Date: 12 July 2019
# Licensed under the GNU General Public License v3.0 https://www.gnu.org/licenses/gpl-3.0.html
##########

# Load necessary libraries
library(here)

# Clean R Environment

rm(list = ls())

# Delete compiled files from R Markdown scripts
unlink(paste0(Sys.getenv("RGDS_HOME"), "/docs/*"), recursive = TRUE)
unlink(paste0(Sys.getenv("RGDS_HOME"), "/src/book/*.rds"))
unlink(paste0(Sys.getenv("RGDS_HOME"), "/src/book/*.md"))
unlink(paste0(Sys.getenv("RGDS_HOME"), "/src/book/*.html"))
unlink(paste0(Sys.getenv("RGDS_HOME"), "/src/book/*.tex"))
unlink(paste0(Sys.getenv("RGDS_HOME"), "/src/book/*.log"))
unlink(paste0(Sys.getenv("RGDS_HOME"), "/src/book/*.pdf"))
unlink(paste0(Sys.getenv("RGDS_HOME"), "/src/book/_bookdown_files"), recursive = TRUE)
unlink(paste0(Sys.getenv("RGDS_HOME"), "/src/book/images"), recursive = TRUE)