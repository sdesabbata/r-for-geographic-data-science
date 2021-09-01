##########
# This code uses data from the Office for National Statistics
# to create a small dataset containing all the 167 variables
# used in the 2011 OAC (https://github.com/geogale/2011OAC)
# for the Output Area in Leicester City
# Author: Stefano De Sabbata
# Date: 17 July 2019
# Licensed under the GNU General Public License v3.0 https://www.gnu.org/licenses/gpl-3.0.html
##########

# First create 2011_OAC_Raw_uVariables_Leicester.csv
# using the script Create_2011OAC_Leicester_dataset.R

readr::read_csv(
    paste0(
      Sys.getenv("RGDS_HOME"), 
      "/data/", 
      "2011_OAC_Raw_uVariables_Leicester.csv"
    )
  ) %>%
  dplyr::select(OA11CD,LSOA11CD, supgrpcode,supgrpname,Total_Population) %>%
  readr::write_csv(
    paste0(
      Sys.getenv("RGDS_HOME"), 
      "/data/", 
      "2011_OAC_supgrp_Leicester.csv"
    )
  )