install.packages("lidR")
install.packages("Rtools")
install.packages("rgdal")
install.packages("raster")
install.packages("RCSF")

library(lidR)
library(raster)
library(RCSF)

setwd("C:/Users/Office/Documents/AAR/Project")
las = readLAS("MatureLAS_utm47.las")
plot(las)

las = classify_ground(las, csf())
plot(las, color = "Classification")

algo = pitfree(thresholds = c(0,10,20,30,40,50), subcircle = 0.2)
chm = grid_canopy(las, 0.5, algo)

#las <-normalize_height(las, tin())

# Extract ground points
ground_las <- las[las$Classification == 2, ]
plot(ground_las)

# Extract nonground points
nonground_las <- las[las$Classification != 2, ]
plot(nonground_las)

# Export ground points to a new LAS file
writeLAS(ground_las, "norm_ground_points.las")

# Export ground points to a new LAS file
writeLAS(nonground_las, "norm_nonground_points.las")

chm = nonground_las - ground_las
