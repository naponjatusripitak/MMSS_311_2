# Set working directory
setwd("~/Documents/GitHub/MMSS_311_2/Lab Exercises/Week 1")

# Load packages
packages <- c("dplyr", "ggplot2", "lubridate", "stringr", "foreign")

load.packages <- function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE)
    library(x, character.only = TRUE)
  }
}

lapply(packages, load.packages)

# Import data
qog <- read.csv("http://www.qogdata.pol.gu.se/data/qog_std_cs_jan19.csv")

# Print info
print(dim(qog))