setwd("E:/OneDrive/Coursera/Exploratory Data Analysis with R/data")

library(ggplot2)
library(dplyr)

# (1) Reading all data (I put all data in the same map).

NEI <- readRDS("summarySCC_PM25.rds") 

SCC <- readRDS("Source_Classification_Code.rds")


# Get the subset of the NEI data that corresponds to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC,]

# Subset the vehicles NEI data to Baltimore's fip
vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]

# Making png and plotting plot5.

png("plot5.png",
    width=480,
    height=480,
    units="px",
    res=72)


plot5 <- ggplot(vehiclesBaltimoreNEI, aes(factor(year), Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  
  guides(fill=FALSE) +
  labs(x="year", y="Total PM2.5 emissions (tons)") + 
  labs(title="Baltimore City Motor Vehicle Emissions (1999-2008)")

print(plot5)

dev.off()