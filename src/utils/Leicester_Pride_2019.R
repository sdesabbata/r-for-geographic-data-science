##########
# This code creates a map of the Census Output Areas
# in Leicester with the Pride Flag colours
# Author: Stefano De Sabbata
# Date: 30 August 2019
# Licensed under the GNU General Public License v3.0 https://www.gnu.org/licenses/gpl-3.0.html
##########

library(tidyverse)
library(sp)
library(rgdal)
library(rgeos)
#library(tmap)
library(ggmap)
library(ggthemes)
library(ggplot2)

rm(list=ls())

# Create tmp dir if necessary
ifelse(!dir.exists(file.path(Sys.getenv("RGDS_HOME"), "/tmp")), dir.create(file.path(Sys.getenv("RGDS_HOME"), "/tmp")), FALSE)

if (!dir.exists(file.path(paste0(Sys.getenv("RGDS_HOME"), "/tmp"), "E06000016"))) {
  unzip(paste0(Sys.getenv("RGDS_HOME"), "/data/", "e06000016.zip"), exdir = "tmp")
}
if (!dir.exists(file.path(paste0(Sys.getenv("RGDS_HOME"), "/tmp"), "England_ct_2011_Leicestershire"))) {
  unzip(paste0(Sys.getenv("RGDS_HOME"), "/data/", "England_ct_2011_Leicestershire.zip"), exdir = "tmp")
}


# Load data
leic_2011OAC <- readOGR(paste0(Sys.getenv("RGDS_HOME"), "/tmp/E06000016/E06000016_Leicester.shp"))
leic_2011OAC <- spTransform(leic_2011OAC, CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
england_ct_2011 <- readOGR(paste0(Sys.getenv("RGDS_HOME"), "/tmp/England_ct_2011_Leicestershire/england_ct_2011_Leicestershire.shp"))
england_ct_2011 <- spTransform(england_ct_2011, CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))

# Calculate centroids
leic_2011OAC_coords <- coordinates(leic_2011OAC)

leic_2011OAC_centroids_coords <- data.frame(
    oa_code = leic_2011OAC$oa_code, 
    x = leic_2011OAC_coords[, 1],
    y = leic_2011OAC_coords[, 2]
  )

# Calculate overall span
leic_2011OAC_y_min <- min(leic_2011OAC_centroids_coords$y)
leic_2011OAC_y_max <- max(leic_2011OAC_centroids_coords$y)
leic_2011OAC_step <- (leic_2011OAC_y_max - leic_2011OAC_y_min) / 6

# Flag colours
lgbt_flag_colours_list <- c("#86007d", "#0000f9", "#008018", "#ffff41", "#ffa52c", "#ff0018")
lgbt_flag_colours <- data.frame(
  lgbt_flag_colour_val = c(1, 2, 3, 4, 5, 6),
  lgbt_flag_colour = lgbt_flag_colours_list
)

# Assign values
leic_2011OAC_centroids_coords$lgbt_flag_colour_val <- floor((leic_2011OAC_centroids_coords$y - leic_2011OAC_y_min) / leic_2011OAC_step) + 1
leic_2011OAC_centroids_coords$lgbt_flag_colour_val <- ifelse(leic_2011OAC_centroids_coords$lgbt_flag_colour_val>6, 6, leic_2011OAC_centroids_coords$lgbt_flag_colour_val)

# Merge with flag colours
leic_2011OAC_centroids_coords <- merge(leic_2011OAC_centroids_coords, lgbt_flag_colours, by = "lgbt_flag_colour_val")

# Merge back with OAs
leic_2011OAC <- merge(leic_2011OAC, leic_2011OAC_centroids_coords, by = "oa_code")
leic_2011OAC$lgbt_flag_colour <- as.character(leic_2011OAC$lgbt_flag_colour)
leic_2011OAC$lgbt_flag_colour_val <- as.factor(leic_2011OAC$lgbt_flag_colour_val)

leic_2011OAC_points = fortify(leic_2011OAC, region = "oa_code")
leic_2011OAC_df = merge(leic_2011OAC_points, leic_2011OAC@data, by.x = "id", by.y = "oa_code")

# Map
#tm_shape(leic_2011OAC) + 
#  tm_fill(col = "lgbt_flag_colour") +
#  tm_borders("gray40", alpha=.5) +
#  tm_layout(frame=FALSE) +
#tm_shape(england_ct_2011) +
#  tm_borders("black") +

# Leicester
ggmap(
    get_stamenmap(
      c(left = -1.225, bottom = 52.575, right = -1.0, top = 52.7),
      zoom = 13,
      maptype = "toner-lite"
    )
  )+ 
  geom_polygon(
    data = leic_2011OAC_df, 
    aes(
      x = long, 
      y = lat, 
      group = group,
      fill = lgbt_flag_colour_val,
      alpha = 0.5
    )
  ) +
  geom_path(
    data = leic_2011OAC_df, 
    aes(
      x = long, 
      y = lat, 
      group = group
    ),
    colour = "#969696",
    alpha = 0.5,
    size = 0.25
  ) +
  geom_path(
    data = england_ct_2011, 
    aes(
      x = long, 
      y = lat, 
      group = group
    ),
    colour = "#000000",
    alpha = 0.5
  ) +
  scale_fill_manual(values = lgbt_flag_colours_list) +
  guides(
    colour = FALSE,
    fill = FALSE,
    alpha = FALSE
  ) +
  xlab("") + ylab("") +
  theme(
    #legend.position = "bottom",
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank()
  )

# Clean
unlink(paste0(Sys.getenv("RGDS_HOME"), "/tmp/England_ct_2011_Leicestershire"), recursive = TRUE)
unlink(paste0(Sys.getenv("RGDS_HOME"), "/tmp/E06000016"), recursive = TRUE)
if(length(list.files(path = paste0(Sys.getenv("RGDS_HOME"), "/tmp"), include.dirs = TRUE)) == 0){
  unlink(paste0(Sys.getenv("RGDS_HOME"), "/tmp"), recursive = TRUE)
}
rm(list=ls())