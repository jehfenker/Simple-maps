####      Jessica Fenker 2019        ####
#### Australian National University  ####
####    jehfenker@gmail.com          ####

## This script is an easy way to plot a map with dismo and rgdal
## prettymapr is used for the north arrow


#install necessary packages
packages_to_install <- c("maptools","rgdal","prettymapr")
install.packages(packages_to_install)

#call the packages
library(maptools)
library(rgdal)
library(prettymapr)

setwd("~/jessica/maps")

#####################
## IMPORT THE DATA ##
#####################

sp_coord <- read.csv("species_coord.csv", header=TRUE, sep=",")
head(sp_coord)
coordinates(sp_coord)<-~long+lat

#import the shapefile
biome <- readOGR(".", "biome")
head(biome)
amazon <- subset(biome, NOME == "Amazônia")
cerrado <- subset(biome, NOME == "Cerrado")


##################
## PLOT THE MAP ##
##################

quartz(h=7, w=7)
data(wrld_simpl)
plot(wrld_simpl, xlim=c(-70, -40), ylim=c(-30, 5), lwd=0.25, axes=T, las=1)
plot(cerrado, col="grey75", lwd=0.01, add = T)
plot(amazonia, col="grey40", lwd=0.01, add=T)
#plot the points, with different colors by region
points(sp_coord, pch=21, cex = 2.25, col="black", bg=c("#dfc27d", "#80cdc1")[as.numeric(Region)])
legend(-48, 6, legend=c("Amazon", "Cerrado"), fill=c("#dfc27d", "#80cdc1"), bty="n", cex=1)
#if you want, add a scale bar
#addscalebar(pos ="bottomright")
addnortharrow(pos ="bottomright", scale = 0.5)

#Done!
