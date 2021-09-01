##########
# This code uses data from the Ministry of Housing, Communities & Local Government
# to create a small dataset containing the Indexes of Multiple deprivation 2015
# for the Output Area in Leicester City
# Author: Stefano De Sabbata
# Date: 17 July 2019
# Licensed under the GNU General Public License v3.0 https://www.gnu.org/licenses/gpl-3.0.html
##########

# Download the file containing the Indexes of Multiple deprivation 2015 in the Storage folder
# http://opendatacommunities.org/def/concept/folders/themes/societal-wellbeing
# Column name 'Indices of Deprivation' edited to 'IndicesOfDeprivation'

library(tidyverse)
library(sp)
library(rgdal)

# Create tmp dir if necessary
ifelse(!dir.exists(file.path(Sys.getenv("RGDS_HOME"), "/tmp")), dir.create(file.path(Sys.getenv("RGDS_HOME"), "/tmp")), FALSE)

if (!dir.exists(file.path(paste0(Sys.getenv("RGDS_HOME"), "/tmp"), "OA11_LSOA11_MSOA11_LAD11_EW_LU"))) {
  dir.create(file.path(paste0(Sys.getenv("RGDS_HOME"), "/tmp"), "OA11_LSOA11_MSOA11_LAD11_EW_LU"))
  unzip(
    paste0(Sys.getenv("RGDS_HOME"), "/Storage/OA11_LSOA11_MSOA11_LAD11_EW_LU.zip"), 
    exdir = paste0(Sys.getenv("RGDS_HOME"), "/tmp/OA11_LSOA11_MSOA11_LAD11_EW_LU")
  )
}


# Load data

imd2015_england <- read_csv(paste0(Sys.getenv("RGDS_HOME"), "/Storage/8babf8b5-cc36-44a5-acd0-0e7dac5bc84d.csv")) %>%
  mutate(IndicesOfDeprivation = str_sub(IndicesOfDeprivation, start = 4))

leicester_lsoa <- read_csv(paste0(Sys.getenv("RGDS_HOME"), "/tmp/OA11_LSOA11_MSOA11_LAD11_EW_LU/OA11_LSOA11_MSOA11_LAD11_EW_LUv2.csv"),
    col_types = cols(
      OA11CD = col_character(),
      LSOA11CD = col_character(),
      LSO11ANM = col_character(),
      MSOA11CD = col_character(),
      MSOA11NM = col_character(),
      LAD11CD = col_character(),
      LAD11NM = col_character(),
      LAD11NMW = col_character()
    )
  ) %>%
  filter(LAD11NM == "Leicester") %>%
  select(LSOA11CD) %>%
  unique()

# Join data and write
imd2015_leicester <-  imd2015_england %>%
  filter(FeatureCode %in% leicester_lsoa$LSOA11CD) %>%
  write_csv(paste0(Sys.getenv("RGDS_HOME"), "/data/", "IndexesMultipleDeprivation2015_Leicester.csv"))

# Clean
unlink(paste0(Sys.getenv("RGDS_HOME"), "/tmp/OA11_LSOA11_MSOA11_LAD11_EW_LU"), recursive = TRUE)
if(length(list.files(path = paste0(Sys.getenv("RGDS_HOME"), "/tmp"), include.dirs = TRUE)) == 0){
  unlink(paste0(Sys.getenv("RGDS_HOME"), "/tmp"), recursive = TRUE)
}