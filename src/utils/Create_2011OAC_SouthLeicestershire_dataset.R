##########
# This code uses data from the Office for National Statistics
# to create a small dataset containing all the 167 variables
# used in the 2011 OAC (https://github.com/geogale/2011OAC)
# for the Output Area in Rutland City
# Author: Stefano De Sabbata
# Date: 16 December 2020
# Licensed under the GNU General Public License v3.0 https://www.gnu.org/licenses/gpl-3.0.html
##########

# Download the file 2011 OAC Variables - 167 Initial.zip in the storage folder
# http://tiny.cc/OAC-Var-167

# Download the file OA11_LSOA11_MSOA11_LAD11_EW_LU.zip in the storage folder
# https://borders.ukdataservice.ac.uk/lut_download_data.html?data=oa11_lsoa11_msoa11_lad11_ew_lu

rm(list = ls())

library(tidyverse)
library(sp)
library(rgdal)

# Create tmp dir if necessary
ifelse(!dir.exists(file.path(Sys.getenv("RGDS_HOME"), "/tmp")), dir.create(file.path(Sys.getenv("RGDS_HOME"), "/tmp")), FALSE)

# Extract data files
if (!dir.exists(file.path(paste0(Sys.getenv("RGDS_HOME"), "/tmp"), "2011 OAC 167 Variables"))) {
  unzip(paste0(Sys.getenv("RGDS_HOME"), "/storage/2011 OAC Variables - 167 Initial.zip"), exdir = paste0(Sys.getenv("RGDS_HOME"), "/tmp"))
}
if (!dir.exists(file.path(paste0(Sys.getenv("RGDS_HOME"), "/tmp"), "OA11_LSOA11_MSOA11_LAD11_EW_LU"))) {
  dir.create(file.path(paste0(Sys.getenv("RGDS_HOME"), "/tmp"), "OA11_LSOA11_MSOA11_LAD11_EW_LU"))
  unzip(paste0(Sys.getenv("RGDS_HOME"), "/storage/OA11_LSOA11_MSOA11_LAD11_EW_LU.zip"), exdir = paste0(Sys.getenv("RGDS_HOME"), "/tmp/OA11_LSOA11_MSOA11_LAD11_EW_LU"))
}


# Load data

vars_2011OAC <- read_csv(paste0(Sys.getenv("RGDS_HOME"), "/tmp/2011 OAC 167 Variables/2011_OAC_Raw_uVariables.csv"))

areas_lookup <- read_csv(paste0(Sys.getenv("RGDS_HOME"), "/tmp/OA11_LSOA11_MSOA11_LAD11_EW_LU/OA11_LSOA11_MSOA11_LAD11_EW_LUv2.csv"),
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
  select(-LAD11NMW)

# Join data and write
areas_lookup %>%
  left_join(vars_2011OAC, by = c("OA11CD" = "OA")) %>%
  dplyr::filter(LAD11NM %in% c("Blaby", "Harborough", "Oadby and Wigston")) %>%
  write_csv(paste0(Sys.getenv("RGDS_HOME"), "/data/", "2011_OAC_Raw_uVariables_SouthLeicestershire.csv"))

# Clean
unlink(paste0(Sys.getenv("RGDS_HOME"), "/tmp/2011 OAC 167 Variables"), recursive = TRUE)
unlink(paste0(Sys.getenv("RGDS_HOME"), "/tmp/OA11_LSOA11_MSOA11_LAD11_EW_LU"), recursive = TRUE)
unlink(paste0(Sys.getenv("RGDS_HOME"), "/tmp/E06000017"), recursive = TRUE)
if(length(list.files(path = paste0(Sys.getenv("RGDS_HOME"), "/tmp"), include.dirs = TRUE)) == 0){
  unlink(paste0(Sys.getenv("RGDS_HOME"), "/tmp"), recursive = TRUE)
}

rm(list = ls())