# This script downloads 
#
# Output Areas (December 2021) Boundaries Generalised Clipped EW (BGC)
# https://geoportal.statistics.gov.uk/datasets/ons::output-areas-december-2021-boundaries-generalised-clipped-ew-bgc/about
#
# Contains both Ordnance Survey and ONS Intellectual Property Rights.
#
# Published Date: September 14, 2022 at 10:27 AM
# Source: Office for National Statistics licensed under the Open Government Licence v.3.0
# https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/
# Contains OS data © Crown copyright and database right 2022
#
#
# Output Areas (December 2011) Boundaries EW BGC
# https://geoportal.statistics.gov.uk/datasets/ons::output-areas-december-2011-boundaries-ew-bgc-1/about
#
# Contains both Ordnance Survey and ONS Intellectual Property Rights.
#
# Published Date: July 24, 2020
# Source: Office for National Statistics licensed under the Open Government Licence v.3.0
# https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/
# Contains OS data © Crown copyright and database right 2020
#
#
# >>> REQUIRES MANUAL DOWNLOAD OF: <<<
#
#
# save in /storage
#
#
# OAs to LSOAs to MSOAs (2021) to Local Enterprise Partnership to LAD (May 2022) Lookup in England
# https://geoportal.statistics.gov.uk/datasets/ons::oas-to-lsoas-to-msoas-2021-to-local-enterprise-partnership-to-lad-may-2022-lookup-in-england-/about
# https://geoportal.statistics.gov.uk/datasets/ons::oas-to-lsoas-to-msoas-to-lep-to-lad-may-2022-lookup-in-england/about
# 
# Contains both Ordnance Survey and ONS Intellectual Property Rights.
#
# Published Date: August 24, 2022
# Source: Office for National Statistics licensed under the Open Government Licence v.3.0
# https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/
# Contains OS data © Crown copyright and database right 2022
#
#
# Output Area to Lower Layer Super Output Area to Middle Layer Super Output Area to Local Authority District (December 2011) Lookup in England and Wales
# https://geoportal.statistics.gov.uk/datasets/ons::output-area-to-lower-layer-super-output-area-to-middle-layer-super-output-area-to-local-authority-district-december-2011-lookup-in-england-and-wales/about
# 
# Contains both Ordnance Survey and ONS Intellectual Property Rights.
#
# Published Date: October 25, 2018
# Source: Office for National Statistics licensed under the Open Government Licence v.3.0
# https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/
# Contains OS data © Crown copyright and database right 2018
#
#
# Author: Stefano De Sabbata
# Date: 04 November 2022


# Libraries ---------------------------------------------------------------

library(tidyverse)
library(magrittr)
library(sf)
library(jsonlite)



# Data download -----------------------------------------------------------

cat("Retrieving data\n")

lookup_Leicester_OA_2021 <- 
  read_csv("storage/OAs_to_LSOAs_to_MSOAs_(2021)_to_Local_Enterprise_Partnership_to_LAD_(May_2022)_Lookup_in_England_.csv") %>% 
  filter(LAD22NM == "Leicester")

for (i in 0:(
    lookup_Leicester_OA_2021 %>% 
    nrow() %>% 
    divide_by(50) %>% 
    floor()
)) {
  
  tmp_OAs <-
    lookup_Leicester_OA_2021 %>% 
    slice_tail(
      n = 
        lookup_Leicester_OA_2021 %>% 
        nrow() %>% 
        subtract(i * 50)
    ) %>% 
    slice_head(n = 50) %>% 
    pull(OA21CD) %>% 
    paste0(
      "OA21CD%20%3D%20'",
      .,
      "'%20OR%20",
      collapse = ""
    ) %>% 
    str_sub(end = -6) %>% 
    paste0(
      "https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Output_Areas_December_2021_Boundaries_EW_BGC/FeatureServer/0/query?where=%20(",
      .,
      ")%20&outFields=*&outSR=4326&f=json"
    ) %>% 
    st_read()
  
  if (i == 0){
    geom_Leicester_OAs <- tmp_OAs
  } else {
    geom_Leicester_OAs %<>%
      bind_rows(tmp_OAs)
  }
  
}

# Check
lookup_Leicester_OA_2021 %>% 
  select(OA21CD) %>% 
  anti_join(
    geom_Leicester_OAs %>% 
      st_drop_geometry() %>% 
      select(OA21CD)
  )

# Write
geom_Leicester_OAs %>% 
  left_join(lookup_Leicester_OA_2021) %>% 
  st_write("storage/Leicester_2021_OAs.geojson")


# Retrieving 2011 geometries

lookup_Leicester_OA_2011 <- 
  read_csv("storage/Output_Area_to_Lower_Layer_Super_Output_Area_to_Middle_Layer_Super_Output_Area_to_Local_Authority_District_(December_2011)_Lookup_in_England_and_Wales.csv") %>% 
  filter(LAD11NM == "Leicester")

for (i in 0:(
  lookup_Leicester_OA_2011 %>% 
  nrow() %>% 
  divide_by(50) %>% 
  floor()
)) {
  
  tmp_OAs <-
    lookup_Leicester_OA_2011 %>% 
    slice_tail(
      n = 
        lookup_Leicester_OA_2011 %>% 
        nrow() %>% 
        subtract(i * 50)
    ) %>% 
    slice_head(n = 50) %>% 
    pull(OA11CD) %>% 
    paste0(
      "OA11CD%20%3D%20'",
      .,
      "'%20OR%20",
      collapse = ""
    ) %>% 
    str_sub(end = -6) %>% 
    paste0(
      "https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Output_Areas_December_2011_Boundaries_EW_BGC/FeatureServer/0/query?where=%20(",
      .,
      ")%20&outFields=*&outSR=4326&f=json"
    ) %>% 
    st_read()
  
  if (i == 0){
    geom_Leicester_OAs <- tmp_OAs
  } else {
    geom_Leicester_OAs %<>%
      bind_rows(tmp_OAs)
  }
  
}

# Check
lookup_Leicester_OA_2011 %>% 
  select(OA11CD) %>% 
  anti_join(
    geom_Leicester_OAs %>% 
      st_drop_geometry() %>% 
      select(OA11CD)
  )

# Write
geom_Leicester_OAs %>% 
  left_join(lookup_Leicester_OA_2011) %>% 
  st_write("storage/Leicester_2011_OAs.geojson")


# Matching information
fromJSON("https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/OA11_OA21_EW_LU_V2/FeatureServer/0/query?where=LAD22NM%20%3D%20'LEICESTER'&outFields=*&outSR=4326&f=json") %$%
  features %$%
  attributes %>%
  write_csv("storage/Leicester_2011to2021_OAs.csv")

