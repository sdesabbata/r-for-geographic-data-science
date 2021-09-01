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
unlink(here("docs/*"), recursive = TRUE)
unlink(here("src/book/*.rds"))
unlink(here("src/book/*.md"))
unlink(here("src/book/*.html"))
unlink(here("src/book/*.tex"))
unlink(here("src/book/*.log"))
unlink(here("src/book/*.pdf"))
unlink(here("src/book/_bookdown_files"), recursive = TRUE)
unlink(here("src/book/images"), recursive = TRUE)