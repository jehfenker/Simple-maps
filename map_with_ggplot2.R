####      Jessica Fenker 2019        ####
#### Australian National University  ####
####    jehfenker@gmail.com          ####

## This script presents an easy way to plot a map with ggplot2

#install necessary packages
packages_to_install <- c("ggplot2","raster")
install.packages(packages_to_install)

#call the packages
library(maptools)
library(rgdal)

setwd("~/jessica/easy_map")

#####################
## IMPORT THE DATA ##
#####################

#background of the region (e.g. australia)
world <- map_data('world')

#import your data from CSV
australis <- read.csv("australis.csv")

#specify the colours for each species
# https://colorbrewer2.org/ has some colorblind options
sp_colors <- c("#8856a7", "#e66101","#a6dba0", "#abd9e9")


#######################
## PLOTTING THE DATA ##
#######################

#create a ggplot object
dist_map<-ggplot(world, aes(long, lat)) +
  #set map coordinates
  lims(x = c(122, 140.5), y = c(-20, -11.2))+
  #define the color of the land and outline
  geom_map(map=world, aes(map_id=region), fill="grey90", color="black") +
  #remove gridlines from the map
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        panel.background = element_blank(), axis.line = element_line(colour = "black"))+
  coord_quickmap()+ 
  #plot the species points on the map, color by the column that you want (in this case, species)
  geom_point(aes(x=long, y=lat, color = species, size = 1), data=australis)+
  #if you want, plot the species point border
  geom_point(aes(x=long, y=lat), color = "gray17", size = 4.5, pch=21, data=australis)+
  #colour the points using the colors you selected previously
  scale_color_manual(values=sp_colors) +
  #you can add/remove a legend, as wantes
  theme(legend.position='none')+
  #label the axes
  xlab("Longitude") + ylab("Latitude") +
  #map title
  ggtitle(label = "Species distribution", subtitle = "lizard complex") +
  #title location
  theme(plot.title = element_text(hjust = 0.5),plot.subtitle = element_text(hjust = 0.5))+
  #if you want, add a scalpe
  #annotation_scale(location = "br") +
  #add the north
  annotation_north_arrow(location = "br", which_north = "true", 
                         height = unit(1, "cm"), width = unit(1, "cm"),
                         pad_x = unit(0.05, "cm"), pad_y = unit(0.2, "cm"),
                         style = north_arrow_fancy_orienteering)+
   #add a border to your map
   theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_rect(colour = "black", fill="#f7fcfd", size=0.5))

# call the map
dist_map

#save the object as an PDF or SVG file
pdf("australis_map.pdf")
svg("australis_map.svg")

dev.off()


#Done!
