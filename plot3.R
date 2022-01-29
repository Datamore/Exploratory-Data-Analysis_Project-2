setwd("E:/OneDrive/Coursera/Exploratory Data Analysis with R/data")

# (1) Reading all data (I put all data in the same map).

NEI <- readRDS("summarySCC_PM25.rds") 

SCC <- readRDS("Source_Classification_Code.rds")


# (2) Subset NEI data by Baltimore's fip.

baltimoreNEI <- NEI[NEI$fips=="24510",]

# (3) Aggregate using sum the Baltimore emissions data by year.

aggTotalsBaltimore <- aggregate(Emissions ~ year, baltimoreNEI,sum)

# (4) Making a png, but using ggplot2 this time. 

png("plot3.png",width=480,height=480,units="px",res=72)

library(ggplot2)

ggp <- ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + 
  facet_grid(.~type, scales = "free", space="free") + 
  labs(x="year", y="Total PM2.5 Emissions (tons)") + 
  labs(title="Total Emissions in Baltimore City, Maryland from 1999 to 2008")

print(ggp)

dev.off()

