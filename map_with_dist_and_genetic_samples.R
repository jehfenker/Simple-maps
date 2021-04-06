####      Jessica Fenker 2019        ####
#### Australian National University  ####
####    jehfenker@gmail.com          ####

## This script is an easy way to plot a distribution map
## of one species at a time, from a species list, diffenrentiating
## distribution samples and genetic data only. 


#call the packages
library(maptools)

#####################
## IMPORT THE DATA ##
#####################
southamerica <- readOGR("south_america.shp")
quartz()
plot(southamerica, xlim=c(-80,-33), ylim=c(-35,8), axes=TRUE)
biome <- readOGR("biome.shp")
plot(biome,xlim=c(-80,-33), ylim=c(-35,8), add=TRUE)
biome$NOME
cerrado <- subset(biome, NOME == "Cerrado")

#import your data from CSV
#first, all the distribution points
species <- read.csv("cerrado_jun17.csv", h=T)
head(species)
#now, points with genetic data only
samples <- read.csv("cerrado_mit_jun17.csv", h=T)
head(samples)

###long lat
species_latlong <- species
coordinates(species_latlong) <- ~long+lat
samples_latlong <- samples
coordinates(samples_latlong) <- ~long+lat


#######################
## PLOTTING THE DATA ##
#######################

#all the species in the list, at the same time
quartz()
plot(southamerica, xlim=c(-80,-33), ylim=c(-35,8), axes=TRUE)
plot(cerrado, xlim=c(-80,-30), ylim=c(-40,10), main= "", bty="o", axes=TRUE,col="lightgreen", add = T)
title (main = "All species")
points(species_latlong, col='black', pch = 16, cex=1)
points(samples_latlong, col='yellow', cex=1)

#subset for each species
T_itambere<- subset(species, especie == "Tropidurus_itambere")
samples_itambere<- subset(samples, especie == "Tropidurus_itambere")
coordinates(T_itambere) <- ~long+lat
coordinates(samples_itambere) <- ~long+lat

#plotting one species per time
plot(southamerica, xlim=c(-80,-33), ylim=c(-35,8), axes=TRUE)
plot(cerrado, xlim=c(-80,-30), ylim=c(-40,10), main= "", bty="o", axes=TRUE,col="lightgreen", add = T)
title (main = "Tropidurus itambere")
points(T_itambere, col='black', pch = 16, cex=1.5)
points(samples_itambere, col='yellow', pch = 16, cex=1.5)
points(samples_itambere, col='black', cex=1.5)


#save the object as an PDF or SVG file
pdf("Titambere_map.pdf")
svg("Titambere_map.svg")

#Done!
