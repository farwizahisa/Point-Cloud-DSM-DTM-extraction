# install packages
install.packages("lidR")
install.packages("Rtools")
install.packages("rgdal")
install.packages("raster")
install.packages("RCSF")

# read library
library(lidR)
library(raster)
library(RCSF)

# directory and read point cloud data
setwd("PATH")
las = readLAS("MatureLAS_utm47.las")
plot(las)

# classify ground and nonground
las = classify_ground(las, csf())
plot(las, color = "Classification")

# normalize
las <-normalize_height(las, tin())

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
